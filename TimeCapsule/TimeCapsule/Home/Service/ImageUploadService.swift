//
//  AddImageService.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/18/24.
//

import Alamofire
import Foundation

// Decodable 모델 정의
struct ImageUploadResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [Int]
}

class ImageUploadService {
    let url = "https://api-echo.shop/api/timecapsules/images"
    let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkYW5hbGltMDgxOUBnbWFpbC5jb20iLCJyb2xlIjoiIiwiaWF0IjoxNzMxOTMwODI1LCJleHAiOjE3MzQ1MjI4MjV9.kC7PqeFK4P2zdlh_-_RsuSBrvH7Lib_fWCUUqo6VHhM"
    
    //이미지 업로드하는 메서드
    func sendImage (imageData: Data, completion: @escaping (Result<ImageUploadResponse, AFError>) -> Void){
    
        //accesstoken
        /*guard let accessToken = KeychainService.load(for: "RefreshToken") else {
            print("Error: No access token found.")
            return
        }*/
        
        //header 설정
        let headers: HTTPHeaders = [
                    "Authorization": "Bearer \(accessToken)", // 인증 토큰
                    "accept": "*/*",
                    "Content-Type": "multipart/form-data"
                ]
        //let parameters : Parameters = []
        //호출
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "uploadFiles", fileName: "image.jpeg", mimeType: "image/jpeg")
            },
            to: url,
            method: .post,
            headers: headers
        ).responseDecodable(of: ImageUploadResponse.self) { response in
            // 상태 코드 출력
            if let statusCode = response.response?.statusCode {
                print("HTTP 상태 코드: \(statusCode)")
            }
                    
            // 결과 처리
            switch response.result {
            case .success(let value):
                print("업로드 성공: \(value)")
                completion(.success(value))
            case .failure(let error):
                print("업로드 실패: \(error.localizedDescription)")
                if let data = response.data, let errorResponse = String(data: data, encoding: .utf8) {
                    print("서버 응답: \(errorResponse)")
                }
                completion(.failure(error))
            }
        }
    }
}
