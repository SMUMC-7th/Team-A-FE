//
//  HomeView.swift
//  TimeCapsule
//
//  Created by 이승준 on 10/31/24.
//

import UIKit

class HomeView: UIView {
    
    // 버튼이 눌린 동작에 대한 선택
    var onTagSelected: ((String) -> Void)?
    public var tagButtons: [UIButton] = []
        
    //MARK: - Header : Title, SubTitle, ProfileImage
    private lazy var headerContainer: UIView = {
        let view = UIView()
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
        title.textColor = UIColor.gray6
        return title
    }()
    
    public lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "DefaultProfile"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    //MARK: - Tags & Filter
    //Segmented 는 디자인을 구현하기 위해 제약이 많음
    //StackView 를 쓰는게 맞음
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.bouncesVertically = false
        return scrollView
    }()
        
    public let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var buttonContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    public lazy var onlyOpened: UIButton = {
        let button = UIButton()
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray3.cgColor
        button.backgroundColor = .gray11
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        button.setTitle("열린 캡슐 보기", for: .normal)
        button.setTitleColor(.gray9, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        
        button.backgroundColor = .white
        button.tag = CapsuleToggle.opend.rawValue
        return button
    }()
    
    public lazy var onlyClosed: UIButton = {
        let button = UIButton()
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray3.cgColor
        button.backgroundColor = .gray11
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        button.setTitle("닫힌 캡슐 보기", for: .normal)
        button.setTitleColor(.gray9, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.tag = CapsuleToggle.closed.rawValue
        return button
    }()
    
    //MARK: - CollectionView
    public var tiemCapsuleCollectionView : UICollectionView = {
        let flow = LeftAlignedCollectionViewFlowLayout()
        
        flow.estimatedItemSize = .init(width: 156, height: 156)
        flow.minimumLineSpacing = 20
    
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.backgroundColor = .clear
        collection.isScrollEnabled = true
        collection.register(TimeCapsulePreviewCollectionViewCell.self,
                            forCellWithReuseIdentifier: TimeCapsulePreviewCollectionViewCell.identifier)
        collection.showsVerticalScrollIndicator = false
        collection.isScrollEnabled = true
        return collection
    }()
    
    //MARK: - Floating Button
    public lazy var addCapsuleButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.addCapsuleButton, for: .normal)
        button.contentMode = .scaleAspectFill
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray2
        self.addHeaderComponents()
        self.addTagButtons()
        self.addCollectionView(padding: self.bounds.width <= 375 ? 27 : 40)
        self.addFloatingButton()
    }
    
    //MARK: - Header Title & Subtitle & Profile Constraints
    private func addHeaderComponents() {
        self.addSubview(headerContainer)
        
        headerContainer.addSubview(titleLabel)
        headerContainer.addSubview(openedCapsulesLabel)
        headerContainer.addSubview(profileButton)
        
        headerContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        openedCapsulesLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
        }
        
        profileButton.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
            make.height.width.equalTo(44)
        }
    }
    
    //MARK: - Tag & Toggle Buttons
    private func addTagButtons() {
        self.addSubview(scrollView)
        self.addSubview(buttonContainer)
        
        //MARK: - Tags & Filter
        scrollView.addSubview(stackView)
        buttonContainer.addSubview(onlyOpened)
        buttonContainer.addSubview(onlyClosed)
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(headerContainer.snp.bottom).offset(20)
            make.height.equalTo(34)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        createButtons()
        
        buttonContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(33)
            make.top.equalTo(scrollView.snp.bottom).offset(20)
        }

        onlyOpened.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.leading.top.bottom.equalToSuperview()
        }
        
        onlyClosed.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.trailing.top.bottom.equalToSuperview()
        }
        
    }
    
    //MARK: - CollectionView
    private func addCollectionView(padding: Int) {
        self.addSubview(tiemCapsuleCollectionView)
        
        tiemCapsuleCollectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(buttonContainer.snp.bottom).offset(30)
        }
    }
    
    //MARK: - Floating Button Constraints
    private func addFloatingButton() {
        self.addSubview(addCapsuleButton)
        
        addCapsuleButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.width.equalTo(140)
        }
    }
    
    private func createButtons() {
        var num = 0
        for tag in K.String.tags {
            let button = UIButton(type: .system)
            button.backgroundColor = .gray11
            button.setTitle(tag, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.gray3.cgColor
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.tintColor = .gray9
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
            button.tag = num
            num += 1
            tagButtons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    public func forEachButton(_ action: (UIButton) -> Void) {
        stackView.arrangedSubviews.compactMap { $0 as? UIButton }.forEach(action)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

import SwiftUI

#Preview {
    HomeViewController()
}
