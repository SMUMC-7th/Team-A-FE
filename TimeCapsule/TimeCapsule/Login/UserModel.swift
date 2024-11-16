//
//  Untitled.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/6/24.
//

import Foundation

// MARK: 회원가입 응답모델
struct SignupRequest: Codable {
    let email: String
    let nickname: String
    let password: String
}

struct UserResponse: Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : UserResult?
}

struct UserResult: Codable {
    let id : Int
    let email : String
    let nickname : String
    let authType : String
}


// MARK: 로그인 응답모델
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
    let result: LoginResult?
}

struct LoginResult: Codable {
    let accessToken: String
    let refreshToken: String
}


// MARK: 로그아웃, 회원탈퇴 응답모델
struct DeleteUserResponse: Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : String
}


