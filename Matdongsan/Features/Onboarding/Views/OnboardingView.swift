//
//  OnboardingView.swift
//  Matdongsan
//
//  Created by sujeong on 12/17/24.
//

import SwiftUI
import KakaoSDKUser

struct OnboardingView: View {
    let onLoginTap: () -> Void
    let onSkipTap: () -> Void
    @State private var currentPage = 0

    var body: some View {
        ZStack {
            Color(UIColor(hexCode: "FBE56A"))
            
            VStack {
                TabView(selection: $currentPage) {
                    VStack {
                        Image("onboarding1")
                            .resizable()
                            .frame(width: 282, height: 347)
                            .padding(.bottom, 24)
                        Text("제철음식을 기록하는\n나만의 작은 식량창고")
                            .bold()
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .frame(height: 480)
                    .tag(0)
                    
                    VStack {
                        Image("onboarding2")
                            .resizable()
                            .frame(width: 282, height: 347)
                            .padding(.bottom, 24)
                        Text("이번 달엔 뭘 먹어야 제일 맛있을까?")
                            .padding(.bottom, 16)
                        Text("이제 고민하지 마세요.\n맛동산이 알려드릴게요.")
                            .bold()
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .frame(height: 480)
                    .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .font(.system(size: 16))
                
                Button {
                    onLoginTap()
                } label: {
                    Text("맛동산 시작하기")
                }
                .padding(50)
                .frame(width: 250, height: 52)
                .background()
                .cornerRadius(15)
                .tint(.white)
                .bold()
                .foregroundColor(.black)
                
                Spacer(minLength: 20)
                
                HStack {
                    Text("이미 맛동산 회원이에요")
                        .font(.system(size: 13))
                        .foregroundColor(.mdGray70)
                    Button {
                        onLoginTap()
                    } label: {
                        Text("로그인")
                            .font(.system(size: 13))
                            .bold()
                            .foregroundColor(.mdGray90)
                    }
                }
                .padding(.bottom, 3)
                
                Button {
                    onSkipTap()
                } label: {
                    Text("로그인 없이 이용하기")
                        .font(.system(size: 13))
                }
                .foregroundColor(.mdGray70)
                .padding(.bottom, 100)

            }
        }
        .ignoresSafeArea()
        .task {
            TokenManager.shared.clear()
            UserApi.shared.logout { error in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 로그아웃 완료")
                }
            }
        }
    }
}

#Preview {
    OnboardingView(
        onLoginTap: {
        },
        onSkipTap: {
        }
    )
}
