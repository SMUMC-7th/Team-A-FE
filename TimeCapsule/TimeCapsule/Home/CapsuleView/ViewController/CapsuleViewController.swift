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
        setupNavigationBarBackgroundColor()
        setupNavigationBar(action: #selector(customBackButtonTapped))
        
        capsuleView.AISummaryButton.addTarget(self, action: #selector(AISummaryButtonTap), for: .touchUpInside)
        capsuleView.capsuleExitButton.addTarget(self, action: #selector(capsuleExitButtonTap), for: .touchUpInside)
        //화면 로드될때 바로 디테일 띄움
        displayCapsuleDetail()
    }
    
    var capsuleID : Int
    
    private let capsuleDetailService = CapsuleDetailService()

    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    required init(capsuleID: Int) {
            self.capsuleID = capsuleID  // capsuleID 값 저장
            super.init(nibName: nil, bundle: nil)
        }
    
    //aibutton 누르면 요약해주는 요청 불러주는 메서드
    @objc
    func AISummaryButtonTap() {
        let capsuleAIViewController = CapsuleAIViewController(capsuleID: capsuleID)
        capsuleAIViewController.modalPresentationStyle = .fullScreen // Optional: Set to full screen if needed
        self.present(capsuleAIViewController, animated: false, completion: nil)
    }
    
    @objc
    func capsuleExitButtonTap(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //capsule detail view 띄워주는 메서드
    @objc
    func displayCapsuleDetail(){
        capsuleDetailService.fetchTimeCapsuleDetail(for: capsuleID){ result in
            switch result {
            case .success(let response):
                print("캡슐 디테일뷰 띄우기 성공: \(response)")
                DispatchQueue.main.async {
                    self.capsuleView.contentLabel.text = response.result.content
                    self.capsuleView.capsuleTitleLabel.text = response.result.title
                    
                    // 이미지 리스트가 존재하고 첫 번째 이미지 URL을 사용할 경우
                    
                    
                }
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    //
    @objc
    private func displayImage(from url: String){
        guard let imageUrl = URL(string: url) else { return }
    
        // 이미지 URL로부터 이미지 다운로드
        URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
                    
            // 메인 스레드에서 이미지 설정
            DispatchQueue.main.async {
                self.capsuleView.imageView.image = image
            }
        }.resume()
    }
}
