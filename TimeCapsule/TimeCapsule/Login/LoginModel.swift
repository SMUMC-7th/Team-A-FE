//
//  Untitled.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/6/24.
//

import Foundation

// 서버 회원가입 응답 구조체
struct SignupRequest: Codable {
    let email: String
    let nickname: String
    let password: String
}

struct SignupResponse: Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : SignupResult
}

struct SignupResult: Codable {
    let id : Int
    let email : String
    let nickname : String
    let authType : String
}

struct ErrorResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
}


// 로그인 응답 구조체
struct EmailLoginRequest : Codable {
    let email : String
    let password: String
}

struct SocialLoginRequest : Codable {
    let email: String
    let nickname: String
}

struct LoginResponse: Decodable {
    let isSuccess : Bool
    let code: String
    let message : String
    let result: LoginResult
}

struct LoginResult: Codable {
    let accessToken: String
    let refreshToken: String
}


