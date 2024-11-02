//
//  HomeViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 10/31/24.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        homeView.tiemCapsuleCollectionView.delegate = self
        homeView.tiemCapsuleCollectionView.dataSource = self
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
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
