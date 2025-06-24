//
//  JoinView.swift
//  Matdongsan
//
//  Created by sujeong on 12/20/24.
//

import SwiftUI
import NidThirdPartyLogin

struct LoginView: View {
    var body: some View {
        VStack {
            Image("mds_icon")
                .padding(40)
                .background(.mdCoolgray80)
                .cornerRadius(20)
            
            Text("Text")
                .padding(32)
                .foregroundStyle(.mdGray90)
            
            NavigationLink(destination: EmailLoginView()){
                Text("이메일 로그인")
            }
            .bold()
            .frame(width: 260, height: 50)
            .background(.mdCoolgray80)
            .cornerRadius(15)
            .foregroundColor(.white)
            .padding(.bottom, 18)
            
            
            Button {
                // 네이버 아이디로 로그인
                NidOAuth.shared.requestLogin { result in
                    switch result {
                    case .success(let loginResult):
                        print("Access Token: ", loginResult.accessToken.tokenString)
                        print("Refresh Token: ", loginResult.refreshToken.tokenString)
                        
                        // get profile (temp)
                        NidOAuth.shared.getUserProfile(accessToken: loginResult.accessToken.tokenString) { result in
                            switch result {
                            case .success(let profileResult):
                                print(profileResult)
                                
                                guard let profileResultDict = try? JSONSerialization.data(withJSONObject: profileResult) else { return }
                                
                                
                                guard let userProfile: UserProfile = try? JSONDecoder().decode(UserProfile.self, from: profileResultDict) else { return }
                                
                                print(userProfile)
                                
                            case .failure(let error):
                                print("Error: ", error.localizedDescription)
                            }
                        }
                        
                        
                    case .failure(let error):
                        print("Error: ", error.localizedDescription)
                    }
                }
                
            } label: {
                Image("naverBtn")
                    .resizable()
                    .frame(width: 28, height: 28)
                Text("네이버 로그인")
            }
            .bold()
            .frame(width: 260, height: 50)
            .background(.mdCoolgray80)
            .cornerRadius(15)
            .foregroundColor(.white)
            .padding(.bottom, 18)
            
            
            Button {
                // action
                // 카카오톡 실행 가능 여부 확인
                //                    if (UserApi.isKakaoTalkLoginAvailable()) {
                //                        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                //                            if let error = error {
                //                                print(error)
                //                            }
                //                            else {
                //                                print("loginWithKakaoTalk() success.")
                //
                //                                // 성공 시 동작 구현
                //                                _ = oauthToken
                //                            }
                //                        }
                //                    } else {
                //                        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                //                            if let error = error {
                //                                print(error)
                //                            }
                //                            else {
                //                                print("loginWithKakaoAccount() success.")
                //
                //                                // 성공 시 동작 구현
                //                                _ = oauthToken
                //
                //
                //                            }
                //                        }
                //                    }
            } label: {
                Image("kakaoBtn")
                    .resizable()
                    .frame(width: 28, height: 28)
                Text("카카오 로그인")
            }
            .bold()
            .frame(width: 260, height: 50)
            .background(.mdCoolgray80)
            .cornerRadius(15)
            .foregroundColor(.white)
            .padding(.bottom, 48)
            
            HStack {
                Button {
                    // TODO
                } label: {
                    Text("비밀번호 찾기")
                }
                
                Text("/")
                    .padding(-3.0)
                
                Button {
                    // TODO
                } label: {
                    Text("회원가입")
                }
            }
            .font(.callout)
            .tint(.mdGray100)
        }
        //            .toolbar(content: {
        //                ToolbarItem(placement: .topBarLeading) {
        //                    Button {
        //                        // TODO
        //                    } label: {
        //                        Image(systemName: "chevron.backward")
        //                            .tint(.black)
        //                    }
        //                    .padding(10)
        //                }
        //            })
    }
}

#Preview {
    LoginView()
}
