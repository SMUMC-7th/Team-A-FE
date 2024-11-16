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
    var vertifyCode: String = ""
    var isValidEmail = false
    var isValidVertifyCode = false
    
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
        // 이메일 값 확인
        guard let emailText = findPasswordView.emailTextField.text, !emailText.isEmpty else {
            print("Email is empty")
            errorUpdateUI(for: findPasswordView.emailTextField,
                          errorLabel: findPasswordView.emailErrorLabel,
                          message: "",
                          isValid: isValidEmail)
            return
        }
        
        self.email = emailText
        let parameters = EmailRequest(email: self.email)
        
        // API 호출
        APIClient.postRequest(endpoint: "/email/send", parameters: parameters) { (result: Result<EmailResponse, AFError>) in
            switch result {
            case .success(let emailResponse):
                if emailResponse.isSuccess {
                    
                    // 인가를 빼는 과정에서 존재하지 않는 이메일이어도 자동으로 전송됨
                    print("Email sent successfully: \(self.email)")
                } else {
                    print("Failed to send email: \(emailResponse.message)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    @objc
    private func changePasswordButtonTapped() {
        guard let vertifyCode = findPasswordView.vertifyCodeTextField.text, !vertifyCode.isEmpty else {
            errorUpdateUI(for: findPasswordView.vertifyCodeTextField,
                          errorLabel: findPasswordView.vertifyCodeErrorLabel,
                          message: "",
                          isValid: isValidVertifyCode)
            return
        }
        
        let parameters = VertifyCodeRequest(email: self.email, code: vertifyCode)
        print("\(self.email), \(vertifyCode)")
        
        APIClient.postRequest(endpoint: "/email/verify", parameters: parameters) { (result: Result<VertifyCodeResponse, AFError>) in
            switch result {
            case .success(let verifyResponse):
                if verifyResponse.isSuccess {
                    print("Successfully verified")
                    let changePwdVC = ChangePasswordViewController()
                    changePwdVC.modalPresentationStyle = .fullScreen
                    self.present(changePwdVC, animated: true)
                } else {
                    print("Failed to verify: \(verifyResponse.message)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                if let afError = error.asAFError {
                    print("AFError: \(afError)")
                    if let responseCode = afError.responseCode {
                        print("Response code: \(responseCode)")
                    }
                }
            }
        }
    }
}
