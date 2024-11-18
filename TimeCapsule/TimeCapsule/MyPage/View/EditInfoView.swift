//
//  EditinfoView.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/13/24.
//

import UIKit

class EditNicknameView: UIView {
    private lazy var editNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "정보 편집"
        label.font = .systemFont(ofSize: 42, weight: .light)
        label.textColor = UIColor(named: "Gray9")
        
        return label
    }()
    
    private lazy var changeNicknameStackView: UIStackView = {
        let newNicknameStack = UIStackView(arrangedSubviews: [nicknameLabel, nicknameTextField])
        newNicknameStack.axis = .vertical
        newNicknameStack.spacing = 4
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        return newNicknameStack
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = createLabel(text: "닉네임")
        
        return label
    }()
    
    public lazy var nicknameTextField: UITextField = {
        let textField = createTextField(placeholder: "별명을 입력해주세요.")
        
        return textField
    }()
    
    public lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.backgroundColor = UIColor(named: "ThemeColor")
        button.layer.cornerRadius = 12
        button.titleLabel?.textColor = UIColor(named: "Gray1")
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    private func addComponents() {
        addSubview(editNicknameLabel)
        addSubview(changeNicknameStackView)
        addSubview(saveButton)
        
        editNicknameLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        
        changeNicknameStackView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(editNicknameLabel.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(51)
        }
        
        
        saveButton.snp.makeConstraints  { make in
            make.trailing.leading.equalToSuperview().inset(95)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualToSuperview().inset(60)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
