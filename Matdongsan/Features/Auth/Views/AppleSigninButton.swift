//
//  AppleSigninButton.swift
//  Matdongsan
//
//  Created by sujeong on 1/28/26.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct AppleSigninButton: View {
    @EnvironmentObject var auth: AuthState

    var body: some View{
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Apple Login Successful")
                    switch authResults.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        // 계정 정보 가져오기
                        let userIdentifier = appleIDCredential.user
                        let fullName = appleIDCredential.fullName
                        let email = appleIDCredential.email
                        let identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                        let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                        
                        KeychainItem.currentUserIdentifier = userIdentifier
                        auth.checkAppleLogin()

                        print(userIdentifier, fullName, email, identityToken, authorizationCode)
                    case let passwordCredential as ASPasswordCredential:
                        let username = passwordCredential.user
                        let password = passwordCredential.password
                        KeychainItem.currentUserIdentifier = username
                        auth.checkAppleLogin()

                        print(username, password)
                    default:
                        break
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print("error")
                }
            }
        )
        .cornerRadius(5)
    }
}
