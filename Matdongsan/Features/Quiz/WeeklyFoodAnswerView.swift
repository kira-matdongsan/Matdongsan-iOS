//
//  WeeklyFoodAnswerView.swift
//  Matdongsan
//
//  Created by sujeong on 10/12/25.
//

import SwiftUI

struct WeeklyFoodAnswerView: View {
    @Binding var enabledQuiz: Bool

    var body: some View {
        ZStack {
            // Background blur overlay (dimmed background)
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    enabledQuiz.toggle()
                }

            VStack(spacing: 26) {
                // 카드 영역
                VStack(spacing: 8) {
                    // 제목
                    VStack (spacing: 4) {
                        Image("star-black")
                            .resizable()
                            .frame(width: 32, height: 32)
                        
                        Text("6월 넷째주\n제철 음식은?")
                            .font(.system(size: 18, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.mdGray90)
                    }

                    // 이미지 영역 (옥수수 실루엣)
                    ZStack {
                        Image("corn02")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 144, height: 200)
                    }

                    // 안내 문구
                    VStack(spacing: 4) {
                        Text("알맹이부터 수염까지 아낌없이 주는")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.mdGray90)

                        Text("옥수수 🌽")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.mdGray90)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 4)
                    .background(.mdYellow20)
                    .cornerRadius(12)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 24)
                .background(.mdYellow40)
                .cornerRadius(24)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 29)

                // 하단 버튼
                Button(action: {
                }) {
                    Text("")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(.clear)
                }
            }
        }
    }
}

#Preview {
    WeeklyFoodAnswerView(enabledQuiz: .constant(true))
        .environment(\.colorScheme, .dark)
}
