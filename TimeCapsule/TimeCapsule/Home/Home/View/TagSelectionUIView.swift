//
//  TagSelectionUIView.swift
//  TimeCapsule
//
//  Created by 이승준 on 11/2/24.
//

import UIKit

class TagSelectionUIView: UIView {
    let tags: [String] = K.String.tags
    
    private lazy var containerView: UIView = {
        let container = UIView()
        return container
    }()
    
    private lazy var hStackView: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private lazy var tagButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addComponents()
    }
    
    private func addComponents() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }}
