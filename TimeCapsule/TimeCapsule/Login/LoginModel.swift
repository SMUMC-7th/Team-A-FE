//
//  Untitled.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/6/24.
//

import Foundation

// 서버 회원가입 응답 구조체
struct SignupResponse: Decodable {
    let isSuccess : Bool
    let status : String
    let code : Int
    let message : String
    let result : [SignupResult]
}

struct SignupResult: Decodable {
    let id : Int?
    let email : String?
    let nickname : String?
    let password : String?
}

// 서버 로그인 응답 구조체
struct LoginResponse: Decodable {
    let isSuccess : Bool
    let status : String
    let code: Int
    let message : String
    let result: [LoginResult]
}

struct LoginResult: Decodable {
    let accessToken: String
    let refreshToken: String
}


