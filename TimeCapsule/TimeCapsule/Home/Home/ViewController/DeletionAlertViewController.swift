//
//  DeletionAlertViewController.swift
//  TimeCapsule
//
//  Created by 이승준 on 11/11/24.
//

import UIKit

class DeletionAlertViewController: UIViewController {
    
    let alert = CustomAlertView()
    
    var data: TimeCapsulePreview?
    
    var didConfirmDeletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.setupView(confirmText: "삭제", confirmColor: .red, title: data!.title, message: "캡슐을 삭제하시겠습니까?")
        self.view = alert
        alert.confirmButton.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
        alert.cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
    }
    
    @objc
    private func confirmPressed() {
        if let data = data {
            guard let token = KeychainService.load(for: "RefreshToken") else {
                print("Error: No Refresh Token found.")
                return
            }
            TimeCapsulePreviewService.shared.deleteTimeCapsule(id: data.id, token: token) { result in
                switch result {
                case .success(let response):
                    TimeCapsulePreviewModel.original.removeAll { $0.id == data.id }
                    TimeCapsulePreviewModel.filtered.removeAll { $0.id == data.id }
                    TimeCapsulePreviewModel.filter()
//                    TimeCapsulePreviewService.shared.fetchTimeCapsulesPagination(token: token) { result in
//                        switch result {
//                        case .success(let timeCapsules):
//                            TimeCapsulePreviewModel.original = timeCapsules
//                            //TimeCapsulePreviewModel.filtered = timeCapsules
//                            self.didConfirmDeletion?()
//                        case .failure(let error):
//                            print("타임캡슐 조회 실패: \(error.localizedDescription)")
//                            // 에러 처리를 수행합니다.
//                        }
//                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    private func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    
}
