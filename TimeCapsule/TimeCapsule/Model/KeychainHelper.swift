//
//  KeychainHelper.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/10/24.
//

import Foundation
import Security

class KeychainHelper {
    
    static let shared = KeychainHelper()
    
    // Keychain에 저장하는 함수
    func saveToKeychain(value: String, for key: String) {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]
            
            // 기존에 해당 key가 존재하는지 확인 후 삭제
            SecItemDelete(query as CFDictionary)
            
            // 새로운 데이터 저장
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    // Keychain에서 데이터를 읽어오는 함수
    func loadFromKeychain(for key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data, let value = String(data: data, encoding: .utf8) {
            return value
        } else {
            return nil
        }
    }
    
    // Keychain에서 데이터 삭제
    func deleteFromKeychain(for key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
