//
//  LoginViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 2/8/26.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    
    private let kakaoLoginService: KakaoLoginService
    private let authAPIService: AuthAPIService
    private let authManager: AuthManager

    init(
        kakaoLoginService: KakaoLoginService,
        authAPIService: AuthAPIService,
        authManager: AuthManager
    ) {
        self.kakaoLoginService = kakaoLoginService
        self.authAPIService = authAPIService
        self.authManager = authManager
    }

    func loginWithKakao() {
        kakaoLoginService.kakaoLogin { [weak self] result in
            switch result {
            case .success(let accessToken):
                self?.socialSignIn(provider: "KAKAO", accessToken: accessToken)
            case .failure(let error):
                print("카카오 로그인 실패", error)
            }
        }
    }

    func socialSignIn(provider: String, accessToken: String) {
        print(accessToken)
        authAPIService.postSocialSignIn(provider, accessToken) { result in
            print(result)
            switch result {
            case .success(let response):
                print("맛동산 로그인 성공")
                Task { @MainActor in
                    self.authManager.login(
                        access: response.accessToken,
                        refresh: response.refreshToken
                    )
                }
            case .failure(let error):
                print("맛동산 로그인 실패", error)
            }
        }
    }
}
