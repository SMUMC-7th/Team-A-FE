//
//  MyPageViewController.swift
//  TimeCapsule
//
//  Created by 김민지 on 10/31/24.
//

import UIKit

class MyPageViewController: UIViewController {
    private var myPageView: MyPageView = {
        let view = MyPageView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = myPageView
        view.backgroundColor = .white 
    }
}
