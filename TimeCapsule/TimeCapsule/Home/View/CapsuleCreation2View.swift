//
//  CapsuleCreation2View.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/3/24.
//

import UIKit

class CapsuleCreation2View: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var addCapsuleNameLabel : UILabel = {
        let label = UILabel()
        label.text = "캡슐 이름"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        return label
    }()
    
    private lazy var addCapsuleNameTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "이름을 입력해주세요."
        textfield.font = .systemFont(ofSize: 14, weight: .light)
        textfield.layer.borderWidth = 0.3
        textfield.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        textfield.layer.cornerRadius = 12
        return textfield
    }()
    
    private lazy var addPictureLabel : UILabel = {
        let label = UILabel()
        label.text = "사진"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        return label
    }()
    
    
    
    private lazy var addTextLabel : UILabel = {
        let label = UILabel()
        label.text = "텍스트"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        return label
    }()
    
    private lazy var addTextTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "내용을 입력해주세요."
        textfield.font = .systemFont(ofSize: 14, weight: .light)
        textfield.layer.borderWidth = 0.3
        textfield.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        textfield.layer.cornerRadius = 12
        return textfield
    }()
    
    private lazy var addDateLabel : UILabel = {
        let label = UILabel()
        label.text = "기한 날짜"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        return label
    }()
    
    private lazy var addDatePicker : UIDatePicker = {
        let datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        return datepicker
    }()
    
    private lazy var addTagLabel : UILabel = {
        let label = UILabel()
        label.text = "태그"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        return label
    }()
    
    private lazy var addTagDropDown : UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    lazy var cancelCreationButton : UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    lazy var doneCreationButton : UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private func addComponents(){
        self.addSubview(addCapsuleNameLabel)
        self.addSubview(addCapsuleNameTextField)
        self.addSubview(addPictureLabel)
        self.addSubview(addTextLabel)
        self.addSubview(addTextTextField)
        self.addSubview(addDateLabel)
        self.addSubview(addDatePicker)
        self.addSubview(addTagLabel)
        self.addSubview(addTagDropDown)
        self.addSubview(cancelCreationButton)
        self.addSubview(doneCreationButton)
        
        addCapsuleNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(170)
            make.leading.equalToSuperview().offset(59)
            make.height.equalTo(17)
        }
        
        addCapsuleNameTextField.snp.makeConstraints { make in
            make.top.equalTo(addCapsuleNameLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.equalTo(273)
            make.height.equalTo(49)
        }
        
        addPictureLabel.snp.makeConstraints { make in
            make.top.equalTo(addCapsuleNameTextField.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(59)
            make.width.equalTo(25)
            make.height.equalTo(23.14)
        }
        
        addTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(59)
            make.top.equalTo(addPictureLabel.snp.bottom).offset(167.86)
            make.width.equalTo(37)
            make.height.equalTo(17)
        }
        
        addTextTextField.snp.makeConstraints { make in
            make.top.equalTo(addTextLabel.snp.bottom).offset(4)
            make.width.equalTo(273)
            make.height.equalTo(196)
            make.centerX.equalToSuperview()
            make.width.equalTo(273)
        }
        
        addDateLabel.snp.makeConstraints { make in
            make.top.equalTo(addTextTextField.snp.bottom).offset(63)
            make.width.equalTo(60)
            make.height.equalTo(19)
            make.leading.equalToSuperview().offset(59)
        }
        
        addDatePicker.snp.makeConstraints{ make in
            make.top.equalTo(addTextTextField.snp.bottom).offset(63)
            make.width.equalTo(76)
            make.leading.equalToSuperview().offset(232)
        }
        
        addTagLabel.snp.makeConstraints{ make in
            make.top.equalTo(addDateLabel.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(59)
            make.width.equalTo(25)
            make.height.equalTo(17)
        }
        
        addTagDropDown.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalTo(273)
        }
        
        cancelCreationButton.snp.makeConstraints { make in
            
        }
        
        doneCreationButton.snp.makeConstraints{ make in
            
        }

    }
}
