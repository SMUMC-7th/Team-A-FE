//
//  MyPageView.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/8/24.
//

import UIKit

class MyPageView: UIView {
    private lazy var userInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "계정 정보"
        label.font = .systemFont(ofSize: 34, weight: .light)
        label.textColor = UIColor(named: "Gray9")
        
        return label
    }()
    
    private lazy var userInfoContainerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    public lazy var userEmailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "Gray8")
        
        return label
    }()
    
    private lazy var userNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    public lazy var userNicknameInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "Gray8")
        
        return label
    }()
    
    private lazy var userInfoUnderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Gray4")
        
        return view
    }()
    
    private lazy var infoChangeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [editInfoButton, changePwdButton, logoutButton, withdrawButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    
    public lazy var editInfoButton: UIButton = createSettingButton(title: "정보 편집", color: "Gray6")
    public lazy var changePwdButton: UIButton = createSettingButton(title: "비밀번호 변경", color: "Gray6")
    public lazy var logoutButton: UIButton = createSettingButton(title: "로그아웃", color: "Gray6")
    public lazy var withdrawButton: UIButton = createSettingButton(title: "계정 탈퇴", color: "ErrorColor")
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    
    private func addComponents() {
        self.addSubview(userInfoLabel)
        self.addSubview(userInfoContainerView)
        userInfoContainerView.addSubview(userEmailLabel)
        userInfoContainerView.addSubview(userEmailInfoLabel)
        userInfoContainerView.addSubview(userNicknameLabel)
        userInfoContainerView.addSubview(userNicknameInfoLabel)
        
        self.addSubview(userInfoUnderLineView)
        self.addSubview(infoChangeStackView)
        
        userInfoLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        
        userInfoContainerView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(userInfoLabel.snp.bottom).offset(60)
            make.width.lessThanOrEqualTo(241)
            make.height.lessThanOrEqualTo(58)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        userEmailInfoLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
        }
        
        userNicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(userEmailLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview()
        }
        
        userNicknameInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(userEmailInfoLabel.snp.bottom).offset(24)
            make.trailing.equalToSuperview()
        }
        
        userInfoUnderLineView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(userInfoContainerView.snp.bottom).offset(24)
            make.height.equalTo(1)
            make.width.equalTo(257)
            make.centerX.equalToSuperview()
        }
        
        infoChangeStackView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(userInfoUnderLineView.snp.bottom).offset(24)
            make.width.lessThanOrEqualTo(201)
            make.height.lessThanOrEqualTo(163)
            make.leading.trailing.equalToSuperview().inset(55)
        }
        
    }
    
    private func createSettingButton(title: String, color: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(named: color), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.contentHorizontalAlignment = .left
        
        let config = UIImage.SymbolConfiguration(pointSize: 11)
        let arrorImage = UIImage(systemName: "chevron.right", withConfiguration: config)
        button.setImage(arrorImage, for: .normal)
        button.tintColor = UIColor(named: "Gray6")
        
        button.semanticContentAttribute = .forceRightToLeft  // 텍스트 왼쪽, 이미지 오른쪽으로 정렬
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)

        return button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
