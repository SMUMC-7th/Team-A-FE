//
//  AISummaryService.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/16/24.
//

import Alamofire

//no request body

class AISummaryService {
    let baseurl = "https://api-echo.shop/timecapsules"

    func fetchAISummary(for timeCapsuleId: Int, completion: @escaping (Result<CapsuleAIResponse, AFError>) -> Void) {
        
        let url = "\(baseurl)/{\(timeCapsuleId)}/ai"
        print("\(url)")
        
        //accesstoken
        guard let accessToken = KeychainService.load(for: "RefreshToken") else {
            print("Error: No access token found.")
            return
        }
        
        //header 추가
        let headers:HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)", // 인증 토큰 추가
            "accept": "*/*",
            "Content-Type": "application/json"
        ]
        

        //요청 보내기
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: CapsuleAIResponse.self) { response in
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
