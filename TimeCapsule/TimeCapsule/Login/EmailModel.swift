//
//  EmailModel.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/14/24.
//

import Foundation

struct EmailRequest : Encodable {
    let email : String?
}

struct EmailResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String?
}

struct VertifyCodeRequest: Encodable {
    let email: String
    let code: String
}

struct VertifyCodeResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String?
}
