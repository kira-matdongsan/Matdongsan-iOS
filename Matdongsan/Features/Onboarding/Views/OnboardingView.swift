//
//  OnboardingView.swift
//  Matdongsan
//
//  Created by sujeong on 12/17/24.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack {
            Color(.yellow)
            
            VStack {
                Text("제철음식을 기록하는\n나만의 작은 식량창고")
                    .multilineTextAlignment(.center)
                    .padding(.top, 100.0)
                    .font(.title2)

                LazyHStack {
                    Image("맛동산 아이콘")
                    Image("맛동산 아이콘")
                    Image("맛동산 아이콘")
                }
                
                Button("맛동산 시작하기") {
                    
                }
                .padding(50)
                .frame(width: 250, height: 52)
                .background()
                .cornerRadius(15)
                .tint(.white)
                .bold()
                .foregroundColor(.black)
                
                Spacer(minLength: 20)
                
                Button("이미 맛동산 회원이에요") {
                }
                .foregroundColor(.black)
                .padding(.bottom, 100)
            }
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    OnboardingView()
}
