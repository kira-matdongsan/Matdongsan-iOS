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
    @ObservedObject var loginViewModel: LoginViewModel
    
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
                        guard
                            let identityTokenData = appleIDCredential.identityToken,
                            let identityToken = String(data: identityTokenData, encoding: .utf8)
                        else {
                            return
                        }
                        auth.checkAppleLogin()
                        loginViewModel.socialSignIn(provider: "APPLE", accessToken: identityToken)
                        
                    case let passwordCredential as ASPasswordCredential:
                        auth.checkAppleLogin()
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
