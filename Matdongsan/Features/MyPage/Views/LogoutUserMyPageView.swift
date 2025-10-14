//
//  LogoutUserMyPageView.swift
//  Matdongsan
//
//  Created by sujeong on 10/14/25.
//

import SwiftUI

import SwiftUI

struct LogoutUserMyPageView: View {
    var body: some View {
        VStack(spacing: 16) {
            // 상단 바
            VStack(spacing: 12) {
                ZStack {
                    Text("마이페이지")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                    HStack {
                        Spacer()
                        Button {
                            // 알림 버튼 액션
                        } label: {
                            Image("notification")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 1)
            }

            // 메인 캐릭터 카드
            Image("mypageImg")
                .resizable()
                .scaledToFill()
                .frame(height: 260)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 24)

            // 로그인 안내 카드
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.92, green: 0.97, blue: 1.0))
                .overlay(
                    VStack(spacing: 16) {
                        VStack(spacing: 6) {
                            Image("question-mark")
                                .resizable()
                                .frame(width: 56, height: 56)
                            Text("로그인 후 이용하실 수 있어요.\n다양한 제철과일 소식을 위해 맛동산과 함께해요")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.mdGray80)
                        }

                        Button(action: {
                            // 로그인 액션
                        }) {
                            Text("로그인")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 240, height: 46)
                                .background(.mdSkyBlue50)
                                .cornerRadius(8)
                        }
                    }
                    .padding(16)
                )
                .padding(.horizontal, 24)
                .frame(height: 196)

            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    LogoutUserMyPageView()
}
