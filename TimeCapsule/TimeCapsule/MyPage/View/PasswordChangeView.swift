//
//  PasswordChangeView.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/13/24.
//

import UIKit

class PasswordChangeView: UIView {
    private lazy var pwdChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 변경"
        label.font = .systemFont(ofSize: 42, weight: .light)
        label.textColor = UIColor(named: "Gray9")
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    private func addComponents() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
