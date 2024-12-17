//
//  CapsuleAIView.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/10/24.
//

import UIKit

class CapsuleAIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray2
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var capsuleViewBox : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 28
        view.backgroundColor = .gray11
        return view
    }()
    
    private lazy var capsuleContentBox : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .gray2
        return view
    }()
    
    lazy var capsuleExitButton : UIButton = {
        let button = UIButton()
        let exitButton = UIImage(named: "exitbutton")
        button.setImage(exitButton, for: .normal)
        return button
    }()
    
    private lazy var capsuleNameLabel : UILabel = {
        let label = UILabel()
        label.text = "AI 요약"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "ThemeColor")
        return label
    }()
    
    lazy var contentScrollView : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = true
        scrollview.showsHorizontalScrollIndicator = false
        return scrollview
    }()
    
    lazy var AISummaryView : UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var AISummaryLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = false
        label.numberOfLines = 20
        return label
    }()
    
    lazy var originalContentButton : UIButton = {
        let button = UIButton()
        button.setImage(.originalContentButton, for: .normal)
        return button
    }()
    
    private func addComponents(){
        self.addSubview(capsuleViewBox)
        capsuleViewBox.addSubview(capsuleExitButton)
        capsuleViewBox.addSubview(capsuleContentBox)
        capsuleViewBox.addSubview(originalContentButton)
        capsuleViewBox.addSubview(capsuleNameLabel)
        capsuleContentBox.addSubview(contentScrollView)
        contentScrollView.addSubview(AISummaryView)
        AISummaryView.addSubview(AISummaryLabel)
        
        capsuleViewBox.snp.makeConstraints{ make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(18)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(28)
            make.left.right.equalToSuperview().inset(30)
        }
        
        capsuleExitButton.snp.makeConstraints{ make in
            make.top.equalTo(capsuleViewBox.snp.top).offset(7.3)
            make.leading.equalTo(capsuleViewBox.snp.leading).offset(8.3)
        }
        
        capsuleNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(capsuleViewBox.snp.top).offset(11)
            make.height.equalTo(24)
        }
        
        capsuleContentBox.snp.makeConstraints { make in
            make.top.equalTo(capsuleNameLabel.snp.bottom).offset(11)
            make.bottom.equalTo(capsuleViewBox).inset(56)
            make.left.right.equalTo(capsuleViewBox).inset(8)
            make.centerX.equalToSuperview()
        }
        
        contentScrollView.snp.makeConstraints{ make in
            make.top.equalTo(capsuleContentBox).offset(150)
            make.left.right.equalTo(capsuleContentBox).inset(25)
            make.centerY.equalToSuperview()
        }
        
        AISummaryView.snp.makeConstraints{ make in
            make.edges.equalTo(contentScrollView)
            make.width.equalTo(contentScrollView)
        }
        
        originalContentButton.snp.makeConstraints { make in
            make.top.equalTo(capsuleContentBox.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        
        AISummaryLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}
