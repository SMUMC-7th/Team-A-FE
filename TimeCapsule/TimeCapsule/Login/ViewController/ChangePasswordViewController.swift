//
//  ChangePasswordViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/9/24.
//

import UIKit
import Alamofire

class ChangePasswordViewController : UIViewController {

    var email: String = ""
    var newPassword: String = ""
    var isValidnewPassword = false
    var isPasswordMatching = false
    

    private lazy var changePasswordView: ChangePasswordView = {
        let view = ChangePasswordView()
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: "Gray11")
        
        view.changePasswordButton.addTarget(self, action: #selector(changePawwordCompleteButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray2")
        setupChangePasswordView()
        
        print("\(self.email)")
    }
    
    // MARK: UI Functions
    private func setupChangePasswordView() {
        view.addSubview(changePasswordView)
        
        changePasswordView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(166)
            make.leading.trailing.equalToSuperview().inset(27)
        }
    }
    
    // MARK: Feature Functions
    
    private func validateUserInfo() {
        let newpasswordText = changePasswordView.newPasswordTextField.text ?? ""
        let repeatPasswordText = changePasswordView.passwordRepeatTextField.text ?? ""
        
        // 각각의 유효성 검사 결과를 업데이트
        isValidnewPassword = isValidPasswordFormat(newpasswordText)
        isPasswordMatching = (!repeatPasswordText.isEmpty) && (repeatPasswordText == newpasswordText)
        
        // 유효성 검사 통과 시, 변수에 값을 할당
        if isValidnewPassword && isPasswordMatching {
            self.newPassword = newpasswordText
        }
        
        // 에러 메시지 업데이트
        errorUpdateUI(for: changePasswordView.newPasswordTextField,
                      errorLabel: changePasswordView.newPasswordErrorLabel,
                      message: "영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.",
                      isValid: isValidnewPassword)
        errorUpdateUI(for: changePasswordView.passwordRepeatTextField,
                      errorLabel: changePasswordView.passwordRepeatErrorLabel,
                      message: "비밀번호가 일치하지 않습니다.",
                      isValid: isPasswordMatching)
        
    }
    
    // 이벤트 처리
    @objc
    private func changePawwordCompleteButtonTapped() {
        
        // 유효성 검사
        validateUserInfo()
        
        // 서버로 변경된 비밀번호 전송

        let parameters = PasswordChangeRequestinLoginPage(email: self.email, password: self.newPassword)
        print("\(self.email), \(self.newPassword)")
        
        APIClient.putRequest(endpoint: "/users/password", parameters: parameters, token: nil) { (result: Result<PasswordChangeResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    print("Successfully changed password: \(self.newPassword)")
                    
                    // 비밀번호 변경 성공 시, 로그인 화면으로 이동
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        sceneDelegate.window?.rootViewController = LoginViewController()
                    }
                } else {
                    print("Failed to change password: \(response.message)")
                    dump(response)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

import SwiftUI

#Preview {
    ChangePasswordViewController()
}
