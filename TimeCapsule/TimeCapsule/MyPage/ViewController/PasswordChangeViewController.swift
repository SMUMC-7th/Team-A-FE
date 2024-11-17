//
//  PasswordChangeViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/13/24.
//

import UIKit

class PasswordChangeViewController: UIViewController {
    
    private var passwordChangeView: PasswordChangeView = {
        let view = PasswordChangeView()
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: "Gray11")
        
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray2")
        setupPasswordChangeView()
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
}
