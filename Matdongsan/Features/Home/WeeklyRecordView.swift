//
//  WeeklyRecordView.swift
//  Matdongsan
//
//  Created by sujeong on 7/27/25.
//

import SwiftUI

struct WeeklyRecordView: View {
    @EnvironmentObject private var navigationManager:NavigationManager

    let items:[Int] = Array(1...14)
    let weekday:[String] = ["일", "월", "화", "수", "목", "금", "토"]
    let columns = [GridItem(.flexible())]
    let today = 4
    let month = 7
    @State var selectedWeek = 0
    
    var body: some View {
        VStack (spacing: 8) {
            HStack {
                Text("\(month)월 제철기록장")
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .bold))

                Spacer()
                
                Button {
                    navigationManager.navigate(to: .calendar)
                } label: {
                    Text("전체보기")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.white)
                        .padding(4)
                        .background(.mdGray60)
                        .cornerRadius(4)
                }
            }
            .padding(.horizontal, 24)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Array(items.enumerated()), id: \.offset) { idx, date in
                        VStack (spacing: 13) {
                            VStack(spacing: 20) {
                                Text("\(date)")
                                Text(weekday[idx % 7]) // 요일은 7로 나눈 나머지로 반복
                            }
                            .font(.system(size: 13, weight: .semibold))
                            .frame(width: 42, height: 66)
                            .background(date == today ? .mdYellow40 : .mdGray70)
                            .cornerRadius(24)
                            .foregroundStyle(date == today ? .mdGray90 : .white)
                            .font(.footnote)

                            Circle()
                                .frame(width: 4, height: 4)
                                .foregroundStyle(date == today ? .white : .clear) // temp : today아니고 기록 있는 날만
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            
            HStack (spacing: 8) {
                Image("medal")

                VStack (alignment: .leading, spacing: 4) {
                    Text("먹었어요")
                        .foregroundStyle(.mdGray30)
                        .font(.system(size: 12, weight: .semibold))
                    Text("옥수수")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.mdYellow40)
                }
                .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(6)
            .frame(height: 48)
            .background(.mdGray70)
            .cornerRadius(16)
            .padding(.horizontal, 4)
            .padding(.horizontal, 24)
        }
        .padding(.vertical, 16)
        .background(.mdWarmGray80)
        .cornerRadius(24)
    }
}

#Preview {
    WeeklyRecordView()
}
