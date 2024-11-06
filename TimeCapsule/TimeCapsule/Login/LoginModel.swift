//
//  Untitled.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/6/24.
//

// 서버 로그인 응답 구조체
struct LoginResponse: Decodable {
    let isSuccess : Bool
    let status : String
    let code: Int
    let message : String
    let result: LoginResult
}

struct LoginResult: Decodable {
    let accessToken: String
    let refreshToken: String
}
