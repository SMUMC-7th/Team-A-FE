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
    let result: ResultData

    struct ResultData: Decodable {
        let capsuleId: Int
        let userId: Int
        let isOpened : Bool
        let title : String
        let content : String
        let imageList : ImageData
        let tagName : String
        let createdAt : String
        let now : String
        let deadline : String
        
        struct ImageData : Decodable {
            let imageId : Int
            let imageUrl : String
        }
    }
}

class CapsuleDetailService {
    let baseurl = "https://api-echo.shop/api/timecapsules"
    //let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkYW5hbGltMDgxOUBnbWFpbC5jb20iLCJyb2xlIjoiIiwiaWF0IjoxNzMxNzY1MDg3LCJleHAiOjE3MzQzNTcwODd9.a1pzijoy94z5iy_QXbfFrWgLO1vIncgQpD4I9_FgXQ8"
    
    func fetchTimeCapsuleDetail(for timeCapsuleId: Int, completion: @escaping (Result<CapsuleDetailResponse, AFError>) -> Void) {
        guard let accessToken = KeychainService.load(for: "AccessToken") else {
            print("Error: No access token found.")
            return
        }
        
    func fetchTimeCapsuleDetail(for timeCapsuleId: Int, completion: @escaping (Result<CapsuleDetailResponse, AFError>) -> Void) {
            
            let url = "\(baseurl)/\(timeCapsuleId)/ai"
            
            //header 추가
            let headers:HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)", // 인증 토큰 추가
                "accept": "*/*",
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: CapsuleDetailResponse.self) { response in
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
}
