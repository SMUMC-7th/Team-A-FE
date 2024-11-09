//
//  ChangePasswordViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/9/24.
//

import UIKit

class ChangePasswordViewController : UIViewController {
    
    private lazy var changePasswordView: UIView = {
        let view = ChangePasswordView()
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: "Gray11")
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray2")
        setupChangePasswordView()
    }
    
    private func setupChangePasswordView() {
        view.addSubview(changePasswordView)
        
        changePasswordView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(166)
            make.leading.trailing.equalToSuperview().inset(27)
        }
    }
}
