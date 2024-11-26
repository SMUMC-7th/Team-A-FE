//
//  UIViewController+Extension.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/14/24.
//

import UIKit

extension UIViewController {
    // MARK: 에러처리 UI 설정
    // 에러처리 날때 오류 메시지 출력 및 border 색 변경
    func errorUpdateUI(for textField: UITextField, errorLabel: UILabel, message: String, isValid: Bool) {
        if isValid {
            errorLabel.isHidden = true
        } else {
            errorLabel.text = message
            errorLabel.isHidden = false
        }
        textField.layer.borderColor = isValid ? UIColor.clear.cgColor : UIColor.red.cgColor
        textField.layer.borderWidth = isValid ? 0 : 0.4
        
        shakeTextField(textField: textField)
    }
    
    // TextField 흔들기 애니메이션
    func shakeTextField(textField: UITextField) {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        shakeAnimation.duration = 0.5
        shakeAnimation.values = [-10, 10, -10, 5, -5, 0] // 흔들림의 범위
        textField.layer.add(shakeAnimation, forKey: "shake")
    }

    
    
    // MARK: 네비게이션 바 설정
    func setupNavigationBarBackgroundColor() {
        // 네비게이션 바의 배경색을 설정
        navigationController?.navigationBar.barTintColor = UIColor(named: "Gray2")
        navigationController?.navigationBar.layer.borderWidth = 0    // 테두리 두께 제거
        navigationController?.navigationBar.layer.borderColor = UIColor(named: "Gray2")?.cgColor
        navigationController?.navigationBar.shadowImage = UIImage()  // 스크롤시 네비게이션 바에 그림자가 자동으로 생기기 때문에 그림자도 제거해야함

    }
    
    func setupNavigationBar(action: Selector) {
        self.navigationItem.hidesBackButton = true
        
        let backImage = UIImage(named: "backButtonImage")
        let resizedBackImage = UIGraphicsImageRenderer(size: CGSize(width: 14, height: 26)).image { _ in
            backImage?.draw(in: CGRect(origin: .zero, size: CGSize(width: 14, height: 26)))
        }
        
        let customBackButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: action)

        customBackButton.tintColor = UIColor(named: "Gray5")
        
        self.navigationItem.leftBarButtonItem = customBackButton
    }
    
    @objc func customBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: 정규식 표현
    func isValidEmailFormat(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.com"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isValidPasswordFormat(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d$@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
}
