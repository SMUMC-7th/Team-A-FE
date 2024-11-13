//
//  HomeViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 10/31/24.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    var selectedTag: UIButton?
    var selectedState: UIButton?
    // 로그인 성공하면 삭제
    
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
        
        // Login 성공하면 실행
//      guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
//          print("Error: No access token found.")
//          return
//      }
        
        TimeCapsulePreviewService.shared.fetchTimeCapsules(accessToken: K.String.accessToken) { result in
            switch result {
            case .success(let timeCapsules):
                //print("타임캡슐 조회 성공: \(timeCapsules)")
                TimeCapsulePreviewModel.original = timeCapsules
                TimeCapsulePreviewModel.filtered = timeCapsules
                //print(timeCapsules)
                DispatchQueue.main.async {
                    self.homeView.tiemCapsuleCollectionView.reloadData()
                }
            case .failure(let error):
                print("타임캡슐 조회 실패: \(error.localizedDescription)")
                // 에러 처리를 수행합니다.
            }
        }
    }
}

//MARK: Button Actions
extension HomeViewController {
    private func defineButtonActions() {
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
        // let addVC = AddCapsuleViewController()
        // navigationController?.pushViewController(addVC, animated: true)
    }
    
    @objc
    private func handleTagButtonTap(_ sender: UIButton) {
        if selectedTag == nil || selectedTag?.tag != sender.tag { // 새로운 버튼 선택
            homeView.forEachButton { button in
                updateTagButtonAppearance(button, isSelected: button.tag == sender.tag)
            }
            selectedTag = sender
            // sender에 해당하는 태그 선택
        } else { // 이미 선택된 버튼을 다시 탭한 경우
            updateTagButtonAppearance(sender, isSelected: false)
            selectedTag = nil
            // CollectionViewCell 전체 선택
        }
        TimeCapsulePreviewModel.filter()
        DispatchQueue.main.async {
            self.homeView.tiemCapsuleCollectionView.reloadData()
        }
    }
    
    func updateTagButtonAppearance(_ sender: UIButton, isSelected: Bool) {
        sender.backgroundColor = isSelected ? .theme : .white
        sender.tintColor = isSelected ? .white : .gray9
    }
    
    @objc
    private func toggleCapsuleViewButton(_ sender: UIButton) {
        let other = sender.tag == 0 ?  homeView.onlyOpened : homeView.onlyClosed // 남은 한 놈을 other에 반환
        if selectedState == nil || selectedState?.tag != sender.tag { // 새로운 버튼 선택
            selectedState = sender
            
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = sender.tag == 0 ? .unavailable : .available
            other.setTitleColor(.gray9, for: .normal)
            other.backgroundColor = .white
            
            // sender에 해당하는 CollectionViewCell 선택
        } else { // 이미 선택한 버튼을 다시 탭한 경우
            // 선택 취소
            selectedState = nil
            sender.setTitleColor(.gray9, for: .normal)
            sender.backgroundColor = .white
            other.setTitleColor(.gray9, for: .normal)
            other.backgroundColor = .white
            // CollectionViewCell 전체 선택
        }
        TimeCapsulePreviewModel.filter()
        DispatchQueue.main.async {
            self.homeView.tiemCapsuleCollectionView.reloadData()
        }
    }

    
    @objc
    private func presentToMyPage() {
        let myPageVC = MyPageViewController()
        myPageVC.modalPresentationStyle = .fullScreen
        present(myPageVC, animated: true)
    }
    
    
}

//MARK: CollectionView
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 셀 터치 시 수행할 동작
        print("Cell tapped at index: \(indexPath.row)")
        
        // 예: 상세 뷰 표시
        // let detailVC = CapsuleDetailViewController()
        // let item: Capsule = Capsule()
        // detailVC.configuration(item)
        // navigationController?.pushViewController(detailVC, animated: true)
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
            TimeCapsulePreviewService.shared.fetchTimeCapsules(accessToken: K.String.accessToken) { result in
                switch result {
                case .success(let timeCapsules):
                    //print("타임캡슐 조회 성공: \(timeCapsules)")
                    TimeCapsulePreviewModel.original = timeCapsules
                    //print(timeCapsules)
                    DispatchQueue.main.async {
                        self.homeView.tiemCapsuleCollectionView.reloadData()
                    }
                case .failure(let error):
                    print("타임캡슐 조회 실패: \(error.localizedDescription)")
                    // 에러 처리를 수행합니다.
                }
            }
        }
        
        present(alertVC, animated: true, completion: nil)
    }
    
}




import SwiftUI

#Preview {
    HomeViewController()
}
