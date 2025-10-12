//
//  WeeklyFoodQuizView.swift
//  Matdongsan
//
//  Created by sujeong on 10/12/25.
//
import SwiftUI

struct WeeklyFoodQuizView: View {
    var body: some View {
        ZStack {
            // Background blur overlay (dimmed background)
            Color.black.opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                // 카드 영역
                VStack(spacing: 16) {

                    // 제목
                    Text("이번주 제철음식을 맞춰보세요")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.mdYellow40)

                    // 이미지 영역 (옥수수 실루엣)
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [6]))
                            .foregroundStyle(.mdGray50)
                            .frame(width: 160, height: 220)

                        Image("cornSilhouette") // 옥수수 흰색 실루엣 이미지 (Assets에 추가 필요)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 200)
                    }

                    // 제한 시간 텍스트
                    Text("제한 시간 20초")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.mdGray20)

                    // 안내 문구
                    VStack(spacing: 4) {
                        Text("모양을 따라 그려보세요.")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.mdGray90)

                        Text("정확히 그리면 정답 가능성이 높아져요!")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.mdGray70)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.mdYellow40)
                    .cornerRadius(12)
                }
                .padding(24)
                .frame(maxWidth: 300)
                .background(Color.mdGray90)
                .cornerRadius(24)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 4)

                // 하단 버튼
                Button(action: {
                    // TODO: 정답 확인 로직
                }) {
                    Text("정답 확인하기")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.mdGray70)
                        .cornerRadius(24)
                }
                .frame(width: 200)
            }
        }
    }
}

#Preview {
    WeeklyFoodQuizView()
        .environment(\.colorScheme, .dark)
}
