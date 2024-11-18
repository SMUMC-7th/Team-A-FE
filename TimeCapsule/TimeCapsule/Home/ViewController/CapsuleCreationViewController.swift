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
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = capsuleCreationView
        capsuleCreationView.createButton.addTarget(self, action: #selector(createButtonTap), for: .touchUpInside)
    }
    
    @objc
    private func createButtonTap() {
        let addVC = CapsuleCreation2ViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
}
