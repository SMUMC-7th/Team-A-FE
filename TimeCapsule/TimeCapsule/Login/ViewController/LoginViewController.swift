//
//  LoginViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 10/29/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private lazy var loginView: LoginView = {
        let view = LoginView()
        view.backgroundColor = UIColor(named: "Gray11")
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
    }
    
}
