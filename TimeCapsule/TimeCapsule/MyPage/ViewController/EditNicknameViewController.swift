//
//  EditInfoViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/13/24.
//

import UIKit
import Alamofire

class EditNicknameViewController: UIViewController {
    
    var nickname: String = ""
    var isValidNickname = false

    private lazy var editNicknameView: EditNicknameView = {
        let view = EditNicknameView()
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: "Gray11")
        
        // 이벤트 처리
        view.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray2")
        setupEditNicknameView()
        setupNavigationBarBackgroundColor()

        setupNavigationBar(action: #selector(customBackButtonTapped))
    }
    
    private func setupEditNicknameView() {
        view.addSubview(editNicknameView)
        
        editNicknameView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(166)
            make.leading.trailing.equalToSuperview().inset(27)
        }
    }
    
    @objc private func saveButtonTapped() {
        // 닉네임 값 확인
        guard let nicknameText = editNicknameView.nicknameTextField.text, !nicknameText.isEmpty else {
            print("nickname empty")
            errorUpdateUI(for: editNicknameView.nicknameTextField,
                          errorLabel: editNicknameView.nicknameErrorLabel,
                          message: "",
                          isValid: isValidNickname)
            return
        }
        
        self.nickname = nicknameText
        
        guard let token = KeychainService.load(for: "RefreshToken") else { return }
        let parameters = NicknameChangeRequest(newNickname: self.nickname)
        
        print("\(self.nickname)")
        APIClient.patchRequest(endpoint: "/users/nickname", parameters: parameters, token: token) { (result: Result<NicknameChangeResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    print("Successfully fetched userInfo")
                    
                    self.dismiss(animated: true , completion: nil)
                    
                } else {
                    print("No UserInfo : \(response.message), \(response.code)")
                }
            case .failure(let error):
                print("Failed to fetch : \(error.localizedDescription)")
            }
        }
    }
}

import SwiftUI

#Preview {
    EditNicknameViewController()
}
