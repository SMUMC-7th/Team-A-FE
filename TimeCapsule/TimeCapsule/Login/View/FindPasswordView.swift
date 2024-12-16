//
//  FindPasswordView.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/4/24.
//

import UIKit

class FindPasswordView: UIView {
    private lazy var findPasswordLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "비밀번호 찾기"
        label.font = .systemFont(ofSize: 34, weight: .light)
        label.textColor = UIColor(named: "Gray9")
        
        return label
    }()
    
    private lazy var emailStackView: UIStackView = {
        let emailStack = UIStackView(arrangedSubviews: [emailLabel, emailTextField, emailErrorLabel])
        emailStack.axis = .vertical
        emailStack.spacing = 4
        emailErrorLabel.numberOfLines = 2
        
        emailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        return emailStack
    }()
    
    
    private lazy var emailLabel: UILabel = {
        let label = createLabel(text: "이메일")
        
        return label
    }()
    
    public lazy var emailTextField: UITextField = {
        let textField = createTextField(placeholder: "이메일을 입력해주세요.")
        
        return textField
    }()
    
    public lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("보내기", for: .normal)
        button.backgroundColor = UIColor(named: "ThemeColor")
        button.layer.cornerRadius = 12
        button.titleLabel?.textColor = UIColor(named: "Gray1")
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    private lazy var vertifyCodeStackView: UIStackView = {
        let vertifyCodeStack = UIStackView(arrangedSubviews: [vertifyCodeLabel, vertifyCodeTextField, vertifyCodeErrorLabel])
        vertifyCodeStack.axis = .vertical
        vertifyCodeStack.spacing = 4
        vertifyCodeErrorLabel.numberOfLines = 2
        
        vertifyCodeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
        }
        
        vertifyCodeTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        return vertifyCodeStack
    }()
    
    private lazy var vertifyCodeLabel: UILabel = {
        let label = createLabel(text: "인증번호")
        
        return label
    }()
    
    public lazy var vertifyCodeTextField: UITextField = {
        let textField = createTextField(placeholder: "인증번호을 입력해주세요.")

        return textField
    }()
    
    public lazy var emailErrorLabel: UILabel = createErrorLabel()
    public lazy var vertifyCodeErrorLabel: UILabel = createErrorLabel()
    
    public lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 변경하기", for: .normal)
        button.backgroundColor = UIColor(named: "ThemeColor")
        button.layer.cornerRadius = 12
        button.titleLabel?.textColor = UIColor(named: "Gray1")
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addComponents()
    }
    
    private func addComponents() {
        self.addSubview(findPasswordLabel)
        self.addSubview(emailStackView)
        self.addSubview(sendButton)
        
        self.addSubview(vertifyCodeStackView)
        self.addSubview(changePasswordButton)
        
        findPasswordLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(262)
            make.centerX.equalToSuperview()
        }
        
        emailStackView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(findPasswordLabel.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(51)
        }
        
        
        sendButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(emailStackView.snp.bottom).offset(12)
            make.trailing.equalTo(emailStackView)
            make.leading.equalToSuperview().offset(239)
            make.height.equalTo(33)
            make.width.lessThanOrEqualTo(85)
        }
        
        vertifyCodeStackView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(sendButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(51)
        }
        
        changePasswordButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(vertifyCodeStackView.snp.bottom).offset(82)
            make.trailing.leading.equalToSuperview().inset(95)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
