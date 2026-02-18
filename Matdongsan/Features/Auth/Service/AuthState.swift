//
//  AuthState.swift
//  Matdongsan
//
//  Created by sujeong on 1/28/26.
//

import Foundation
import AuthenticationServices


final class AuthState: ObservableObject {
    @Published var isLoggedIn = false

    func checkAppleLogin() {
        guard let userID = KeychainItem.currentUserIdentifier else {
            isLoggedIn = false
            return
        }

        ASAuthorizationAppleIDProvider()
            .getCredentialState(forUserID: userID) { state, _ in
                DispatchQueue.main.async {
                    self.isLoggedIn = (state == .authorized)
                }
            }
    }
}
