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
        let originalPosition = textField.frame.origin // 원래 위치 저장

        UIView.animate(withDuration: 0.2, animations: {
            textField.frame.origin.x -= 5
            textField.frame.origin.y -= 5
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                textField.frame.origin.x += 5
                textField.frame.origin.y += 5
             }, completion: { _ in
                 UIView.animate(withDuration: 0.2, animations: {
                    textField.frame.origin.x -= 5
                    textField.frame.origin.y -= 5
                 }, completion: { _ in
                     // 애니메이션 종료 후 원래 위치로 복원
                     textField.frame.origin = originalPosition
                 })
             })
        })
    }
    
    func setupNavigationBar(action: Selector) {
        self.navigationItem.hidesBackButton = true
        
        let backImage = UIImage(systemName: "arrow.backward")
        let resizedBackImage = UIGraphicsImageRenderer(size: CGSize(width: 14, height: 26)).image { _ in
            backImage?.draw(in: CGRect(origin: .zero, size: CGSize(width: 14, height: 26)))
        }
        
        let customBackButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: action)

        customBackButton.tintColor = UIColor(named: "Gray4")
        
        self.navigationItem.leftBarButtonItem = customBackButton
    }
    
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
