//
//  TimeCapsuleDetailService.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/16/24.
//

import Alamofire

//Decodable 모델 정의
struct CapsuleDetailResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ResultData?

    struct ResultData: Decodable {
        let capsuleId: Int
        let userId: Int
        let isOpened : Bool
        let title : String
        let content : String
        let imageList : [String]?
        let tagName : String
        let createdAt : String
        let now : String
        let deadline : String
    }
}

class CapsuleDetailService {
    let baseurl = "https://api-echo.shop/api/timecapsules"

    func fetchTimeCapsuleDetail(for timeCapsuleId: Int, completion: @escaping (Result<CapsuleDetailResponse, AFError>) -> Void) {
        
        guard let accessToken = KeychainService.load(for: "RefreshToken") else {
            print("Error: No access token found.")
            return
        }
        print("Access Token: \(accessToken)")
        
        let url = "\(baseurl)/\(timeCapsuleId)"
        
        // HTTP 헤더 설정
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)", // 인증 토큰
            "accept": "*/*",
            //"Content-Type": "application/json"
        ]
        
        // Alamofire로 GET 요청 보내기
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: CapsuleDetailResponse.self) { response in
            // 응답 상태 코드 출력
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
