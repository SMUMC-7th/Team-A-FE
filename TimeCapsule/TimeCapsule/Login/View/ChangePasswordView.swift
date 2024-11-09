//
//  ChangePasswordView.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/4/24.
//

import UIKit

class ChangePasswordView: UIView {
    private lazy var changePasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 변경"
        label.font = .systemFont(ofSize: 42, weight: .light)
        label.textColor = UIColor(named: "Gray9")
        
        return label
    }()
    
    private lazy var changePasswordStackView: UIStackView = {
        let newPasswordStack = UIStackView(arrangedSubviews: [newPasswordLabel, newPasswordTextField])
        newPasswordStack.axis = .vertical
        newPasswordStack.spacing = 4
        
        newPasswordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
        }
        
        newPasswordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        let passwordRepeatStack = UIStackView(arrangedSubviews: [passwordRepeatLabel, passwordRepeatTextField])
        passwordRepeatStack.axis = .vertical
        passwordRepeatStack.spacing = 4
        
        passwordRepeatLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
        }
        
        passwordRepeatTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        let mainStackView = UIStackView(arrangedSubviews: [
            newPasswordStack, passwordRepeatStack
        ])
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.spacing = 30
        
        return mainStackView
    }()
        
    
    private lazy var newPasswordLabel: UILabel = {
        let label = createLabel(text: "새 비밀번호")
        
        return label
    }()
    
    public lazy var newPasswordTextField: UITextField = {
        let textField = createTextField(placeholder: "비밀번호를 입력해주세요")
        
        return textField
    }()
    
    private lazy var passwordRepeatLabel: UILabel = {
        let label = createLabel(text: "비밀번호 확인")
        
        return label
    }()
    
    public lazy var passwordRepeatTextField: UITextField = {
        let textField = createTextField(placeholder: "비밀번호를 입력해주세요")
        
        return textField
    }()
    
    public lazy var changePasswordButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("확인", for: .normal)
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
        addSubview(changePasswordLabel)
        addSubview(changePasswordStackView)
        addSubview(changePasswordButton)
        
        changePasswordLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        
        changePasswordStackView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(changePasswordLabel.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(51)
        }
        
        changePasswordButton.snp.makeConstraints  { make in
            //make.top.lessThanOrEqualTo(changePasswordStackView.snp.bottom).offset(50)
            make.trailing.leading.equalToSuperview().inset(95)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualToSuperview().inset(60)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


