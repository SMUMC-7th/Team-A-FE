//
//  CapsuleViewController.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/10/24.
//

import UIKit

class CapsuleViewController: UIViewController {
    
    private lazy var capsuleView: CapsuleView = {
        let view = CapsuleView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = capsuleView
    }

}
