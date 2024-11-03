//
//  CapsuleCreation2ViewController.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/3/24.
//

import UIKit

class CapsuleCreation2ViewController: UIViewController {
    
    private lazy var capsuleCreation2View: CapsuleCreation2View = {
        let view = CapsuleCreation2View()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = capsuleCreation2View
        editNavigationBar()
    }
    
    func editNavigationBar(){
        let customBackButtonImage = UIImage(resource: .backButton)
        let customBackButton = UIBarButtonItem(image: customBackButtonImage, style: .plain, target: self, action: #selector(backButtonTap))
        
        self.navigationItem.title = "캡슐 생성"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = customBackButton
    }
    
    @objc func backButtonTap() {
        navigationController?.popViewController(animated: true)
    }
}
