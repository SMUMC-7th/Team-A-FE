//
//  TimeCapsuleCollectionViewCell.swift
//  TimeCapsule
//
//  Created by 이승준 on 10/31/24.
//

import UIKit

class TimeCapsuleCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "TimeCapsuleCollectionViewCellIdentifier"
    
    private lazy var capsuleLayout: UIView = {
        let capsule = UIView()
        capsule.layer.borderWidth = 2
        capsule.layer.borderColor = UIColor.gray2.cgColor
        capsule.layer.cornerRadius = 50
        //capsule.backgroundColor = .gray9
        return capsule
    }()
    
    private lazy var mainContainer: UIView = {
        let container = UIView()
        //container.backgroundColor = .gray8
        return container
    }()
    
    public lazy var deleteCapsule: UIButton = {
        let button = UIButton()
        button.setImage(.capsuleDelete, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var stateContainer: UIView = {
        let container = UIView()
        //container.backgroundColor = .gray8
        return container
    }()
    
    private lazy var lightImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        return image
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(cgColor: CGColor(red: 159/256, green: 159/256, blue: 159/256, alpha: 1))
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = 0.5
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addComponents()
        
        
    }
    
    private func addComponents() {
        self.addSubview(capsuleLayout)
        
        capsuleLayout.addSubview(mainContainer)
        capsuleLayout.addSubview(deleteCapsule)
        
        mainContainer.addSubview(titleLabel)
        mainContainer.addSubview(stateContainer)
        mainContainer.addSubview(progressBar)
        
        stateContainer.addSubview(lightImage)
        stateContainer.addSubview(statusLabel)
        
        capsuleLayout.snp.makeConstraints { make in
            make.height.width.equalTo(156)
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        mainContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(31)
            make.top.bottom.equalToSuperview().inset(47)
        }
        
        deleteCapsule.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        stateContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.height.equalTo(17)
        }
        
        lightImage.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(statusLabel.snp.leading)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.trailing.bottom.equalToSuperview()
        }
        
        progressBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(data: TimeCapsuleTemp) {
        titleLabel.text = data.title
        lightImage.image = data.isAvailable ? UIImage(named: "AvailableLight") : UIImage(named: "UnavailableLight")
        statusLabel.text = data.days
    }
    
    
    
}

import SwiftUI

#Preview {
    HomeViewController()
}

