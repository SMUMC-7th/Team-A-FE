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
        capsuleAIView.originalContentButton.addTarget(self, action: #selector(originalContentButtonTap), for: .touchUpInside)
    }
    
    //전달받을 AI summary text
    var AISummaryText : String? {
        //AISummaryText가 설정되면 자동으로 화면에 표시
        didSet {
            displayAISummary()
        }
    }
    
    //요약을 화면에 표시하는 메서드
    @objc
    private func displayAISummary(){
        guard let summaryText = AISummaryText
        else { return }
        capsuleAIView.AISummaryLabel.text = summaryText
    }
    
    @objc
    private func originalContentButtonTap(){
        navigationController?.popViewController(animated: true)
    }
}

