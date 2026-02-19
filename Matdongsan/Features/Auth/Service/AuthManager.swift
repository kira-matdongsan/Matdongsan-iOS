//
//  AuthManager.swift
//  Matdongsan
//
//  Created by sujeong on 2/19/26.
//

import Foundation


@MainActor
final class AuthManager: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    
    init() {
        isLoggedIn = TokenManager.shared.accessToken != nil
    }
    
    func login(access: String, refresh: String) {
        TokenManager.shared.save(accessToken: access, refreshToken: refresh)
        isLoggedIn = true
    }
    
    func logout() {
        TokenManager.shared.clear()
        isLoggedIn = false
    }
}
