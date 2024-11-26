//
//  CapsuleAIViewController.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/10/24.
//
import UIKit

class CapsuleAIViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = capsuleAIView
        setupNavigationBarBackgroundColor()
        setupNavigationBar(action: #selector(customBackButtonTapped))
        
        capsuleAIView.originalContentButton.addTarget(self, action: #selector(originalContentButtonTap), for: .touchUpInside)
        capsuleAIView.capsuleExitButton.addTarget(self, action: #selector(capsuleExitButtonTap), for: .touchUpInside)
        displayAISummary()
    }
    
    init(capsuleID: Int) {
            self.capsuleID = capsuleID  // Assign the capsuleID
            super.init(nibName: nil, bundle: nil)
        }
        
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var capsuleAIView: CapsuleAIView = {
        let view = CapsuleAIView()
        return view
    }()

    private let aiSummaryService = AISummaryService()
    private var capsuleID : Int
    
    //요약을 화면에 표시하는 메서드
    @objc
    private func displayAISummary(){
        print("\(capsuleID)")
        aiSummaryService.fetchAISummary(for: capsuleID) { result in
            switch result {
            case .success(let response):
                print("AI summary 생성 성공: \(response)")
                self.capsuleAIView.AISummaryLabel.text = response.result
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    @objc
    private func originalContentButtonTap(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc
    private func capsuleExitButtonTap() {
        self.dismiss(animated: false)
        }
    }


