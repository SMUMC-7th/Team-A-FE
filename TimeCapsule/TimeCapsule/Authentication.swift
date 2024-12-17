//
//  Authentication.swift
//  TimeCapsule
//
//  Created by 김민지 on 12/16/24.
//

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init() {} // 싱글톤

    func refreshAccessToken(completion: @escaping (Bool) -> Void) {
        guard let accessToken = KeychainService.load(for: "AccessToken") else {
            print("No access token found.")
            completion(false)
            return
        }
        
        guard let refreshToken = KeychainService.load(for: "RefreshToken") else {
            print("No refresh token found.")
            completion(false)
            return
        }

        let parameters: [String: String] = [
            "accessToken": accessToken,
            "refreshToken": refreshToken
        ]

        APIClient.postRequest(endpoint: "/auth/reissue", parameters: parameters) { (result: Result<RefreshResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    // 기존 토큰 삭제
                    handleTokenBlacklist()
                    
                    // 새로운 토큰 저장
                    if let newAccessToken = response.result?.accessToken,
                       let newRefreshToken = response.result?.refreshToken {
                        KeychainService.save(value: newAccessToken, for: "AccessToken")
                        KeychainService.save(value: newRefreshToken, for: "RefreshToken")
                        completion(true)
                    } else {
                        print("Failed to parse new tokens.")
                        completion(false)
                    }
                } else {
                    print("Failed to refresh token: \(response.message)")
                    completion(false)
                }
            case .failure(let error):
                print("Token refresh error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }

    
    func handleTokenBlacklist() {
        KeychainService.delete(for: "AccessToken")
        KeychainService.delete(for: "RefreshToken")
    }

}
