//
//  KakaoLogin.swift
//  Matdongsan
//
//  Created by sujeong on 2/1/26.
//

import KakaoSDKAuth
import KakaoSDKUser

struct KakaoLoginService {
    
    func kakaoLogin(completion: @escaping (Result<String, Error>) -> Void) {
        // 카카오톡 실행 가능 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 로그인
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("카카오톡 로그인 success")
                    
                    // 추가작업
                    _ = oauthToken
                    guard let token = oauthToken?.accessToken else { return }
                    completion(.success(token))
                }
            }
        } else {
            // 카카오계정 로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("카카오계정 로그인 success")
                    
                    // 추가작업
                    _ = oauthToken
                    guard let token = oauthToken?.accessToken else { return }
                    completion(.success(token))
                }
            }
        }
    }
}
