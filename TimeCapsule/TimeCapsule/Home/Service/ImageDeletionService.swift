//
//  DeleteImageService.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/18/24.
//

import Alamofire

//decodable model 만들어주기
struct DeleteImageResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String
}


class ImageDeletionService {
    let baseurl = "https://api-echo.shop/api/timecapsules"
    //let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkYW5hbGltMDgxOUBnbWFpbC5jb20iLCJyb2xlIjoiIiwiaWF0IjoxNzMxNzY1MDg3LCJleHAiOjE3MzQzNTcwODd9.a1pzijoy94z5iy_QXbfFrWgLO1vIncgQpD4I9_FgXQ8"
    
    //이미지 삭제하는 메서드
    func deleteImage(timeCapsuleId: Int, imageId: Int, completion: @escaping (Result<DeleteImageResponse, AFError>) -> Void) {
        
        let url = "\(baseurl)/\(timeCapsuleId)/images/\(imageId)"
            
        //accesstoken
        guard let accessToken = KeychainService.load(for: "AccessToken") else {
            print("Error: No access token found.")
            return
        }
        
        // Header 설정
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "accept": "*/*"
        ]
            
        //요청 전송
        AF.request(url, method: .delete, headers: headers)
            .responseDecodable(of: DeleteImageResponse.self) { response in
                // 상태 코드 출력
                if let statusCode = response.response?.statusCode {
                    print("HTTP 상태 코드: \(statusCode)")
                }
                    
                // 결과 처리
                switch response.result {
                case .success(let value):
                    print("삭제 성공: \(value)")
                    completion(.success(value))
                case .failure(let error):
                    print("삭제 실패: \(error.localizedDescription)")
                    if let data = response.data, let errorResponse = String(data: data, encoding: .utf8) {
                        print("서버 응답: \(errorResponse)")
                    }
                    completion(.failure(error))
                }
            }
    }
}
