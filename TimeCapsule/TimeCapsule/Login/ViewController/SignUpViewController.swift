//
//  SignUpViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/2/24.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private lazy var signupView: SignupView = {
        let view = SignupView()
        view.backgroundColor = UIColor.clear
        
        // addTarget
        view.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    private let backgroundView1 = UIView()
    private let backgroundView2 = UIView()
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground1View()
        setupBackground2View()
        setupSignupView()
    }
    
    private func setupBackground1View() {
        backgroundView1.backgroundColor = UIColor(named: "Gray2")
        view.addSubview(backgroundView1)
        
        backgroundView1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBackground2View() {
        backgroundView2.backgroundColor = UIColor(named: "Gray11")
        backgroundView2.layer.cornerRadius = 60
        backgroundView2.layer.maskedCorners = [.layerMinXMinYCorner]
        
        view.addSubview(backgroundView2)
        
        backgroundView2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(91)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupSignupView() {
        view.addSubview(signupView)
        
        signupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: 이벤트 처리
    @objc
    private func completeButtonTapped(){
        dismiss(animated: true, completion: nil)
    }

}
