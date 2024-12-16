//
//  AISummaryModel.swift
//  TimeCapsule
//
//  Created by 김민지 on 12/16/24.
//

import Alamofire
import Foundation

struct CapsuleAIResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String?
}


