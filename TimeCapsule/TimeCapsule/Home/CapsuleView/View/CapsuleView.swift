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
        view.backgroundColor = .gray11
        return view
    }()
    
    lazy var scrollview : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.isScrollEnabled = true
        scrollview.isPagingEnabled = true
        scrollview.bounces = true
        scrollview.layer.cornerRadius = 15
        return scrollview
    }()
    
    lazy var capsuleContentBox : UIView = {
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
    
    lazy var capsuleTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "ThemeColor")
        return label
    }()
    
    lazy var pageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    lazy var contentScrollView : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = true
        scrollview.showsHorizontalScrollIndicator = false
        return scrollview
    }()
    
    lazy var contentLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = false
        label.textAlignment = .center
        label.textColor = .black
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
        capsuleViewBox.addSubview(capsuleExitButton)
        capsuleViewBox.addSubview(capsuleContentBox)
        capsuleViewBox.addSubview(AISummaryButton)
        capsuleViewBox.addSubview(scrollview)
        capsuleViewBox.addSubview(pageControl)
        capsuleViewBox.addSubview(capsuleTitleLabel)
        capsuleContentBox.addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        contentView.addSubview(contentLabel)
        
        capsuleViewBox.snp.makeConstraints{ make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(18)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(28)
            make.left.right.equalToSuperview().inset(30)
        }
        
        capsuleExitButton.snp.makeConstraints{ make in
            make.top.equalTo(capsuleViewBox.snp.top).offset(7.3)
            make.leading.equalTo(capsuleViewBox.snp.leading).offset(8.3)
        }
        
        capsuleTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(capsuleViewBox.snp.top).offset(11)
            make.height.equalTo(24)
        }
        
        capsuleContentBox.snp.makeConstraints { make in
            make.top.equalTo(capsuleViewBox.snp.top).offset(46)
            make.bottom.equalTo(capsuleViewBox).inset(56)
            make.left.right.equalTo(capsuleViewBox).inset(8)
            make.centerX.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(scrollview.snp.bottom).inset(7)
            make.centerX.equalToSuperview()
        }
        
        scrollview.snp.makeConstraints { make in
            make.top.equalTo(capsuleContentBox.snp.top).offset(38)
            make.width.height.equalTo(260)
            make.centerX.equalToSuperview()
        }
        
        contentScrollView.snp.makeConstraints{ make in
            make.top.equalTo(scrollview.snp.bottom).offset(40)
            make.bottom.equalTo(capsuleContentBox).inset(5)
            make.left.right.equalTo(capsuleContentBox).inset(30)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(contentScrollView)
            make.width.equalTo(contentScrollView)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        AISummaryButton.snp.makeConstraints { make in
            make.top.equalTo(capsuleContentBox.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
    }
}
