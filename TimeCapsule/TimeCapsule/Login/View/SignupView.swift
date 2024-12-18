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
        label.font = .systemFont(ofSize: 34, weight: .light)
        label.textColor = UIColor(named: "Gray9")
        
        return label
    }()
    
    private lazy var signupStackView: UIStackView = {
        let errorAndButtonStack = UIStackView(arrangedSubviews: [emailErrorLabel, emailVertifyButton])
        errorAndButtonStack.axis = .horizontal
        errorAndButtonStack.alignment = .trailing
        
        emailErrorLabel.numberOfLines = 2

        emailErrorLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
        }
        
        emailVertifyButton.snp.makeConstraints { make in
            make.width.equalTo(75)
            make.height.equalTo(33)
            make.trailing.equalToSuperview()
        }
        
        let emailStack = UIStackView(arrangedSubviews: [emailLabel, emailTextField, errorAndButtonStack])
        emailStack.axis = .vertical
        emailStack.spacing = 4
        emailStack.distribution = .equalSpacing // 간격 균일하게 분배
        emailStack.alignment = .fill // 스택의 크기에 맞춤
        
        emailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        errorAndButtonStack.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
        }
        
        
        let emailVertifyStack = UIStackView(arrangedSubviews: [emailVertifyLabel, emailVertifyTextField, emailVertifyErrorLabel])
        emailVertifyStack.axis = .vertical
        emailVertifyStack.spacing = 4
        
        emailVertifyStack.addSubview(emailVertifyCheckedButton)
        
        emailVertifyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
        }
        
        emailVertifyTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(100)
        }
        
        emailVertifyCheckedButton.snp.makeConstraints { make in
            make.centerY.equalTo(emailVertifyTextField) // TextField의 세로 중심과 Button의 세로 중심을 일치시킴
            make.leading.equalTo(emailVertifyTextField.snp.trailing).offset(20)
            make.height.equalTo(emailVertifyTextField)
            make.trailing.equalToSuperview()
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
            emailStack, emailVertifyStack, nicknameStack, passwordStack, passwordRepeatStack
        ])
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.spacing = 20
        
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
    
    public lazy var emailVertifyButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증번호 받기", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(named: "ThemeColor"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    public lazy var emailVertifyLabel: UILabel = {
        let label = createLabel(text: "인증번호")
        
        return label
    }()
    
    public lazy var emailVertifyTextField: UITextField = {
        let textField = createTextField(placeholder: "인증번호를 입력해주세요.")
        
        return textField
    }()
    
    public lazy var emailVertifyCheckedButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("확인", for: .normal)
        button.backgroundColor = UIColor(named: "ThemeColor")
        button.layer.cornerRadius = 12
        button.titleLabel?.textColor = UIColor(named: "Gray1")
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        
        return button
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
    public lazy var emailVertifyErrorLabel: UILabel = createErrorLabel()
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
            make.top.lessThanOrEqualTo(signupLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(51)
        }
        
        completeButton.snp.makeConstraints  { make in
//            make.top.lessThanOrEqualTo(signupStackView.snp.bottom).offset(42)
            make.trailing.leading.equalToSuperview().inset(95)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


