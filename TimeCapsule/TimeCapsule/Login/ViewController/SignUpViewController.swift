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
        errorUpdateUI(for: signupView.emailTextField,
                      errorLabel: signupView.emailErrorLabel,
                      message: "올바른 이메일 형식이 아닙니다.\n예: example@domain.com",
                      isValid: isValidEmail)
        errorUpdateUI(for: signupView.nicknameTextField,
                      errorLabel: signupView.nicknameErrorLabel,
                      message: "2자 이상의 닉네임을 입력해주세요.",
                      isValid: isValidNickname)
        errorUpdateUI(for: signupView.passwordTextField,
                      errorLabel: signupView.passwordErrorLabel,
                      message: "영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.",
                      isValid: isValidPassword)
        errorUpdateUI(for: signupView.passwordRepeatTextField,
                      errorLabel: signupView.passwordRepeatErrorLabel,
                      message: "비밀번호가 일치하지 않습니다.",
                      isValid: isPasswordMatching)
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
    
    
    // MARK: 서버 전송 Functions
    private func signupToServer(email: String, nickname: String, password: String) {
        let parameters = SignupRequest(email: email, nickname: nickname, password: password)
        
        APIClient.postRequest(endpoint: "/users/signup", parameters: parameters) { (result: Result<SignupResponse, AFError>) in
            switch result {
            case .success(let signupResponse):
                if signupResponse.isSuccess {
                    print("Signup successful : \(signupResponse.result)")
                    
                    self.dismiss(animated: true, completion: nil)   // 서버 전송 성공했으니깐 로그인 화면으로 돌아가
                } else {
                    // 이미 존재하는 이메일인 경우 서버 응답에 따른 오류 메시지 처리
                    self.isValidEmail = false // isValidEmail을 false로 설정해 강제로 UI업데이트
                    self.handleErrorMessage(signupResponse.message)
                    print("\(signupResponse.message)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // 회원가입시 이미 존재하는 이메일인 경우
    private func handleErrorMessage(_ message: String) {
        switch message {
        case "이미 존재하는 이메일입니다.":
            errorUpdateUI(for: signupView.emailTextField,
                          errorLabel: signupView.emailErrorLabel,
                          message: "이미 존재하는 이메일입니다",
                          isValid: isValidEmail)
        default:
            print("Unknown error occurred: \(message)")
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

        // 서버로 전송
        signupToServer(email: email, nickname: nickname, password: password)

    }
}
