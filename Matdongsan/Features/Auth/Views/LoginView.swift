//
//  JoinView.swift
//  Matdongsan
//
//  Created by sujeong on 12/20/24.
//

import SwiftUI
import NidThirdPartyLogin

struct LoginView: View {
    
    @EnvironmentObject var authManager: AuthManager
    @StateObject private var viewModel: LoginViewModel
    
    init(authManager: AuthManager) {
        _viewModel = StateObject(
            wrappedValue: LoginViewModel(
                kakaoLoginService: KakaoLoginService(),
                authAPIService: AuthAPIService(),
                authManager: authManager
            )
        )
    }
    
    @State private var goToMain = false

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
            
            AppleSigninButton(loginViewModel: viewModel)
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
                viewModel.loginWithKakao()
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
        }
        .onReceive(authManager.$isLoggedIn) { success in
            if success {
                goToMain = true
            }
        }
        .fullScreenCover(isPresented: $goToMain) {
            MainTabView(showLogin: false)
        }
    }
}

#Preview {
    LoginView(authManager: AuthManager())
}
