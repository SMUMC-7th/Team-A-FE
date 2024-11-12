//
//  MyPageViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 10/31/24.
//

import UIKit

class MyPageViewController: UIViewController {
    private var myPageView: MyPageView = {
        let view = MyPageView()
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: "Gray11")
        
        view.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray2")
        setupMyPageView()
        
    }
    
    private func setupMyPageView() {
        view.addSubview(myPageView)
        
        myPageView.snp.makeConstraints { make in
            make.width.equalTo(311)
            make.height.equalTo(480)
            make.leading.trailing.equalToSuperview().inset(27)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc
    private func logoutButtonTapped() {
        // 로그아웃 되면 토큰 뻇어버려
        KeychainService.delete(for: "AccessToken")
        KeychainService.delete(for: "RefreshToken")
                
    }
}
