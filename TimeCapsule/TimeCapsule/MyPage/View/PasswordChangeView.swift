//
//  PasswordChangeView.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/13/24.
//

import UIKit

class PasswordChangeView: UIView {
    private lazy var pwdChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 변경"
        label.font = .systemFont(ofSize: 34, weight: .light)
        label.textColor = UIColor(named: "Gray9")
        
        return label
    }()
    
    private lazy var PwdChangeStackView: UIStackView = {
        let currentpasswordStack = UIStackView(arrangedSubviews: [currentPasswordLabel, currentPasswordTextField, currentPasswordErrorLabel])
        currentpasswordStack.axis = .vertical
        currentpasswordStack.spacing = 4
        
        currentPasswordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
        }
        
        currentPasswordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        let newpasswordStack = UIStackView(arrangedSubviews: [newPasswordLabel, newPasswordTextField, newPasswordErrorLabel])
        newpasswordStack.axis = .vertical
        newpasswordStack.spacing = 4
        
        newPasswordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
        }
        
        newPasswordTextField.snp.makeConstraints { make in
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
        
        let mainStack = UIStackView(arrangedSubviews: [currentpasswordStack, newpasswordStack, passwordRepeatStack])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        
        return mainStack
    }()
    
    private lazy var currentPasswordLabel: UILabel = {
        let label = createLabel(text: "기존 비밀번호")

        return label
    }()
    
    public lazy var currentPasswordTextField: UITextField = {
        let textField = createTextField(placeholder: "기존 비밀번호를 입력해주세요.")
        
        return textField
    }()
    
    private lazy var newPasswordLabel: UILabel = {
        let label = createLabel(text: "비밀번호")

        return label
    }()
    
    public lazy var newPasswordTextField: UITextField = {
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
    
    public lazy var completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = UIColor(named: "ThemeColor")
        button.layer.cornerRadius = 12
        button.titleLabel?.textColor = UIColor(named: "Gray1")
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    public lazy var currentPasswordErrorLabel: UILabel = createErrorLabel()
    public lazy var newPasswordErrorLabel: UILabel = createErrorLabel()
    public lazy var passwordRepeatErrorLabel: UILabel = createErrorLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    private func addComponents() {
        addSubview(pwdChangeLabel)
        addSubview(PwdChangeStackView)
        addSubview(completeButton)
        
        pwdChangeLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(35)
            make.centerX.equalToSuperview()
        }
        
        PwdChangeStackView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(pwdChangeLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        completeButton.snp.makeConstraints  { make in
            make.trailing.leading.equalToSuperview().inset(95)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualToSuperview().inset(35)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
