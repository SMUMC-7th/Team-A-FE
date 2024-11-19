//
//  CapsuleView.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/10/24.
//

import UIKit

class CapsuleView: UIView {

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
        view.layer.borderColor = UIColor(named: "FAFAFA")?.cgColor
        view.layer.borderWidth = 0.2
        return view
    }()
    
    private lazy var capsuleContentBox : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor(named: "FAFAFA")?.cgColor
        view.layer.borderWidth = 0.2
        return view
    }()
    
    lazy var capsuleTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "6CBAFF")
        return label
    }()
    
    lazy var imageView : UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    lazy var contentScrollView : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = true
        scrollview.showsHorizontalScrollIndicator = false
        return scrollview
    }()
    
    lazy var contentLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var contentView : UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var AISummaryButton : UIButton = {
        let button = UIButton()
        button.setImage(.aiSummaryButton, for: .normal)
        return button
    }()
    
    private func addComponents(){
        self.addSubview(capsuleViewBox)
        capsuleViewBox.addSubview(capsuleContentBox)
        capsuleViewBox.addSubview(AISummaryButton)
        capsuleViewBox.addSubview(capsuleTitleLabel)
        capsuleContentBox.addSubview(imageView)
        capsuleContentBox.addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        contentView.addSubview(contentLabel)
        
        capsuleViewBox.snp.makeConstraints{ make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(18)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(28)
            make.left.right.equalToSuperview().inset(30)
        }
        
        capsuleTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(capsuleViewBox.snp.top).offset(11)
            make.height.equalTo(24)
        }
        
        capsuleContentBox.snp.makeConstraints { make in
            make.top.equalTo(capsuleTitleLabel.snp.bottom).offset(11)
            make.bottom.equalTo(capsuleViewBox).inset(56)
            make.left.right.equalTo(capsuleViewBox).inset(8)
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(capsuleContentBox.snp.top).offset(38)
            make.left.right.equalTo(capsuleContentBox).inset(31)
            make.bottom.equalTo(capsuleContentBox.snp.bottom).inset(310)
            make.centerX.equalToSuperview()
        }
        
        contentScrollView.snp.makeConstraints{ make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.bottom.equalTo(capsuleContentBox).inset(5)
            make.left.right.equalTo(capsuleContentBox).inset(30)
        }
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalTo(contentScrollView)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        AISummaryButton.snp.makeConstraints { make in
            make.top.equalTo(capsuleContentBox.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
    }
}
