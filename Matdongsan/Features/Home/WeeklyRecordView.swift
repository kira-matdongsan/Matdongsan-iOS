//
//  WeeklyRecordView.swift
//  Matdongsan
//
//  Created by sujeong on 7/27/25.
//

import SwiftUI

struct WeeklyRecordView: View {
    let items:[Int] = Array(1...14)
    let weekday:[String] = ["일", "월", "화", "수", "목", "금", "토"]
    let columns = [GridItem(.flexible())]
    let today = 4
    let month = 7
    @State var selectedWeek = 0
    
    var body: some View {
        VStack (spacing: 16){
            HStack {
                Text("\(month)월 제철기록장")
                    .foregroundStyle(.white)
                    .bold()
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("전체보기")
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .padding(4)
                        .background(.mdGray60)
                        .cornerRadius(4)
                }
            }
            .padding(.horizontal, 24)
            
            TabView (selection: $selectedWeek) {
                // 한 페이지에 3개씩 묶어서 보여줌
                ForEach(0..<(items.count % 7 == 0 ? items.count/7 : items.count/7+1), id: \.self) { pageIndex in
                    let start = pageIndex * 7
                    let end = min(start + 7, items.count)
                    let pageItems = items[start..<end]
                    
                    HStack(alignment: .top, spacing: 8) {
                        ForEach(Array(pageItems.enumerated()), id: \.offset) { idx, date in
                            VStack {
                                VStack (spacing: 20) {
                                    Text("\(date)")
                                    Text(weekday[idx])
                                }
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .frame(height: 78)
                                .background(date == today ? .mdYellow40 : .mdGray70)
                                .cornerRadius(24)
                                .foregroundStyle(date == today  ? .mdGray90 : .white)
                                .font(.footnote)
                                
                                if date == today {
                                    Circle()
                                        .frame(width: 7, height: 7)
                                        .foregroundStyle(.mdYellow30)
                                }
                            }
                        }
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: UIScreen.main.bounds.width - 8)
            
            HStack (spacing: 8) {
                Image("medal")

                VStack (alignment: .leading, spacing: 4) {
                    Text("먹었어요")
                        .foregroundStyle(.mdGray30)
                        .font(.footnote)
                    Text("옥수수")
                        .foregroundStyle(.mdYellow40)
                }
                .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(8)
            .background(.mdGray70)
            .cornerRadius(16)
            .padding(.horizontal, 4)
        }
        .frame(height: 205)
        .padding(.vertical, 24)
        .background(.mdWarmGray80)
        .cornerRadius(24)
    }
}

#Preview {
    WeeklyRecordView()
}
