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
        
        view.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray2")
        setupMyPageView()
        
    }
    
    private func setupMyPageView() {
        view.addSubview(myPageView)
        
        myPageView.snp.makeConstraints { make in
            make.width.equalTo(311)
            make.height.equalTo(480)
            make.leading.trailing.equalToSuperview().inset(27)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc
    private func logoutButtonTapped() {
        guard let token = KeychainService.load(for: "AccessToken") else { return }
        
        APIClient.postRequestWithoutParameters(endpoint: "/users/logout", token: token) { (result :  Result<LogoutResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    print("Successfully logged out")
                    // 로그아웃 되면 토큰 뻇어버려
                    KeychainService.delete(for: "AccessToken")
                    KeychainService.delete(for: "RefreshToken")
                    
                    // 1초 지연 후 로그인 화면으로 전환
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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
