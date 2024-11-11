//
//  AddImageService.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/11/24.
//

import Alamofire
import UIKit

/*
 request body
 image: (첫 번째 이미지 파일)
 image: (두 번째 이미지 파일)
 image: (세 번째 이미지 파일)
 image: (네 번째 이미지 파일)
 */

struct AddImageRequest : Encodable {
    
}

struct AddImageResponse : Decodable {
    let isSuccess :Bool
    let status : String
    let code: Int
    let message : String
    let result : [ImageResult]
}

struct ImageResult : Decodable {
    let imageId : Int
    let imageUrl : String
}

class AddImageService {
    let id = ""
    private let baseurl = "https://api-echo.shop/api/timecapsules/"
    private let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkYW5hbGltIiwicm9sZSI6IiIsImlhdCI6MTczMTI5OTYzMCwiZXhwIjoxNzMxMzAzMjMwfQ.EkIX7jyTiZz0yeJ3mekAfmrZicPrPbWINEduVq1jtMI"
    
    //
    func uploadImages(forCapsuleID id: String, images: [UIImage], completion: @escaping (Result<AddImageResponse, AFError>) -> Void) {
        
        let url = baseurl + id
        //header 추가
        let headers:HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)", // 인증 토큰 추가
            "Content-Type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { formData in
            for (index, image) in images.prefix(4).enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.8) {
                    formData.append(imageData, withName: "image", fileName: "image\(index + 1).jpg", mimeType: "image/jpeg")
                        }
                    }
        }, to: url, headers: headers).responseDecodable(of: AddImageResponse.self) { response in
            // Print the HTTP status code
            if let statusCode = response.response?.statusCode {
                print("Status code: \(statusCode)")
            }
                    
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                print("Networking error: \(error)")
                if let data = response.data, let errorResponse = String(data: data, encoding: .utf8) {
                    print("Server response: \(errorResponse)")
                }
                completion(.failure(error))
            }
        }
    }
}
