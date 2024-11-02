//
//  HomeView.swift
//  TimeCapsule
//
//  Created by 이승준 on 10/31/24.
//

import UIKit

class HomeView: UIView {
    
    //MARK: - Header : Title, SubTitle, ProfileImage
    private lazy var headerContainer: UIView = {
        let view = UIView()
        //view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "나의 캡슐"
        title.font = .systemFont(ofSize: 34)
        return title
    }()
    
    private lazy var openedCapsulesLabel: UILabel = {
        let title = UILabel()
        title.text = "현재 3개 열림"
        title.font = .systemFont(ofSize: 14)
        title.textColor = UIColor.gray4
        return title
    }()
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "DefaultProfile")
        return image
    }()
    
    //MARK: - SegmentedControl
    // Segmented 는 디자인을 구현하기 위해 제약이 많음
    // StackView 를 쓰는게 맞음
    
    private lazy var buttonContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    public lazy var onlyOpened: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 0.2
        button.layer.borderColor = UIColor.gray9.cgColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        button.setTitle("열린 캡슐 보기", for: .normal)
        button.setTitleColor(.gray9, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        
        button.backgroundColor = .white
        return button
    }()
    
    public lazy var onlyClosed: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 0.2
        button.layer.borderColor = UIColor.gray9.cgColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        button.setTitle("닫힌 캡슐 보기", for: .normal)
        button.setTitleColor(.gray9, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()

    
    //MARK: - CollectionView
    public var tiemCapsuleCollectionView : UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        // 
        flow.estimatedItemSize = .init(width: 156, height: 156)
        flow.minimumLineSpacing = 20
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.backgroundColor = .clear
        collection.isScrollEnabled = true
        collection.register(TimeCapsuleCollectionViewCell.self,
                            forCellWithReuseIdentifier: TimeCapsuleCollectionViewCell.identifier)
        
        return collection
    }()

    
    //MARK: - Floating Button
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        print(self.bounds.width)
        if self.bounds.width < 320 {
            self.addComponents(padding: 20)
        } else {
            self.addComponents(padding: 30)
        }
    }
    
    private func addComponents(padding: Int) {
        //MARK: - Header Title & Subtitle & Profile
        self.addSubview(headerContainer)
        self.addSubview(buttonContainer)
        
        headerContainer.addSubview(titleLabel)
        headerContainer.addSubview(openedCapsulesLabel)
        headerContainer.addSubview(profileImage)
        
        //MARK: - Tags & Filter
        buttonContainer.addSubview(onlyOpened)
        buttonContainer.addSubview(onlyClosed)
        
        //MARK: - CollectionView
        self.addSubview(tiemCapsuleCollectionView)
        
        //MARK: - Floating Button Constraints
        headerContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        openedCapsulesLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
            make.height.width.equalTo(44)
        }
        
        //MARK: Tags & Filter Constraints
        buttonContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(33)
            make.top.equalTo(headerContainer.snp.bottom).offset(20)
        }

        onlyOpened.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.leading.top.bottom.equalToSuperview()
        }
        
        onlyClosed.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.trailing.top.bottom.equalToSuperview()
        }
        
        tiemCapsuleCollectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(buttonContainer.snp.bottom).offset(30)
        }
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

import SwiftUI

#Preview {
    HomeViewController()
}
