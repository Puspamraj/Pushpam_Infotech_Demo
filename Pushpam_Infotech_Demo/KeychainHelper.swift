//
//  KeychainHelper.swift
//  Pushpam_Infotech_Demo
//
//  Created by Pushpam Raj on 27/02/25.
//

import Foundation
import Security

class KeychainHelper {
    static let userKey = "authenticatedUser"

    static func saveUser(_ user: User) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(user) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: userKey,
                kSecValueData as String: encodedData
            ]
            SecItemDelete(query as CFDictionary) // Remove any existing data
            SecItemAdd(query as CFDictionary, nil)
        }
    }

    static func getUser() -> User? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: userKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == noErr {
            if let retrievedData = dataTypeRef as? Data {
                let decoder = JSONDecoder()
                return try? decoder.decode(User.self, from: retrievedData)
            }
        }
        return nil
    }

    static func clearUser() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: userKey
        ]
        SecItemDelete(query as CFDictionary)
    }
}
