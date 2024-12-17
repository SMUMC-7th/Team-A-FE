//
//  HomeViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 10/31/24.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    let networkCheck = NetworkConnectionCheck()
    
    private var homeView: HomeView = {
        let view = HomeView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        homeView.tiemCapsuleCollectionView.delegate = self
        homeView.tiemCapsuleCollectionView.dataSource = self
        self.defineButtonActions()
        
        //Login 성공하면 실행
        guard let token = KeychainService.load(for: "RefreshToken") else {
            print("Error: No Refresh Token found.")
            return
        }
        
        guard let fcmToken = KeychainService.load(for: "FCMToken") else {
            return
        }

        FCMTokenManager.shared.sendFCMToken(fcmToken: fcmToken, token: token)
        //        guard let fcmToken = KeychainService.load(for: "FCMToken") else {
        //            print("Error: No FCM Token found.")
        //            return
        //        }
        
        
        
        //        print("FCM is \(fcmToken)")
        
        //        FCMTokenManager.shared.sendFCMToken(fcmToken: fcmToken, token: token)
        
        
        if TimeCapsulePreviewModel.hasNext {
            fetchdataPagination()
            TimeCapsulePreviewService.shared.fetchTimeCapsulesPagination(token: token) { result in
                switch result {
                case .success(let timeCapsules):
                    //print("타임캡슐 조회 성공: \(timeCapsules)")
                    TimeCapsulePreviewModel.original = timeCapsules
                    TimeCapsulePreviewModel.filtered = timeCapsules
                    TimeCapsulePreviewModel.filter()
                    //print(timeCapsules)
                    DispatchQueue.main.async {
                        self.homeView.tiemCapsuleCollectionView.reloadData()
                    }
                case .failure(let error):
                    print("타임캡슐 조회 실패: \(error.localizedDescription)")
                    // 에러 처리를 수행합니다.
                }
            }
            print("First Fetch")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchdata()
    }
}

//MARK: Set Button Actions
extension HomeViewController {
    private func defineButtonActions() {
        self.homeView.sortStandardButton.addTarget(self, action: #selector(showSortMenu), for: .touchUpInside)
        self.homeView.addCapsuleButton.addTarget(self, action: #selector(stackAddCapsuleView), for: .touchUpInside)
        self.homeView.forEachButton { button in
            button.addTarget(
                self, action: #selector(handleTagButtonTap(_:)), for: .touchUpInside)
        }
        
        self.homeView.onlyOpened.addTarget(
            self, action: #selector(toggleCapsuleViewButton(_:)), for: .touchUpInside)
        self.homeView.onlyClosed.addTarget(
            self, action: #selector(toggleCapsuleViewButton(_:)), for: .touchUpInside)
        self.homeView.profileButton.addTarget(
            self, action: #selector(presentToMyPage), for: .touchUpInside)
    }
    
    @objc
    private func stackAddCapsuleView() {
        let addVC = CapsuleCreationViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    @objc
    private func handleTagButtonTap(_ sender: UIButton) {
        if TimeCapsulePreviewModel.selectedTag == nil || TimeCapsulePreviewModel.selectedTag?.tag != sender.tag { // 새로운 버튼 선택
            homeView.forEachButton { button in
                updateTagButtonAppearance(button, isSelected: button.tag == sender.tag)
            }
            TimeCapsulePreviewModel.selectedTag = sender
            // sender에 해당하는 태그 선택
        } else { // 이미 선택된 버튼을 다시 탭한 경우
            updateTagButtonAppearance(sender, isSelected: false)
            TimeCapsulePreviewModel.selectedTag = nil
            // CollectionViewCell 전체 선택
        }
        TimeCapsulePreviewModel.filter()
        reloadCollectionView()
    }
    
    func updateTagButtonAppearance(_ sender: UIButton, isSelected: Bool) {
        sender.backgroundColor = isSelected ? .theme : .white
        sender.tintColor = isSelected ? .white : .gray9
    }
    
    @objc
    private func toggleCapsuleViewButton(_ sender: UIButton) {
        let other = sender.tag == 0 ?  homeView.onlyOpened : homeView.onlyClosed // 남은 한 놈을 other에 반환
        // UI
        if TimeCapsulePreviewModel.selectedState == nil || TimeCapsulePreviewModel.selectedState?.tag != sender.tag { // 새로운 버튼 선택
            TimeCapsulePreviewModel.selectedState = sender
            
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = sender.tag == 0 ? .unavailable : .available
            other.setTitleColor(.gray9, for: .normal)
            other.backgroundColor = .white
            
            // sender에 해당하는 CollectionViewCell 선택
        } else { // 이미 선택한 버튼을 다시 탭한 경우
            // 선택 취소
            TimeCapsulePreviewModel.selectedState = nil
            sender.setTitleColor(.gray9, for: .normal)
            sender.backgroundColor = .white
            other.setTitleColor(.gray9, for: .normal)
            other.backgroundColor = .white
            // CollectionViewCell 전체 선택
        }
        
        // Logic
        TimeCapsulePreviewModel.filter()
        reloadCollectionView()
    }
    
    
    @objc
    private func presentToMyPage() {
        let myPageVC = MyPageViewController()
        navigationController?.pushViewController(myPageVC, animated: true)
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.homeView.tiemCapsuleCollectionView.reloadData()
        }
    }
}

//MARK: Sort Button Actions
extension HomeViewController {
    @objc private func showSortMenu() {
        let sortByCreatedAsc = UIAction(title: "생성일 오름차순") { [weak self] _ in
            self?.createdDateAsc()
        }
        
        let sortByCreatedDesc = UIAction(title: "생성일 내림차순") { [weak self] _ in
            self?.createdDateDesc()
        }
        
        let sortByDeadlineAsc = UIAction(title: "열림 오름차순") { [weak self] _ in
            self?.deadlineAsc()
        }
        
        let sortByDeadlineDesc = UIAction(title: "열림 내림차순") { [weak self] _ in
            self?.deadlineDesc()
        }
        
        let sortByNameAsc = UIAction(title: "이름 오름차순") { [weak self] _ in
            self?.nameAsc()
        }
        
        let sortByNameDesc = UIAction(title: "이름 내림차순") { [weak self] _ in
            self?.nameDesc()
        }
        
        let menu = UIMenu(title: "정렬 기준", children: [
            sortByCreatedAsc,
            sortByCreatedDesc,
            sortByDeadlineAsc,
            sortByDeadlineDesc,
            sortByNameAsc,
            sortByNameDesc,
        ])
        
        homeView.sortStandardButton.menu = menu
        homeView.sortStandardButton.showsMenuAsPrimaryAction = true
    }
        
    // MARK: - Sort Methods
    private func createdDateAsc() {
        TimeCapsulePreviewModel.sortByCreatedDateAsc()
        reloadCollectionView()
    }

    private func createdDateDesc() {
        TimeCapsulePreviewModel.sortByCreatedDateDesc()
        reloadCollectionView()
    }
    
    private func deadlineAsc() {
        TimeCapsulePreviewModel.sortByDeadlineAsc()
        reloadCollectionView()
    }
    
    private func deadlineDesc() {
        TimeCapsulePreviewModel.sortByDeadlineDesc()
        reloadCollectionView()
    }
    
    private func nameAsc() {
        TimeCapsulePreviewModel.sortByNameAsc()
        reloadCollectionView()
    }
    
    private func nameDesc() {
        TimeCapsulePreviewModel.sortByNameDesc()
        reloadCollectionView()
    }

}

//MARK: API Communication
extension HomeViewController {
    func fetchdata() {
        guard let token = KeychainService.load(for: "RefreshToken") else {
            print("Error: No Refresh Token found.")
            return
        }
        
        TimeCapsulePreviewService.shared.fetchTimeCapsulesPagination(token: token) { result in // API 호출
            switch result {
            case .success(let timeCapsules):
                TimeCapsulePreviewModel.fetchTimeCapsulePreviews(new: timeCapsules)
                DispatchQueue.main.async {
                    self.homeView.tiemCapsuleCollectionView.reloadData()
                }
            case .failure(let error):
                print("타임캡슐 조회 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchdataPagination() {
        guard let token = KeychainService.load(for: "RefreshToken") else {
            print("Error: No Refresh Token found.")
            return
        }
        
        TimeCapsulePreviewService.shared.fetchTimeCapsulesPagination(token: token) { result in // API 호출
            switch result {
            case .success(let timeCapsules):
                TimeCapsulePreviewModel.fetchTimeCapsulePreviews(new: timeCapsules)
                TimeCapsulePreviewModel.removeDuplicate()
                DispatchQueue.main.async {
                    self.homeView.tiemCapsuleCollectionView.reloadData()
                }
            case .failure(let error):
                print("타임캡슐 조회 실패: \(error.localizedDescription)")
            }
        }
    }
}

//MARK: CollectionView
extension HomeViewController: UICollectionViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight - 100 { // 하단에 가까워졌을 때
            if TimeCapsulePreviewModel.hasNext {
                print("Fetch Called")
                fetchdataPagination()
            }
            // Scroll is going down
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { // 셀 터치 시 수행할 동작
        let capsulePreview = TimeCapsulePreviewModel.filtered[indexPath.row]
        let capsulePreviewID = capsulePreview.id
        
        if (capsulePreview.isOpened) {
            // 예: 상세 뷰 표시
            let detailVC = CapsuleViewController(capsuleID: capsulePreviewID)
            detailVC.modalPresentationStyle = .fullScreen // Optional: Set to full screen if needed
            self.present(detailVC, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        TimeCapsulePreviewModel.filtered.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TimeCapsulePreviewCollectionViewCell.identifier, for: indexPath) as? TimeCapsulePreviewCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let data = TimeCapsulePreviewModel.filtered[indexPath.row]
        cell.configuration(data: data, delegate: self)
        return cell
    }
}

//MARK: Cell Deletion
extension HomeViewController: TimeCapsulePreviewCollectionViewCellDelegate {
    func didPressedDeleteButton(from data: TimeCapsulePreview) {
        showCustomAlert(data: data)
    }
    
    func showCustomAlert(data: TimeCapsulePreview) {
        let alertVC = DeletionAlertViewController()
        alertVC.data = data
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        
        alertVC.didConfirmDeletion = {
            
            guard let token = KeychainService.load(for: "RefreshToken") else {
                return
            }
            TimeCapsulePreviewService.shared.fetchTimeCapsules(token: token) { result in
                switch result {
                case .success(let timeCapsules):
                    TimeCapsulePreviewModel.fetchTimeCapsulePreviews(new: timeCapsules)
                    DispatchQueue.main.async {
                        self.homeView.tiemCapsuleCollectionView.reloadData()
                    }
                case .failure(let error):
                    print("타임캡슐 조회 실패: \(error.localizedDescription)")
                }
            }
        }
        
        present(alertVC, animated: true, completion: nil)
    }
    
}
