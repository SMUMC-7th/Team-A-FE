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
    //이미지 url list 저장
    private var imageUrls: [String] = []

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
        capsuleAIViewController.modalPresentationStyle = .fullScreen
        self.present(capsuleAIViewController, animated: false, completion: nil)
    }
    
    @objc
    func capsuleExitButtonTap(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //capsule detail view 띄워주는 메서드
    @objc
    func displayCapsuleDetail() {
        capsuleDetailService.fetchTimeCapsuleDetail(for: capsuleID) { result in
            switch result {
            case .success(let response):
                print("캡슐 디테일뷰 띄우기 성공: \(response)")
                DispatchQueue.main.async {
                    self.capsuleView.contentLabel.text = response.result?.content
                    self.capsuleView.capsuleTitleLabel.text = response.result?.title
                    
                    if let images = response.result?.imageList, !images.isEmpty {
                        // 이미지가 있을 경우
                        self.imageUrls = images
                        self.addImagesToScrollView()
                    } else {
                        // 이미지가 없을 경우
                        self.imageUrls = []
                        self.capsuleView.scrollview.isHidden = true
                        self.capsuleView.pageControl.isHidden = true
                        self.centerContentView()
                    }
                }
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
}

extension CapsuleViewController {
    private func centerContentView() {
        // 기존 constraint 제거
        capsuleView.contentScrollView.snp.removeConstraints()
        // contentScrollView 중앙 배치
            capsuleView.contentScrollView.snp.remakeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.left.right.equalTo(capsuleView.capsuleContentBox).inset(30)
                make.height.equalToSuperview().multipliedBy(0.2) // 적절한 높이 설정
        }
    }
    
}

//scroll하려면 필요
extension CapsuleViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        capsuleView.pageControl.currentPage = pageIndex
    }
}

extension CapsuleViewController {
    private func addImagesToScrollView() {
        capsuleView.scrollview.subviews.forEach { $0.removeFromSuperview() }
        
        let imageWidth = capsuleView.scrollview.bounds.width
        let imageHeight: CGFloat = capsuleView.scrollview.bounds.height
        
        imageUrls.enumerated().forEach { (index, urlString) in
            
            let formattedUrlString = urlString.hasPrefix("https://d20vni7b64fi71.cloudfront.net/") ? urlString : "https://d20vni7b64fi71.cloudfront.net/\(urlString)"
            guard let url = URL(string: formattedUrlString) else {
                print("잘못된 URL: \(formattedUrlString)")
                return
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self, let data = data, error == nil,
                        let image = UIImage(data: data) else {
                    print("이미지 다운로드 실패: \(formattedUrlString), 에러: \(error?.localizedDescription ?? "Unknown")")
                    return
                }
                
                DispatchQueue.main.async {
                    let imageView = UIImageView()
                    imageView.image = image
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    
                    // 이미지뷰 위치와 크기 설정
                    imageView.frame = CGRect(
                        x: CGFloat(index) * imageWidth,
                        y: 0,
                        width: imageWidth,
                        height: imageHeight
                    )
                    
                    self.capsuleView.scrollview.addSubview(imageView)
                    
                    // 스크롤뷰 콘텐츠 크기 설정
                    self.capsuleView.scrollview.contentSize = CGSize(
                        width: imageWidth * CGFloat(self.imageUrls.count ?? 0),
                        height: imageHeight
                    )
                    
                }
            }.resume()
        }
        self.capsuleView.pageControl.numberOfPages = self.imageUrls.count ?? 0
    }
}
