//
//  PasswordChangeViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/13/24.
//

import UIKit
import Alamofire


class PasswordChangeViewController: UIViewController {
    
    var currentPassword: String = ""
    var newPassword: String = ""
    var repeatPassword: String = ""
    var isValidcurrentPassword = false
    var isValidnewPassword = false
    var isPasswordMatching = false
    
    private var passwordChangeView: PasswordChangeView = {
        let view = PasswordChangeView()
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: "Gray11")
        
        view.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray2")
        setupPasswordChangeView()
        setupNavigationBarBackgroundColor()

        setupNavigationBar(action: #selector(customBackButtonTapped))
    }
    
    private func setupPasswordChangeView() {
        view.addSubview(passwordChangeView)
        
        passwordChangeView.snp.makeConstraints { make in
            make.width.equalTo(311)
            make.height.equalTo(480)
            make.leading.trailing.equalToSuperview().inset(27)
            make.centerY.equalToSuperview()
        }
    }
    
    private func validateUserInfo() {
        let currentpasswordText = passwordChangeView.currentPasswordTextField.text ?? ""
        let newpasswordText = passwordChangeView.newPasswordTextField.text ?? ""
        let repeatPasswordText = passwordChangeView.passwordRepeatTextField.text ?? ""
        
        // 각각의 유효성 검사 결과를 업데이트
        isValidcurrentPassword = !currentpasswordText.isEmpty
        isValidnewPassword = isValidPasswordFormat(newpasswordText)
        isPasswordMatching = (!repeatPasswordText.isEmpty) && (repeatPasswordText == newpasswordText)
        
        // 유효성 검사 통과 시, 변수에 값을 할당
        if isValidcurrentPassword && isValidnewPassword && isPasswordMatching {
            self.currentPassword = currentpasswordText
            self.newPassword = newpasswordText
            self.repeatPassword = repeatPasswordText
        }
        
        // 에러 메시지 업데이트
        errorUpdateUI(for: passwordChangeView.currentPasswordTextField,
                      errorLabel: passwordChangeView.currentPasswordErrorLabel,
                      message: "",
                      isValid: isValidcurrentPassword)
        errorUpdateUI(for: passwordChangeView.newPasswordTextField,
                      errorLabel: passwordChangeView.newPasswordErrorLabel,
                      message: "영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.",
                      isValid: isValidnewPassword)
        errorUpdateUI(for: passwordChangeView.passwordRepeatTextField,
                      errorLabel: passwordChangeView.passwordRepeatErrorLabel,
                      message: "비밀번호가 일치하지 않습니다.",
                      isValid: isPasswordMatching)
        
    }
    
    private func handleErrorMessage(_ message: String) {
        switch message {
        case "비밀번호가 다릅니다":
            errorUpdateUI(for: passwordChangeView.currentPasswordTextField,
                          errorLabel: passwordChangeView.currentPasswordErrorLabel,
                          message: "비밀번호가 틀렸습니다",
                          isValid: isValidcurrentPassword)
        case "비밀번호가 기존이랑 같습니다":
            errorUpdateUI(for: passwordChangeView.newPasswordTextField,
                          errorLabel: passwordChangeView.newPasswordErrorLabel,
                          message: "비밀번호가 기존이랑 같습니다",
                          isValid: isValidnewPassword)
        default:
            print("Unknown error occurred: \(message)")
        }
    }
    
    @objc
    private func completeButtonTapped() {
        validateUserInfo()
        
        guard let token = KeychainService.load(for: "RefreshToken") else { return }

        // 서버로 변경된 비밀번호 전송
        let parameters = PasswordChangeRequestinMyPage(oldPassword: self.currentPassword, newPassword: self.newPassword)
        print("\(self.currentPassword), \(self.newPassword)")
        
        APIClient.putRequest(endpoint: "/users/auth/password", parameters: parameters, token: token) { (result: Result<PasswordChangeResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    print("Successfully changed password: \(self.newPassword)")
                    
                    self.dismiss(animated: true , completion: nil)

                } else {
                    print("Failed to change password: \(response.message)")
                    self.handleErrorMessage(response.message)
                }
            case .failure(let error):
                print("Error Description: \(error.localizedDescription)")
                dump(error)
            }
        }
    }
    
    
    
    
}

import SwiftUI

#Preview {
    PasswordChangeViewController()
}
