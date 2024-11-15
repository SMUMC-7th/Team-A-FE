//
//  EmailModel.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/14/24.
//

import Foundation

struct EmailRequest : Codable {
    let email : String
}

struct EmailResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String?
}
