//
//  LoginView.swift
//  TimeCapsule
//
//  Created by 김민지 on 10/30/24.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    private lazy var logoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "Logo")

        return imageView
    }()
    
    private lazy var loginLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Login"
        label.font = .systemFont(ofSize: 42, weight: .light)
        
        return label
    }()
    
    private lazy var loginStackView: UIView = {
        let view = UIView()

        return view
    }()
    
    private lazy var emailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "이메일"
        
        return label
    }()
    
    public lazy var emailTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "이메일을 입력해주세요."
        textField.layer.borderWidth = 0.2
        textField.layer.cornerRadius = 12
        textField.font = .systemFont(ofSize: 14)
        
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "비밀번호"

        return label
    }()
    
    public lazy var passwordTextField: UITextField = {
        let textField: UITextField = UITextField()
        
        return textField
    }()
    
    private lazy var passwordFindLabel: UILabel = {
        let label: UILabel = UILabel()
        
        return label
    }()
    
    public lazy var passwordWrongLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "비밀번호가 틀렸습니다"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .red
        
        return label
    }()
    
    public lazy var emailLoginButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("로그인", for: .normal)
        
        return button
    }()
    
    private lazy var loginUnderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    public lazy var naverLoginButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("네이버로 로그인", for: .normal)
        
        return button
    }()
    
    public lazy var kakaoLoginButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("카카오로 로그인", for: .normal)
        
        return button
    }()
    
    private lazy var registerLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "계정이 없으신가요?"
        
        return label
    }()
    
    public lazy var registerButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .clear
        button.setTitle("계정 만들기", for: .normal)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    
    private func addComponents() {
        self.addSubview(logoImageView)
        self.addSubview(loginLabel)
        
        self.addSubview(emailLabel)
        self.addSubview(emailTextField)
        self.addSubview(passwordLabel)
        self.addSubview(passwordTextField)
        
        self.addSubview(passwordFindLabel)
        self.addSubview(passwordWrongLabel)


        
        logoImageView.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(100)
            make.width.height.lessThanOrEqualTo(120)
            make.centerX.equalToSuperview()
        }
        
        loginLabel.snp.makeConstraints  { make in
            make.top.lessThanOrEqualTo(logoImageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
} 
