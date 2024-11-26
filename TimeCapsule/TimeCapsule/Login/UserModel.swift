//
//  Untitled.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/6/24.
//

import Foundation

// MARK: 회원가입 모델
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


// MARK: 로그인 모델
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


// 로그인시 인증번호 확인
struct EmailVertifyCodeRequest: Codable {
    let email: String
}

struct EmailVertifyCodeResponse: Codable {
    let isSuccess : Bool
    let code: String
    let message : String
    let result: String?
}

// MARK: 토큰 재발급 모델
struct ReissueResponse: Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result: String?
}


// MARK: 로그아웃, 회원탈퇴 모델
struct DeleteUserResponse: Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : String
}


// MARK: 비밀번호 변경 모델
// 로그인화면에서 비밀번호 변경
struct PasswordChangeRequestinLoginPage: Codable {
    let email: String
    let password: String
}

// 마이페이지에서 비밀번호 변경
struct PasswordChangeRequestinMyPage: Codable {
    let oldPassword: String
    let newPassword: String
}

struct PasswordChangeResponse: Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : String?
}


// MARK: 닉네임 변경 모델
struct NicknameChangeRequest: Codable {
    let newNickname: String
}

struct NicknameChangeResponse: Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : String?
}