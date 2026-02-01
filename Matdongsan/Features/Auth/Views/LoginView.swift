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
            Image("loginLogo")
                .resizable()
                .frame(width: 260, height: 278)
                .padding(.bottom, 73)
            
            Text("로그인을 통해 맛동산을 자유롭게 누려보세요 :)")
                .font(.system(size: 14))
                .padding(14)
                .foregroundStyle(.mdWarmGray90)
            
            AppleSigninButton()
                .cornerRadius(15)
                .frame(width: 260, height: 50)
                .padding(.bottom, 18)
            
            
            //            Button {
            //                // 네이버 아이디로 로그인
            //                NidOAuth.shared.requestLogin { result in
            //                    switch result {
            //                    case .success(let loginResult):
            //                        print("Access Token: ", loginResult.accessToken.tokenString)
            //                        print("Refresh Token: ", loginResult.refreshToken.tokenString)
            //
            //                        // get profile (temp)
            //                        NidOAuth.shared.getUserProfile(accessToken: loginResult.accessToken.tokenString) { result in
            //                            switch result {
            //                            case .success(let profileResult):
            //                                print(profileResult)
            //
            //                                guard let profileResultDict = try? JSONSerialization.data(withJSONObject: profileResult) else { return }
            //
            //
            //                                guard let userProfile: UserProfile = try? JSONDecoder().decode(UserProfile.self, from: profileResultDict) else { return }
            //
            //                                print(userProfile)
            //
            //                            case .failure(let error):
            //                                print("Error: ", error.localizedDescription)
            //                            }
            //                        }
            //
            //
            //                    case .failure(let error):
            //                        print("Error: ", error.localizedDescription)
            //                    }
            //                }
            //
            //            } label: {
            //                Image("naverBtn")
            //                    .resizable()
            //                    .frame(width: 28, height: 28)
            //                Text("네이버 로그인")
            //            }
            //            .bold()
            //            .frame(width: 260, height: 50)
            //            .background(.mdCoolgray80)
            //            .cornerRadius(15)
            //            .foregroundColor(.white)
            //            .padding(.bottom, 18)
            
            
            Button {
                kakaoLogin()
            } label: {
                Image("kakaoBtn")
                    .resizable()
                    .frame(width: 28, height: 28)
                Text("카카오 로그인")
            }
            .bold()
            .frame(width: 260, height: 50)
            .background(.black)
            .cornerRadius(15)
            .foregroundColor(.white)
            
            //            HStack {
            //                Button {
            //                    // TODO
            //                } label: {
            //                    Text("비밀번호 찾기")
            //                }
            //
            //                Text("/")
            //                    .padding(-3.0)
            //
            //                Button {
            //                    // TODO
            //                } label: {
            //                    Text("회원가입")
            //                }
            //            }
            //            .font(.callout)
            //            .tint(.mdGray100)
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
