//
//  UIView+Shadow.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/2/24.
//

import UIKit

extension UIView {
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
