//
//  TimeCapsuleCreationService.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/11/24.
//

import Alamofire

//request body
struct TimeCapsuleRequest: Encodable {
    let title: String
    let content: String
    let deadline: String
    let tagName: String
}

// Decodable 모델 정의
struct CapsuleResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ResultData

    struct ResultData: Decodable {
        let id: Int
        let createdAt: String
    }
}

class CapsuleCreationService {
    let url = "https://api-echo.shop/api/timecapsules"
    //let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkYW5hbGltMDgxOUBnbWFpbC5jb20iLCJyb2xlIjoiIiwiaWF0IjoxNzMxNzY1MDg3LCJleHAiOjE3MzQzNTcwODd9.a1pzijoy94z5iy_QXbfFrWgLO1vIncgQpD4I9_FgXQ8"
    
    //
    func createTimeCapsule(requestData: TimeCapsuleRequest, completion: @escaping (Result<CapsuleResponse, AFError>) -> Void) {
        
        //accesstoken
        guard let accessToken = KeychainService.load(for: "AccessToken") else {
            print("Error: No access token found.")
            return
        }
        
        //header 추가
        let headers:HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)", // 인증 토큰 추가
            "accept": "*/*",
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: requestData, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: CapsuleResponse.self) { response in
                // 응답의 HTTP 상태 코드를 확인하여 출력
                if let statusCode = response.response?.statusCode {
                        print("상태 코드: \(statusCode)")
                }
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    print("네트워킹 오류: \(error)")
                    if let data = response.data, let errorResponse = String(data: data, encoding: .utf8) {
                        print("서버 응답: \(errorResponse)")
                    }
                    completion(.failure(error))
                }
            }
        }
}
