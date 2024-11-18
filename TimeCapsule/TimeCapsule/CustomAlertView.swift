//
//  DeletionAlertView.swift
//  TimeCapsule
//
//  Created by 이승준 on 11/11/24.
//

import UIKit

class CustomAlertView: UIView {
    
    private var alertContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
        
    private var capsuleNameLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textAlignment = .center
        return label
    }()
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "캡슐을 삭제하시겠습니까?"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    public var confirmButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.gray3.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.setTitleColor(.gray1, for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    public var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.layer.borderColor = UIColor.gray3.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.setTitleColor(.gray6, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        
        self.addComponents()
    }
    
    private func addComponents() {
        self.addSubview(alertContainerView)
        alertContainerView.addSubview(capsuleNameLabel)
        alertContainerView.addSubview(messageLabel)
        alertContainerView.addSubview(confirmButton)
        alertContainerView.addSubview(cancelButton)
        
        alertContainerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(124)
            make.width.equalTo(252)
        }
        
        capsuleNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(capsuleNameLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(40)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(24)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
    }
    
    func setupView(confirmText: String, confirmColor: UIColor, title: String, message: String) {
        confirmButton.setTitle(confirmText, for: .normal)
        confirmButton.backgroundColor = confirmColor
        capsuleNameLabel.text = title
        messageLabel.text = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
