//
//  FCMTokenManager.swift
//  TimeCapsule
//
//  Created by 이승준 on 11/18/24.
//

import Foundation
import Alamofire

struct FCMTokenRequest: Codable {
    let fcmToken: String
}

struct FCMTokenResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String
}

class FCMTokenManager {
    
    static let shared = FCMTokenManager()
    
    func sendFCMToken(fcmToken: String, token: String) {
        let url = "https://api-echo.shop/api/notifications/token"
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        let parameters = FCMTokenRequest(fcmToken: fcmToken)
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: FCMTokenResponse.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    print("FCM")
                    print("Success: \(apiResponse.isSuccess)")
                    print("Code: \(apiResponse.code)")
                    print("Message: \(apiResponse.message)")
                    print("Result: \(apiResponse.result)")
                case .failure(let error):
                    print("FCM Send Error: \(error.localizedDescription)")
                }
            }
    }
}
