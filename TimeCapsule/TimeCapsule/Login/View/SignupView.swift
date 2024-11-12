//
//  SignUpView.swift
//  TimeCapsule
//
//  Created by 김민지 on 10/30/24.
//

import UIKit
import SnapKit

class SignupView: UIView {
    
    private lazy var signupLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Sign Up"
        label.font = .systemFont(ofSize: 42, weight: .light)
        label.textColor = UIColor(named: "Gray9")
        
        return label
    }()
    
    private lazy var signupStackView: UIStackView = {
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
        
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        let nicknameStack = UIStackView(arrangedSubviews: [nicknameLabel, nicknameTextField, nicknameErrorLabel])
        nicknameStack.axis = .vertical
        nicknameStack.spacing = 4
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        let passwordStack = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField, passwordErrorLabel])
        passwordStack.axis = .vertical
        passwordStack.spacing = 4
        
        passwordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        let passwordRepeatStack = UIStackView(arrangedSubviews: [passwordRepeatLabel, passwordRepeatTextField, passwordRepeatErrorLabel])
        passwordRepeatStack.axis = .vertical
        passwordRepeatStack.spacing = 4
        
        passwordRepeatLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
        }
        
        passwordRepeatTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        let mainStackView = UIStackView(arrangedSubviews: [
            emailStack, nicknameStack, passwordStack, passwordRepeatStack
        ])
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.spacing = 30
        
        return mainStackView
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = createLabel(text: "이메일")
        
        return label
    }()
    
    public lazy var emailTextField: UITextField = {
        let textField = createTextField(placeholder: "이메일을 입력해주세요.")
        
        return textField
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = createLabel(text: "닉네임")
        
        return label
    }()
    
    public lazy var nicknameTextField: UITextField = {
        let textField = createTextField(placeholder: "닉네임을 입력해주세요.")

        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = createLabel(text: "비밀번호")

        return label
    }()
    
    public lazy var passwordTextField: UITextField = {
        let textField = createTextField(placeholder: "비밀번호를 입력해주세요.")
        
        return textField
    }()
    
    private lazy var passwordRepeatLabel: UILabel = {
        let label = createLabel(text: "비밀번호 재입력")

        return label
    }()
    
    public lazy var passwordRepeatTextField: UITextField = {
        let textField = createTextField(placeholder: "비밀번호를 재입력해주세요.")
        
        return textField
    }()
    
    public lazy var emailErrorLabel: UILabel = createErrorLabel()
    public lazy var nicknameErrorLabel: UILabel = createErrorLabel()
    public lazy var passwordErrorLabel: UILabel = createErrorLabel()
    public lazy var passwordRepeatErrorLabel: UILabel = createErrorLabel()
    
    public lazy var completeButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("완료", for: .normal)
        button.backgroundColor = UIColor(named: "ThemeColor")
        button.layer.cornerRadius = 12
        button.titleLabel?.textColor = UIColor(named: "Gray1")
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    private func addComponents() {
        addSubview(signupLabel)
        addSubview(signupStackView)
        addSubview(completeButton)
        
        signupLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(138)
            make.centerX.equalToSuperview()
        }
        
        signupStackView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(signupLabel.snp.bottom).offset(52)
            make.leading.trailing.equalToSuperview().inset(51)
        }
        
        completeButton.snp.makeConstraints  { make in
            make.top.lessThanOrEqualTo(signupStackView.snp.bottom).offset(82)
            make.trailing.leading.equalToSuperview().inset(95)
            make.height.equalTo(50)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


