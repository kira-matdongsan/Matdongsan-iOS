//
//  MyPageView.swift
//  Matdongsan
//
//  Created by sujeong on 2/5/25.
//

import SwiftUI

struct UnloginMyPageView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    
    var body: some View {
        VStack {
            Image("mypageImg")
                .resizable()
                .frame(height: 260)
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
            
            VStack(spacing: 16) {
                Image("question-mark")
                    .resizable()
                    .frame(width: 56, height: 56)
                
                // 안내 문구
                Text("로그인 후 이용하실 수 있어요\n다양한 제철과일 소식을 위해 맛동산과 함께해요")
                    .font(.system(size: 14, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.mdGray80)
                
                // 로그인 버튼
                Button(action: {
                    navigationManager.navigate(to: .login)
                }) {
                    Text("로그인")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.mdSkyBlue50)
                        .cornerRadius(12)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.mdSkyBlue10)
            )
            .padding(.horizontal, 24)
            
            Spacer()
        }
    }
}

#Preview {
    UnloginMyPageView()
}

