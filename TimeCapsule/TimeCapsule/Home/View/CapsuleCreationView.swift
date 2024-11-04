//
//  CapsuleCreationView.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/2/24.
//

import UIKit
import SnapKit

class CapsuleCreationView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*private lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButtonImage"), for: .normal)
        return button
    }()*/
    
    private lazy var creationBox : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var creationLabel : UILabel = {
        let label = UILabel()
        label.text = "새로운 캡슐 생성"
        label.font = .systemFont(ofSize: 34, weight: .thin)
        label.textColor = .black
        return label
    }()
    
    private lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.text = "기한 날짜"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var datePicker : UIDatePicker = {
        let datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        datepicker.preferredDatePickerStyle = .automatic
        
        datepicker.tintColor = .gray
        // datepicker.maximumDate = .
        return datepicker
    }()
    
    lazy var createButton : UIButton = {
        let button = UIButton()
        button.setTitle("생성하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = UIColor(hex:"6CBAFF")
        button.layer.cornerRadius = 12
        return button
    }()
    
    private func addComponents() {
        //self.addSubview(backButton)
        self.addSubview(creationBox)
        
        creationBox.addSubview(creationLabel)
        creationBox.addSubview(dateLabel)
        creationBox.addSubview(datePicker)
        creationBox.addSubview(createButton)
        
        /*backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(87)
            make.leading.equalToSuperview().offset(24)
        }*/
        
        creationBox.snp.makeConstraints{ make in
            //make.top.bottom.equalToSuperview().inset(243)
            //make.leading.trailing.equalToSuperview().inset(36)
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(303)
            make.height.equalTo(385)
        }
        
        creationLabel.snp.makeConstraints{ make in
            make.top.equalTo(creationBox.snp.top).offset(56)
            make.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(creationLabel.snp.bottom).offset(80)
            make.leading.equalTo(creationBox.snp.leading).offset(47)
            make.width.equalTo(75)
            make.height.equalTo(24)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(creationLabel.snp.bottom).offset(78)
            make.leading.equalTo(dateLabel.snp.trailing).offset(40)
            make.width.equalTo(94)
            make.height.equalTo(30)
        }
        
        createButton.snp.makeConstraints{ make in
            make.top.equalTo(creationBox.snp.top).offset(281)
            make.centerX.equalToSuperview()
            make.width.equalTo(154)
            make.height.equalTo(48)
        }
        
    }

}


extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
