//
//  CapsuleAIViewController.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/10/24.
//
import UIKit

class CapsuleAIViewController: UIViewController {
    
    private lazy var capsuleAIView: CapsuleAIView = {
        let view = CapsuleAIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = capsuleAIView
    }

}

