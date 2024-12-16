//
//  CapsuleAIViewController.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/10/24.
//
import UIKit
import Alamofire

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
    private var capsuleID: Int

    // 요약을 화면에 표시하는 메서드
    private func displayAISummary() {
        print("\(capsuleID) 캡슐 AI 열었음")
        fetchAISummary(capsuleID: String(capsuleID))
    }

    // AI 요약 데이터를 서버에서 가져오는 메서드
    private func fetchAISummary(capsuleID: String) {
        let endpoint = "/timecapsules/{\(capsuleID)}/ai"
        print("Request URL: \(endpoint)")
        
        APIClient.postRequestWithoutParameters(endpoint: endpoint) { (result: Result<CapsuleAIResponse, AFError>) in
            switch result {
            case .success(let response):
                print("Response: \(response)")
                if response.isSuccess {
                    print("Successfully fetched AI summary: \(response.result)")
                } else {
                    print("Failed to fetch AI summary: \(response.message ?? "No message available")")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                if let underlyingError = error.underlyingError {
                    print("Underlying error: \(underlyingError)")
                }
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


