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
    
    private let backgroundView1 = UIView()
    private let backgroundView2 = UIView()
    
    private lazy var loginView: LoginView = {
        let view = LoginView()
        view.backgroundColor = UIColor.clear
        view.loginErrorLabel.isEnabled = false
        
        // addTarget
        view.findPasswordButton.addTarget(self, action: #selector(findPasswordTapped), for: .touchUpInside)
        view.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        view.kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginTapped), for: .touchUpInside)
        
        return view
    }()
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground1View()
        setupBackground2View()
        setupLoginView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserDefaultsValues()
    }
    
    func getUserDefaultsValues() {
        let userDefaults = UserDefaults.standard
        let allData = userDefaults.dictionaryRepresentation()

        // 기존에 저장된 email, nickname, password 데이터를 배열로 관리
        var savedEmails = userDefaults.array(forKey: "savedEmails") as? [String] ?? []
        var savedNicknames = userDefaults.array(forKey: "savedNicknames") as? [String] ?? []
        var savedPasswords = userDefaults.array(forKey: "savedPasswords") as? [String] ?? []

        // 사용자 정의 값들만 필터링
        let userKeys = ["email", "nickname", "password"]
        
        for (key, value) in allData {
            if userKeys.contains(key) {
                print("\(key): \(value)")

                // 이메일, 닉네임, 비밀번호 데이터 배열에 추가
                if key == "email", let email = value as? String {
                    savedEmails.append(email)
                } else if key == "nickname", let nickname = value as? String {
                    savedNicknames.append(nickname)
                } else if key == "password", let password = value as? String {
                    savedPasswords.append(password)
                }
            }
        }

        // UserDefaults에 저장된 이메일, 닉네임, 비밀번호 배열을 다시 저장
        userDefaults.set(savedEmails, forKey: "savedEmails")
        userDefaults.set(savedNicknames, forKey: "savedNicknames")
        userDefaults.set(savedPasswords, forKey: "savedPasswords")
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
    private func presentToHome() {
        let homeVC = HomeViewController()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true)
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
                    self.kakaoLoginToServer(nickname: kakaonickname, email: kakaoemail)
                } else {
                    print("Nickname or email is missing.")
                }
            }
        }
    }
    
    // MARK: 서버 연동 Function
    private func kakaoLoginToServer(nickname: String, email: String) {
        let parameters: [String: String] = [
            "email": email,
            "nickname": nickname
        ]

        APIClient.postRequest(endpoint: "/users/kakao", parameters: parameters) { (result: Result<LoginResponse, AFError>) in
            switch result {
            case .success(let loginResponse):
                if loginResponse.isSuccess, let firstResult = loginResponse.result.first {
                    print("Login successful. Access Token: \(firstResult.accessToken)")
                    
                    UserDefaults.standard.set(firstResult.accessToken, forKey: "accessToken")
                    UserDefaults.standard.set(firstResult.refreshToken, forKey: "refreshToken")

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
        
    }
    
    @objc
    private func naverLoginTapped(){
        
    }
    
    @objc
    private func kakaoLoginTapped(){
        // 카카오톡 앱이 있는 경우 (앱으로 로그인)
        // oauthToken: 카카오 로그인에서 인증받는 토큰
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    print("Error.")
                    print(error)
                } else if let oauthToken = oauthToken {
                    print("loginWithKakaoTalk() success.")
                    self?.getKakaoUserInfo()
                    self?.presentToHome()
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
                    self?.presentToHome()
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
