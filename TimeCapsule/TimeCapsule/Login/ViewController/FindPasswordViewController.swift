//
//  FindPasswordViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/4/24.
//

import UIKit

class FindPasswordViewController: UIViewController {
    
    private lazy var findPasswordView: UIView = {
        let view = FindPasswordView()
        view.backgroundColor = UIColor.clear

        // addTarget
        view.changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    private let backgroundView1 = UIView()
    private let backgroundView2 = UIView()
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground1View()
        setupBackground2View()
        setupFindPwdView()
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
            make.top.lessThanOrEqualToSuperview().offset(229)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupFindPwdView() {
        view.addSubview(findPasswordView)
        
        findPasswordView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: 이벤트 처리
    @objc
    private func changePasswordButtonTapped() {
        let changePwdVC = ChangePasswordViewController()
        changePwdVC.modalPresentationStyle = .fullScreen
        present(changePwdVC, animated: true)
    }
}
