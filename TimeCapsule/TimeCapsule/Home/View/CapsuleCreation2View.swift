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
        scrollView.contentSize = contentView.bounds.size //이거안해주면 스크롤 x
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var  scrollView : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = true
        scrollview.showsHorizontalScrollIndicator = false
        return scrollview
    }()
    
    private lazy var contentView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
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
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textfield.frame.height))
            textfield.leftView = paddingView
            textfield.leftViewMode = .always
            
        return textfield
    }()
    
    lazy var addPictureButton : UIButton = {
        let button = UIButton()
        button.setImage(.addImageButton, for: .normal)
        return button
    }()
    
    lazy var pictureStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal //수평으로 배치
        stackview.alignment = .fill
        stackview.distribution = .fillEqually
        stackview.spacing = 12 //하위 뷰들 사이의 간격 설정
        
        stackview.addArrangedSubview(addPictureButton) //첫번째 컴포넌트로
        return stackview
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
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textfield.frame.height))
            textfield.leftView = paddingView
            textfield.leftViewMode = .always
        return textfield
    }()
    
    private lazy var addDateLabel : UILabel = {
        let label = UILabel()
        label.text = "기한 날짜"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        return label
    }()
    
    private lazy var addDatePicker : UIDatePicker = {
        let datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        datepicker.preferredDatePickerStyle = .compact
        datepicker.locale = Locale(identifier: "ko_KR")
        datepicker.layer.backgroundColor = UIColor.white.cgColor
        
        return datepicker
    }()
    
    private lazy var addTagLabel : UILabel = {
        let label = UILabel()
        label.text = "태그"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        return label
    }()
    
     lazy var addTagButton : UIButton = {
        let button = UIButton()
        button.setTitle("태그를 선택해주세요.", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        button.contentHorizontalAlignment = .left
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft //버튼이 오른쪽으로 감

        
        return button
    }()
    
     let tags = ["기억", "성장", "감사", "목표", "행복", "모험", "가족", "친구", "배움", "위로"]
    
     lazy var tagDropDownTableView : UITableView = {
        let tableview = UITableView()
        tableview.layer.borderWidth = 0.3
        tableview.layer.cornerRadius = 12
        tableview.isHidden = true
        return tableview
    }()
    
    lazy var cancelCreationButton : UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor(hex: "9F9F9F"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 0.3
        button.backgroundColor = .white
        return button
    }()

    lazy var doneCreationButton : UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 0.3
        button.backgroundColor = UIColor(hex: "6CBAFF")
        return button
    }()
    
    private func addComponents(){
        self.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(addCapsuleNameLabel)
        contentView.addSubview(addCapsuleNameTextField)
        contentView.addSubview(pictureStackView)
        contentView.addSubview(addTextLabel)
        contentView.addSubview(addTextTextField)
        contentView.addSubview(addDateLabel)
        contentView.addSubview(addDatePicker)
        contentView.addSubview(addTagLabel)
        contentView.addSubview(addTagButton)
        contentView.addSubview(tagDropDownTableView)
        contentView.addSubview(cancelCreationButton)
        contentView.addSubview(doneCreationButton)
        
        scrollView.snp.makeConstraints{ make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView) //스크롤뷰와 똑같은 너비
            make.height.equalTo(1000) //스크롤 가능하도록 콘텐츠 높이 설정
        }
        
        addCapsuleNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(104)
            make.leading.equalTo(addCapsuleNameTextField.snp.leading).offset(8)
            make.height.equalTo(17)
        }
        
        addCapsuleNameTextField.snp.makeConstraints { make in
            make.top.equalTo(addCapsuleNameLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.equalTo(273)
            make.height.equalTo(49)
        }
        
        addPictureButton.snp.makeConstraints{ make in
            make.height.width.equalTo(120)
        }
        
        pictureStackView.snp.makeConstraints{ make in
            make.top.equalTo(addCapsuleNameTextField.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(59)
            //make.trailing.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(pictureStackView.snp.width)
        }
        
        addTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(addTextTextField.snp.leading).offset(8)
            make.top.equalTo(pictureStackView.snp.bottom).offset(48)
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
            make.leading.equalTo(addTextTextField.snp.leading).offset(8)
        }
        
        addDatePicker.snp.makeConstraints{ make in
            make.centerY.equalTo(addDateLabel.snp.centerY)
            //make.width.equalTo(90)
            make.trailing.equalTo(addTextTextField.snp.trailing).inset(8)
        }
        
        addTagLabel.snp.makeConstraints{ make in
            make.top.equalTo(addDateLabel.snp.bottom).offset(48)
            make.leading.equalTo(addTextTextField.snp.leading).offset(8)
            make.width.equalTo(25)
            make.height.equalTo(17)
        }
        
        addTagButton.snp.makeConstraints{ make in
            make.top.equalTo(addTagLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.equalTo(273)
            make.height.equalTo(49)
        }
        
        tagDropDownTableView.snp.makeConstraints { make in
            make.top.equalTo(addTagButton.snp.bottom).offset(0)
            make.leading.trailing.equalTo(addTagButton)
            make.height.equalTo(150)
        }
        
        cancelCreationButton.snp.makeConstraints { make in
            make.top.equalTo(addTagButton.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(51)
            make.width.equalTo(140)
            make.height.equalTo(48)
        }
        
        doneCreationButton.snp.makeConstraints{ make in
            make.top.equalTo(addTagButton.snp.bottom).offset(48)
            make.trailing.equalToSuperview().inset(51)
            make.width.equalTo(140)
            make.height.equalTo(48)
        }

    }
}
