//
//  AddImageService.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/18/24.
//

import Alamofire
import Foundation

// MARK: 캡슐 추가 모델
//request body
struct TimeCapsuleRequest: Encodable {
    let title: String
    let content: String
    let deadline: String
    let tagName: String
    let imageList : [Int]
}

// Decodable 모델 정의
struct CapsuleResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ResultData?   // result가 없을때를 방지해서 옵셔널 처리해줘야함

    struct ResultData: Decodable {
        let id: Int
        let createdAt: String
    }
}

// MARK: 이미지 업로드 모델 
// Decodable 모델 정의(응답모델)
struct ImageUploadResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [Int]
}
