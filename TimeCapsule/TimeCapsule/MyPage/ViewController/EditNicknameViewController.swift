//
//  EditInfoViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/13/24.
//

import UIKit

class EditNicknameViewController: UIViewController {
    
    private lazy var editInfoView: EditNicknameView = {
        let view = EditNicknameView()
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: "Gray11")
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray2")
        setupEditNicknameView()
    }
    
    private func setupEditNicknameView() {
        view.addSubview(editInfoView)
        
        editInfoView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(166)
            make.leading.trailing.equalToSuperview().inset(27)
        }
    }
}
