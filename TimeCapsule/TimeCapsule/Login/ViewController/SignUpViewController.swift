//
//  SignUpViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/2/24.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    // 회원가입시 전달할 정보를 담기 위한 변수 선언
    var email: String = ""
    var name: String = ""
    var nickname: String = ""
    var password: String = ""
    
    var userInfo: ((UserInfo) -> Void)?     // 데이터 전달
    
    // 유효성검사를 위한 property
    var isValidEmail = false
    var isValidPassword = false
    var isPasswordMatching = false
    
    private lazy var signupView: SignupView = {
        let view = SignupView()
        view.backgroundColor = UIColor.clear
        
        // addTarget
        view.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    private let backgroundView1 = UIView()
    private let backgroundView2 = UIView()
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground1View()
        setupBackground2View()
        setupSignupView()
    }
    
    // MARK: UI Funcitons
    private func setupBackground1View() {
        backgroundView1.backgroundColor = UIColor(named: "Gray2")
        view.addSubview(backgroundView1)
        
        backgroundView1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBackground2View() {
        backgroundView2.backgroundColor = UIColor(named: "Gray11")
        backgroundView2.layer.cornerRadius = 60
        backgroundView2.layer.maskedCorners = [.layerMinXMinYCorner]
        
        view.addSubview(backgroundView2)
        
        backgroundView2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(91)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupSignupView() {
        view.addSubview(signupView)
        
        signupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Feature Functions
    private func validateUserInfo() {
        let emailText = signupView.emailTextField.text ?? ""
        let passwordText = signupView.passwordTextField.text ?? ""
        let repeatPasswordText = signupView.passwordRepeatTextField.text ?? ""
        
        // 각각의 유효성 검사 결과를 업데이트
        isValidEmail = isValidEmailFormat(emailText)
        isValidPassword = isValidPasswordFormat(passwordText)
        isPasswordMatching = (repeatPasswordText == passwordText)
        
        // 에러 메시지 업데이트
        signupView.emailErrorLabel.text = isValidEmail ? "" : "유효하지 않은 이메일입니다."
        signupView.emailTextField.layer.borderColor = isValidEmail ? UIColor.clear.cgColor : UIColor.red.cgColor
        signupView.emailTextField.layer.borderWidth = isValidEmail ? 0 : 0.4
        signupView.passwordErrorLabel.text = isValidPassword ? "" : "비밀번호는 8자 이상, 대문자, 소문자, 특수문자를 포함해야 합니다."
        signupView.passwordTextField.layer.borderColor = isValidEmail ? UIColor.clear.cgColor : UIColor.red.cgColor
        signupView.passwordTextField.layer.borderWidth = isValidEmail ? 0 : 0.4
        signupView.passwordRepeatErrorLabel.text = isPasswordMatching ? "" : "비밀번호가 일치하지 않습니다."
        signupView.passwordRepeatTextField.layer.borderColor = isValidEmail ? UIColor.clear.cgColor : UIColor.red.cgColor
        signupView.passwordRepeatTextField.layer.borderWidth = isValidEmail ? 0 : 0.4
    }
    
    private func isValidEmailFormat(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.com"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func isValidPasswordFormat(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    
    // MARK: 이벤트 처리
    @objc
    private func completeButtonTapped(){
        // 유효성 검사
        validateUserInfo()

        // 서버로 유효성 검사 후 전송
        if isValidEmail && isValidPassword && isPasswordMatching {
            // UserDefaults에 저장
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(nickname, forKey: "nickname")
            UserDefaults.standard.set(password, forKey: "password")
            
            dismiss(animated: true, completion: nil)
        }
    }
}
