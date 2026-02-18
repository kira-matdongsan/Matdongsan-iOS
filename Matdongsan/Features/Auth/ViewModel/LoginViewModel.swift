//
//  LoginViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 2/8/26.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {

    @Published var loginSucceeded = false
    
    private let kakaoLoginService: KakaoLoginService
    private let authAPIService: AuthAPIService

    init(
        kakaoLoginService: KakaoLoginService,
        authAPIService: AuthAPIService
    ) {
        self.kakaoLoginService = kakaoLoginService
        self.authAPIService = authAPIService
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
                KeychainManager.shared.save(key: "accessToken", value: response.accessToken)
                KeychainManager.shared.save(key: "refreshToken", value: response.refreshToken)
//                let token = KeychainManager.shared.read(key: "accessToken")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                self.loginSucceeded = true
            case .failure(let error):
                print("맛동산 로그인 실패", error)
            }
        }
    }
}
