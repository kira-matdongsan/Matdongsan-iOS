//
//  KeychainItem.swift
//  Matdongsan
//
//  Created by sujeong on 1/28/26.
//


import Foundation
import Security

enum KeychainItem {
    private static let service = Bundle.main.bundleIdentifier!

    static var currentUserIdentifier: String? {
        get {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: "appleUserIdentifier",
                kSecReturnData as String: true
            ]

            var item: CFTypeRef?
            let status = SecItemCopyMatching(query as CFDictionary, &item)

            guard
                status == errSecSuccess,
                let data = item as? Data,
                let identifier = String(data: data, encoding: .utf8)
            else {
                return nil
            }

            return identifier
        }

        set {
            let account = "appleUserIdentifier"

            // 기존 값 삭제
            let deleteQuery: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account
            ]
            SecItemDelete(deleteQuery as CFDictionary)

            guard let value = newValue else { return }

            let addQuery: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account,
                kSecValueData as String: value.data(using: .utf8)!
            ]

            SecItemAdd(addQuery as CFDictionary, nil)
        }
    }
}
