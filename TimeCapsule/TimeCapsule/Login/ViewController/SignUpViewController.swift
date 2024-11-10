//
//  SignUpViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/2/24.
//

import UIKit
import Alamofire

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
    var isValidNickname = false
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
    
    // 에러처리 날때 오류 메시지 출력 및 border 색 변경
    private func errorUpdateUI(for textField: UITextField, errorLabel: UILabel, message: String, isValid: Bool) {
        errorLabel.text = isValid ? "" : message
        textField.layer.borderColor = isValid ? UIColor.clear.cgColor : UIColor.red.cgColor
        textField.layer.borderWidth = isValid ? 0 : 0.4
        
        shakeTextField(textField: textField)
    }
    
    
    // MARK: Feature Functions
    private func validateUserInfo() {
        let emailText = signupView.emailTextField.text ?? ""
        let nicknameText = signupView.nicknameTextField.text ?? ""
        let passwordText = signupView.passwordTextField.text ?? ""
        let repeatPasswordText = signupView.passwordRepeatTextField.text ?? ""
        
        // 각각의 유효성 검사 결과를 업데이트
        isValidEmail = isValidEmailFormat(emailText)
        isValidNickname = !nicknameText.isEmpty
        isValidPassword = isValidPasswordFormat(passwordText)
        isPasswordMatching = (!repeatPasswordText.isEmpty) && (repeatPasswordText == passwordText)
        
        // 유효성 검사 통과 시, 변수에 값을 할당
        if isValidEmail && isValidNickname && isValidPassword && isPasswordMatching {
            email = emailText
            nickname = nicknameText
            password = passwordText
        }
        
        // 에러 메시지 업데이트
        errorUpdateUI(for: signupView.emailTextField, errorLabel: signupView.emailErrorLabel,
                      message: "올바른 이메일 형식이 아닙니다.\n예: example@domain.com", isValid: isValidEmail)
        errorUpdateUI(for: signupView.nicknameTextField, errorLabel: signupView.nicknameErrorLabel,
                      message: "2자 이상의 닉네임을 입력해주세요.", isValid: isValidNickname)
        errorUpdateUI(for: signupView.passwordTextField, errorLabel: signupView.passwordErrorLabel,
                      message: "영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.", isValid: isValidPassword)
        errorUpdateUI(for: signupView.passwordRepeatTextField, errorLabel: signupView.passwordRepeatErrorLabel,
                      message: "비밀번호가 일치하지 않습니다.", isValid: isPasswordMatching)
    }
    
    private func isValidEmailFormat(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.com"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func isValidPasswordFormat(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d$@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    // TextField 흔들기 애니메이션
    private func shakeTextField(textField: UITextField) {
        let originalPosition = textField.frame.origin // 원래 위치 저장

        UIView.animate(withDuration: 0.2, animations: {
            textField.frame.origin.x -= 5
            textField.frame.origin.y -= 5
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                textField.frame.origin.x += 5
                textField.frame.origin.y += 5
             }, completion: { _ in
                 UIView.animate(withDuration: 0.2, animations: {
                    textField.frame.origin.x -= 5
                    textField.frame.origin.y -= 5
                 }, completion: { _ in
                     // 애니메이션 종료 후 원래 위치로 복원
                     textField.frame.origin = originalPosition
                 })
             })
        })
    }
    
    
    // MARK: 서버 전송 Functions
    private func signupToServer(email: String, nickname: String, password: String) {
        let parameters = SignupRequest(email: email, nickname: nickname, password: password)

        APIClient.postRequest(endpoint: "/users/signup", parameters: parameters) { (result: Result<SignupResponse, AFError>) in
            switch result {
            case .success(let signupResponse):
                if signupResponse.isSuccess {
                    print("Signup successful. :\(signupResponse.result)")
                } else {
                    print("Signup failed with message: \(signupResponse.message)")
                }
            case .failure(let error):
                print("Server signup error: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    // MARK: 이벤트 처리
    @objc
    private func completeButtonTapped(){
        // 유효성 검사
        validateUserInfo()
       
        // 모든 유효성 검사가 통과했는지 확인
        guard isValidEmail && isValidNickname && isValidPassword && isPasswordMatching else {
            print("유효성 검사를 통과하지 못했습니다.")
            return
        }
        
        // UserDefaults에 저장
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(nickname, forKey: "nickname")
        UserDefaults.standard.set(password, forKey: "password")
        
        
        // UserDefaults에서 읽어오기
        let savedEmail = UserDefaults.standard.string(forKey: "email") ?? ""
        let savedNickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
        let savedPassword = UserDefaults.standard.string(forKey: "password") ?? ""
           
        // 서버로 전송
        signupToServer(email: savedEmail, nickname: savedNickname, password: savedPassword)
        
        print("로그인 화면으로 이동")
        dismiss(animated: true, completion: nil)
        print("이동했다")
    }
}
