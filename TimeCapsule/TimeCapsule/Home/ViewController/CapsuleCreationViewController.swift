//
//  CapsuleCreationViewController.swift
//  TimeCapsule
//
//  Created by 임지빈 on 11/1/24.
//

import UIKit

class CapsuleCreationViewController: UIViewController {
    
    private lazy var capsuleCreationView: CapsuleCreationView = {
        let view = CapsuleCreationView()
        //UINavigationController(rootViewController: MyViewController()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = capsuleCreationView
        capsuleCreationView.createButton.addTarget(self, action: #selector(createButtonTap), for: .touchUpInside)
    }
    
    @objc
    private func createButtonTap() {
        let viewController = CapsuleCreation2ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
