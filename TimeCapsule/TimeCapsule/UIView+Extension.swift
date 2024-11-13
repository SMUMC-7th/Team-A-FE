//
//  UIView+Shadow.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/2/24.
//

import UIKit

extension UIView {
    // MARK: 반복되는 Label, TextField UI 설정
    // 로그인 그라데이션 효과
    func setGradient(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.frame = bounds
        gradient.cornerRadius = layer.cornerRadius // 코너 반경 적용

        // 기존의 모든 서브레이어를 제거하고 그라데이션 레이어 추가
        layer.insertSublayer(gradient, at: 0)
    }
    
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "Gray8")
        label.textAlignment = .left
        
        return label
    }
    
    func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.layer.borderWidth = 0.2
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor(named: "Gray7")?.cgColor
        textField.font = .systemFont(ofSize: 14)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(49)
        }
        return textField
    }
    
    func createErrorLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = ""
        return label
    }
}

extension UIViewController {
    // MARK: 에러처리 UI 설정
    // 에러처리 날때 오류 메시지 출력 및 border 색 변경
    func errorUpdateUI(for textField: UITextField, errorLabel: UILabel, message: String, isValid: Bool) {
        errorLabel.text = isValid ? "" : message
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
}
