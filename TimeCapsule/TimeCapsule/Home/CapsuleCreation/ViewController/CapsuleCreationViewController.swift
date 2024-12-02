//
//  CapsuleCreationViewController.swift
//  TimeCapsule
//
//  Created by 임지빈 on 11/1/24.
//

import UIKit

class CapsuleCreationViewController: UIViewController {
    
    var onNextStep: (() -> Void)?
    
    private lazy var capsuleCreationView: CapsuleCreationView = {
        let view = CapsuleCreationView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = capsuleCreationView
        setupNavigationBarBackgroundColor()
        
        capsuleCreationView.createButton.addTarget(self, action: #selector(createButtonTap), for: .touchUpInside)
        setupNavigationBar(action: #selector(customBackButtonTapped))
    }
    
    @objc
    private func createButtonTap() {
        let addVC = CapsuleCreation2ViewController()
        onNextStep?()
        //reloadCollectionView 클로저를 CapsuleCreation2ViewController로 전달
        navigationController?.pushViewController(addVC, animated: true)
    }
}
