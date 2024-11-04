//
//  LoginViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 10/29/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let backgroundView1 = UIView()
    private let backgroundView2 = UIView()
    
    private lazy var loginView: LoginView = {
        let view = LoginView()
        view.backgroundColor = UIColor.clear
        
        // addTarget
        view.findPasswordButton.addTarget(self, action: #selector(findPasswordTapped), for: .touchUpInside)
        view.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground1View()
        setupBackground2View()
        setupLoginView()
    }
    
    // MARK: Function
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
    
    // MARK: 이벤트 처리
    // 로그인 버튼
    @objc
    private func findPasswordTapped(){
        let findPwdVC = FindPasswordViewController()
        findPwdVC.modalPresentationStyle = .fullScreen
        present(findPwdVC, animated: true)
    }
    
    @objc
    private func emailLoginTapped(){
        
    }
    
    @objc
    private func naverLoginTapped(){
        
    }
    
    @objc
    private func kakaoLoginTapped(){
        
    }
    
    // 계정만들기 버튼
    @objc
    private func registerButtonTapped(){
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true)
        
    }
}
