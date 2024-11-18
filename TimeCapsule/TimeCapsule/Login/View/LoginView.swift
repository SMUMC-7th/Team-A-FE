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
        imageView.image = UIImage(named: "AppLogo")
        
        return imageView
    }()
    
    private lazy var loginLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Login"
        label.font = .systemFont(ofSize: 42, weight: .light)
        label.textColor = UIColor(named: "Gray9")
        
        return label
    }()
    
    private lazy var loginStackView: UIView = {
        let view = UIView()

        return view
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = createLabel(text: "이메일")
        
        return label
    }()
    
    public lazy var emailTextField: UITextField = {
        let textField = createTextField(placeholder: "이메일을 입력해주세요.")
        
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = createLabel(text: "비밀번호")

        return label
    }()
    
    public lazy var passwordTextField: UITextField = {
        let textField = createTextField(placeholder: "비밀번호을 입력해주세요.")
        
        return textField
    }()
    
    public lazy var findPasswordButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(named: "Gray7"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    public lazy var loginErrorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "이메일 또는 비밀번호가 틀렸습니다"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "ErrorColor")
        label.textAlignment = .center
        
        return label
    }()
    
    public lazy var emailLoginButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = UIColor(named: "ThemeColor")
        button.layer.cornerRadius = 12
        button.titleLabel?.textColor = UIColor(named: "Gray1")
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    private lazy var loginUnderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Gray4")
        
        return view
    }()
    
    public lazy var naverLoginButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("네이버로 로그인", for: .normal) 
        button.backgroundColor = .white
        button.layer.borderColor = UIColor(named: "Gray7")?.cgColor
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 0.2
        button.setTitleColor(UIColor(named: "Gray8"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        let naverLogo = UIImage(named: "Naver")
        button.setImage(naverLogo, for: .normal)
        button.imageView?.frame = CGRect(x: 0 , y: 0, width: 16, height: 16)
        button.contentHorizontalAlignment = .leading
        button.contentVerticalAlignment = .center
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        
        return button
    }()
    
    public lazy var kakaoLoginButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("카카오로 로그인", for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor(named: "Gray7")?.cgColor
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 0.2
        button.setTitleColor(UIColor(named: "Gray8"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)

        let kakaoLogo = UIImage(named: "Kakao")
        button.setImage(kakaoLogo, for: .normal)
        button.imageView?.frame = CGRect(x: 0 , y: 0, width: 16, height: 16)
        button.contentHorizontalAlignment = .leading
        button.contentVerticalAlignment = .center
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        
        
        return button
    }()
    
    private lazy var registerLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "계정이 없으신가요?"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "Gray9")
        
        return label
    }()
    
    public lazy var registerButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .clear
        button.setTitle("계정 만들기", for: .normal)
        button.setTitleColor(UIColor(named: "ThemeColor"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)

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
        
        self.addSubview(findPasswordButton)

        self.addSubview(loginErrorLabel)
        self.addSubview(emailLoginButton)
        self.addSubview(loginUnderLineView)
        
        self.addSubview(naverLoginButton)
        self.addSubview(kakaoLoginButton)
        
        self.addSubview(registerLabel)
        self.addSubview(registerButton)

        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(71)
            make.width.height.lessThanOrEqualTo(120)
            make.centerX.equalToSuperview()
        }
        
        loginLabel.snp.makeConstraints  { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(61)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints  { make in
            make.top.lessThanOrEqualTo(loginLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(59)
        }
        
        emailTextField.snp.makeConstraints  { make in
            make.top.lessThanOrEqualTo(emailLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(51)
            make.height.equalTo(49)
            make.width.lessThanOrEqualTo(273)
        }
        
        passwordLabel.snp.makeConstraints  { make in
            make.top.lessThanOrEqualTo(emailTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(59)
        }
        
        passwordTextField.snp.makeConstraints  { make in
            make.top.lessThanOrEqualTo(passwordLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(51)
            make.height.equalTo(49)
            make.width.lessThanOrEqualTo(273)
        }
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(passwordTextField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(250)
            make.trailing.equalTo(passwordTextField)
        }
        
        loginErrorLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(findPasswordButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(95)
        }
        
        emailLoginButton.snp.makeConstraints  { make in
            make.top.lessThanOrEqualTo(loginErrorLabel.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview().inset(95)
            make.height.equalTo(48)
            make.width.lessThanOrEqualTo(185)
        }
        
        loginUnderLineView.snp.makeConstraints  { make in
            make.top.lessThanOrEqualTo(emailLoginButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(65)
            make.height.equalTo(1)
            make.width.lessThanOrEqualTo(257)
        }
        
        naverLoginButton.snp.makeConstraints  { make in
            make.top.lessThanOrEqualTo(loginUnderLineView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(95)
            make.height.equalTo(48)
            make.width.lessThanOrEqualTo(185)
        }
        
        kakaoLoginButton.snp.makeConstraints  { make in
            make.top.lessThanOrEqualTo(naverLoginButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(95)
            make.height.equalTo(48)
            make.width.lessThanOrEqualTo(185)
        }
        
        registerLabel.snp.makeConstraints  { make in
            make.top.lessThanOrEqualTo(kakaoLoginButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(100)
            make.bottom.equalToSuperview().inset(60)
        }
        
        registerButton.snp.makeConstraints  { make in
            make.top.equalTo(registerLabel)
            make.trailing.equalToSuperview().inset(100)
            make.bottom.equalTo(registerLabel)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
} 
