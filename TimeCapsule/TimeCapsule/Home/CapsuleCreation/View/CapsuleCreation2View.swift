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
        self.backgroundColor = .gray2
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
        view.backgroundColor = .gray2
        return view
    }()
    
     lazy var addCapsuleTitleLabel : UILabel = {
        let label = createLabel(text: "캡슐 이름")
        return label
    }()
    
     lazy var addCapsuleTitleTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "이름을 입력해주세요."
        textfield.font = .systemFont(ofSize: 14, weight: .light)
        textfield.layer.cornerRadius = 12
         textfield.layer.backgroundColor = UIColor.gray11.cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textfield.frame.height))
            textfield.leftView = paddingView
            textfield.leftViewMode = .always
            
        return textfield
    }()
    
    lazy var addImageButton : UIButton = {
        let button = UIButton()
        button.setImage(.addImageButton, for: .normal)
        return button
    }()
    
     var images: [UIImage] = []
    
    lazy var imageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 120) // 이미지 크기 설정
        layout.minimumInteritemSpacing = 12 // 이미지 간 간격
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var addTextLabel : UILabel = {
        let label = createLabel(text: "텍스트")
        return label
    }()
    
     lazy var addTextTextView : UITextView = {
        let textview = UITextView()
        textview.font = .systemFont(ofSize: 14, weight: .light)
        textview.layer.backgroundColor = UIColor.gray11.cgColor
        textview.layer.cornerRadius = 12
        textview.textContainer.lineFragmentPadding = 16
        return textview
    }()
    
    private lazy var addDateLabel : UILabel = {
        let label = createLabel(text: "기한 날짜")
        return label
    }()
    
     lazy var addDatePicker : UIDatePicker = {
        let datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        datepicker.preferredDatePickerStyle = .compact
        datepicker.locale = Locale(identifier: "ko_KR")
        return datepicker
    }()
    
    public var isTagSelected = false
    
     lazy var addTagLabel : UILabel = {
         let label = createLabel(text: "태그")
        return label
    }()
    
     lazy var addTagButton : UIButton = {
         var configuration = UIButton.Configuration.plain()
         configuration.title = "태그를 선택해주세요"
         configuration.baseForegroundColor = .gray5
         configuration.titleAlignment = .leading //왼쪽 정렬
         configuration.image = UIImage(systemName: "chevron.down")
         configuration.imagePlacement = .trailing // 이미지를 오른쪽에 배치
         configuration.imagePadding = 80
         configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0) // 패딩 설정
         
         let titleFont = UIFont.systemFont(ofSize: 14, weight: .light)
        configuration.attributedTitle = AttributedString("태그를 선택해주세요", attributes: .init([.font: titleFont]))
         
         let button = UIButton(configuration: configuration)
         button.layer.cornerRadius = 12
         button.layer.backgroundColor = UIColor.gray11.cgColor
         return button
    }()
    
     lazy var tagDropDownTableView : UITableView = {
        let tableview = UITableView()
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
        button.backgroundColor = .gray11
        return button
    }()

    lazy var doneCreationButton : UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(hex: "6CBAFF")
        return button
    }()
    
    private func addComponents(){
        self.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(addCapsuleTitleLabel)
        contentView.addSubview(addCapsuleTitleTextField)
        contentView.addSubview(imageCollectionView)
        
        contentView.addSubview(addTextLabel)
        contentView.addSubview(addTextTextView)
        contentView.addSubview(addDateLabel)
        contentView.addSubview(addDatePicker)
        contentView.addSubview(addTagLabel)
        contentView.addSubview(addTagButton)
        contentView.addSubview(tagDropDownTableView)
        self.addSubview(cancelCreationButton)
        self.addSubview(doneCreationButton)
        
        scrollView.snp.makeConstraints{ make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.left.right.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(110)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView) //스크롤뷰와 똑같은 너비
            make.height.equalTo(845) //스크롤 가능하도록 콘텐츠 높이 설정
        }
        
        addCapsuleTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalTo(addCapsuleTitleTextField.snp.leading).offset(8)
            make.height.equalTo(17)
        }
        
        addCapsuleTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(addCapsuleTitleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(273)
            make.height.equalTo(49)
        }
        
        addImageButton.snp.makeConstraints{ make in
            make.height.width.equalTo(120)
        }
        
        imageCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(addCapsuleTitleTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(59)
            make.trailing.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(imageCollectionView.snp.width)
        }
        
        addTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(addCapsuleTitleLabel.snp.leading)
            make.top.equalTo(imageCollectionView.snp.bottom).offset(40)
            make.height.equalTo(17)
        }
        
        addTextTextView.snp.makeConstraints { make in
            make.top.equalTo(addTextLabel.snp.bottom).offset(8)
            make.width.equalTo(273)
            make.height.equalTo(196)
            make.centerX.equalToSuperview()
            make.width.equalTo(273)
        }
        
        addDateLabel.snp.makeConstraints { make in
            make.top.equalTo(addTextTextView.snp.bottom).offset(45)
            make.width.equalTo(60)
            make.height.equalTo(19)
            make.leading.equalTo(addCapsuleTitleLabel.snp.leading)
        }
        
        addDatePicker.snp.makeConstraints{ make in
            make.centerY.equalTo(addDateLabel.snp.centerY)
            //make.width.equalTo(90)
            make.trailing.equalTo(addTextTextView.snp.trailing).inset(8)
        }
        
        addTagLabel.snp.makeConstraints{ make in
            make.top.equalTo(addDateLabel.snp.bottom).offset(45)
            make.leading.equalTo(addCapsuleTitleLabel.snp.leading)
            make.height.equalTo(17)
        }
        
        addTagButton.snp.makeConstraints{ make in
            make.top.equalTo(addTagLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(273)
            make.height.equalTo(49)
        }
        
        tagDropDownTableView.snp.makeConstraints { make in
            make.top.equalTo(addTagButton.snp.bottom).offset(0)
            make.leading.trailing.equalTo(addTagButton)
            make.height.equalTo(130)
        }
        
        cancelCreationButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(38)
            make.leading.equalToSuperview().offset(51)
            make.width.equalTo(140)
            make.height.equalTo(48)
        }
        
        doneCreationButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(38)
            make.trailing.equalToSuperview().inset(51)
            make.width.equalTo(140)
            make.height.equalTo(48)
        }

    }
}
