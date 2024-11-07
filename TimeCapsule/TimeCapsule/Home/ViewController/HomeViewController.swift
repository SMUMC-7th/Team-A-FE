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
    }
    
}

//MARK: Button Actions
extension HomeViewController {
    private func defineButtonActions() {
        self.homeView.addCapsuleButton.addTarget(
            self, action: #selector(stackAddCapsuleView), for: .touchUpInside)
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
        TimeCapsuleModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TimeCapsuleCollectionViewCell.identifier, for: indexPath) as? TimeCapsuleCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let data = TimeCapsuleModel.data[indexPath.row]
        cell.configuration(data: data)
        return cell
    }
}

import SwiftUI

#Preview {
    HomeViewController()
}
