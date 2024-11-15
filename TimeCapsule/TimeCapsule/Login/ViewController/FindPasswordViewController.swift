//
//  FindPasswordViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/4/24.
//

import UIKit
import Alamofire

class FindPasswordViewController: UIViewController {
    
    var email: String = ""
    var vertificationCode: String = ""
    
    private lazy var findPasswordView: FindPasswordView = {
        let view = FindPasswordView()
        view.backgroundColor = UIColor.clear

        // addTarget
        view.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        view.changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    private let backgroundView1 = UIView()
    private let backgroundView2 = UIView()
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground1View()
        setupBackground2View()
        setupFindPwdView()
    }
    
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
            make.top.lessThanOrEqualToSuperview().offset(229)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupFindPwdView() {
        view.addSubview(findPasswordView)
        
        findPasswordView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: 이벤트 처리
    @objc func sendButtonTapped() {
        email = findPasswordView.emailTextField.text ?? ""
        vertificationCode = findPasswordView.vertificationCodeTextField.text ?? ""
        
        // 이메일 서버로 전송
        guard let token = KeychainService.load(for: "RefreshToken") else { return }

        let parameters = EmailRequest(email: email)
        
        APIClient.postRequest(endpoint: "/email/send", parameters: parameters, token: token) { (result: Result<EmailResponse, AFError>) in
            switch result {
            case .success(let emailResponse):
                if emailResponse.isSuccess {
                    print("Email sent successfully")
                    // 성공 시 추가 작업 처리
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    
    
    
    @objc
    private func changePasswordButtonTapped() {
        let changePwdVC = ChangePasswordViewController()
        changePwdVC.modalPresentationStyle = .fullScreen
        present(changePwdVC, animated: true)
    }
}
