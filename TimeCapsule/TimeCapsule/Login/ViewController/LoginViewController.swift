//
//  LoginViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 10/29/24.
//

import UIKit
import KakaoSDKUser
import Alamofire

class LoginViewController: UIViewController {
    var email: String = ""
    var password: String = ""
    
    private let backgroundView1 = UIView()
    private let backgroundView2 = UIView()
    
    private lazy var loginView: LoginView = {
        let view = LoginView()
        view.backgroundColor = UIColor.clear
        view.loginErrorLabel.isHidden = true
        
        // addTarget
        view.findPasswordButton.addTarget(self, action: #selector(findPasswordTapped), for: .touchUpInside)
        view.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        view.emailLoginButton.addTarget(self, action: #selector(emailLoginTapped), for: .touchUpInside)
        view.kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginTapped), for: .touchUpInside)
        view.naverLoginButton.addTarget(self, action: #selector(naverLoginTapped), for: .touchUpInside)
        
        return view
    }()
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground1View()
        setupBackground2View()
        setupLoginView()
    }

    
    // MARK: UI Function
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
            make.top.equalToSuperview().offset(229)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupLoginView() {
        view.addSubview(loginView)          // 로그인 뷰를 최상위 뷰로 추가
        
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Feature Function
    // Home 화면으로 전환
    public func presentToHome() {
        let homeVC = HomeViewController()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true)
    }
    
    public func presentToLogin() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }

    // 카카오 닉네임, 이메일 정보 가져오기
    private func getKakaoUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                if let kakaoemail = user?.kakaoAccount?.email,
                   let kakaonickname = user?.kakaoAccount?.profile?.nickname {
                    print("Email: \(kakaoemail), Nickname: \(kakaonickname)")
                    // 서버로 로그인 요청
                    self.kakaoLoginToServer(email: kakaoemail, nickname: kakaonickname)
                } else {
                    print("Nickname or email is missing.")
                }
            }
        }
    }
    
    // MARK: 서버 연동 Function
    private func emailLoginToServer(email: String, password: String) {
        let parameters = EmailLoginRequest(email: email, password: password)
        
        APIClient.postRequest(endpoint: "/users/login", parameters: parameters) { [self] (result: Result<LoginResponse, AFError>) in
            switch result {
            case .success(let loginResponse):
                if loginResponse.isSuccess {
                    print("Login successful. Access Token: \(loginResponse.result?.accessToken)")
                    
                    // kakao토큰 키체인에 저장
                    KeychainService.save(value: loginResponse.result!.accessToken, for: "AccessToken")
                    KeychainService.save(value: loginResponse.result!.refreshToken, for: "RefreshToken")
                                        
                    // 서버 연동시 홈화면으로 이동
                    self.presentToHome()
                    
                } else {
                    print("Login failed with message: \(loginResponse.message)")
                    loginView.emailTextField.layer.borderColor = UIColor(named: "ErrorColor")?.cgColor
                    loginView.emailTextField.layer.borderWidth = 0.4
                    shakeTextField(textField: loginView.emailTextField)
                    
                    loginView.passwordTextField.layer.borderColor = UIColor(named: "ErrorColor")?.cgColor
                    loginView.passwordTextField.layer.borderWidth = 0.4
                    shakeTextField(textField: loginView.passwordTextField)

                    
                    self.handleErrorMessage(loginResponse.message)
                }
            case .failure(let error):
                print("Server login error: \(error.localizedDescription)")
            }
        }
    }
    
    private func handleErrorMessage(_ message: String) {
        switch message {
        case "잘못된 정보입니다.":
            loginView.loginErrorLabel.isHidden = false
        default:
            print("Unknown error occurred: \(message)")
        }
    }

    
    private func naverLoginToServer(email: String, nicknmae: String) {
        
        
    }
    
    
    private func kakaoLoginToServer(email: String, nickname: String) {
        let parameters = SocialLoginRequest(email: email, nickname: nickname)

        APIClient.postRequest(endpoint: "/users/kakao", parameters: parameters) { (result: Result<LoginResponse, AFError>) in
            switch result {
            case .success(let loginResponse):
                if loginResponse.isSuccess {
                    print("Login successful. Access Token: \(loginResponse.result?.accessToken)")
                    
                    // kakao토큰 키체인에 저장
                    KeychainService.save(value: loginResponse.result!.accessToken, for: "AccessToken")
                    KeychainService.save(value: loginResponse.result!.refreshToken, for: "RefreshToken")
                                        
                    // 서버 연동시 홈화면으로 이동
                    self.presentToHome()

                } else {
                    print("Login failed with message: \(loginResponse.message)")
                }
            case .failure(let error):
                print("Server login error: \(error.localizedDescription)")
            }
        }
    }
    
    
    // MARK: 이벤트 처리
    // 로그인 버튼
    @objc
    private func findPasswordTapped(){
        let findPwdVC = FindPasswordViewController()
        findPwdVC.modalPresentationStyle = .fullScreen
        present(findPwdVC, animated: true)
    }
    
    @objc
    private func emailLoginTapped() {
        email = loginView.emailTextField.text ?? ""
        password = loginView.passwordTextField.text ?? ""
        
        emailLoginToServer(email: email, password: password)
    }
    
    @objc
    private func naverLoginTapped(){
        
    }
    
    @objc
    private func kakaoLoginTapped(){
        // 카카오톡 앱이 있는 경우 (앱으로 로그인)
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    print("Error.")
                    print(error)
                } else if let oauthToken = oauthToken {
                    print("loginWithKakaoTalk() success.")
                    self?.getKakaoUserInfo()
                }
            }
        // 카카오톡 앱이 없는 경우 (웹으로 로그인)
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                if let error = error {
                    print(error)
                } else if let oauthToken = oauthToken {
                    print("loginWithKakaoAccount() success.")
                    self?.getKakaoUserInfo()
                }
            }
        }
    }
    
    // 계정만들기 버튼
    @objc
    private func registerButtonTapped(){
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true)
        
    }
}


import SwiftUI

#Preview {
    LoginViewController()
}
