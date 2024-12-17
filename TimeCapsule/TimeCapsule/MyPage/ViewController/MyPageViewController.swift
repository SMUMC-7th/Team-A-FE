//
//  MyPageViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 10/31/24.
//

import UIKit
import Alamofire

class MyPageViewController: UIViewController {
    private var myPageView: MyPageView = {
        let view = MyPageView()
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: "Gray11")
        
        view.editInfoButton.addTarget(self, action: #selector(editInfoButtonTapped), for: .touchUpInside)
        view.changePwdButton.addTarget(self, action: #selector(changePwdButtonTapped), for: .touchUpInside)
        view.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray2")
        setupMyPageView()
        setupNavigationBar(action: #selector(customBackButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUserInfo()
    }
    
    private func setupMyPageView() {
        view.addSubview(myPageView)
        
        myPageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(166)
            make.leading.trailing.equalToSuperview().inset(27)
        }
    }
    
    // 회원 정보 조회 (이메일, 닉네임)
    private func fetchUserInfo() {
        guard let token = KeychainService.load(for: "RefreshToken") else { return }

        APIClient.getRequest(endpoint: "/users", token: token) { (result :  Result<UserResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    print("Successfully fetched userInfo")
                    
                    // 정보 조회되면 아디이 이메일 닉네임 fetch 시키기
                    self.myPageView.userEmailInfoLabel.text = "\(response.result!.email)"
                    self.myPageView.userNicknameInfoLabel.text = "\(response.result!.nickname)"
                    
                } else {
                    print("No UserInfo : \(response.message)")
                }
            case .failure(let error):
                print("Failed to fetched : \(error.localizedDescription)")
            }
            
        }
    }
    
    
    // MARK: Actions
    @objc func editInfoButtonTapped() {
        let editNicknameVC = EditNicknameViewController()
        navigationController?.pushViewController(editNicknameVC, animated: true)
    }
    
    
    @objc func changePwdButtonTapped() {
        let changePasswordVC = PasswordChangeViewController()
        navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    @objc
    private func logoutButtonTapped() {
        guard let token = KeychainService.load(for: "RefreshToken") else {
            print("No refresh token found in Keychain.")
            return
        }

        APIClient.postRequestWithoutParameters(endpoint: "/users/logout", token: token) { (result :  Result<DeleteUserResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    print("Successfully logged out")
                    // 로그아웃 되면 토큰 뻇어버려
                    KeychainService.delete(for: "AccessToken")
                    KeychainService.delete(for: "RefreshToken")
                    
                    // 1초 지연 후 로그인 화면으로 전환
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                            sceneDelegate.window?.rootViewController = LoginViewController()
                        }
                    }
                } else {
                    print("\(response)")
                    print("Failed to logged out : \(response.message)")
                }
            case .failure(let error):
                print("Failed to logout : \(error.localizedDescription)")
            }
        }
    }
    
    @objc func withdrawButtonTapped() {
        guard let token = KeychainService.load(for: "RefreshToken") else { return }
        
        APIClient.patchRequestWithoutParameters(endpoint: "/users", token: token) { (result :  Result<DeleteUserResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    print("Successfully deleted userInfo")
                    // 로그아웃 되면 토큰 뻇어버려
                    KeychainService.delete(for: "AccessToken")
                    KeychainService.delete(for: "RefreshToken")
                    
                    // 1초 지연 후 로그인 화면으로 전환
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                            sceneDelegate.window?.rootViewController = LoginViewController()
                        }
                    }
                             
                            
                } else {
                    print("Failed to logged out : \(response.message)")
                }
            case .failure(let error):
                print("Failed to logout : \(error.localizedDescription)")
            }
        }
    }
}
