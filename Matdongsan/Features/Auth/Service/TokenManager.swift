//
//  TokenManager.swift
//  Matdongsan
//
//  Created by sujeong on 2/14/26.
//


final class TokenManager {

    static let shared = TokenManager()
    private init() {}

    var accessToken: String? {
        KeychainManager.shared.read(key: "accessToken")
    }

    var refreshToken: String? {
        KeychainManager.shared.read(key: "refreshToken")
    }

    func save(accessToken: String, refreshToken: String) {
        KeychainManager.shared.save(key: "accessToken", value: accessToken)
        KeychainManager.shared.save(key: "refreshToken", value: refreshToken)
    }

    func clear() {
        KeychainManager.shared.delete(key: "accessToken")
        KeychainManager.shared.delete(key: "refreshToken")
    }
}
