//
//  HomeView.swift
//  Matdongsan
//
//  Created by sujeong on 7/5/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var navigationManager:NavigationManager
    
    let month: Int = 7
    let week: String = "넷"
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }
    var discovered:Bool = false
    var weeks:[Int] = [4,5,6,7,8,9,10]
    
    var body: some View {
        
        VStack {
            // 탑바 (로고, 검색 아이콘)
            HStack {
                Image("small-logo")
                Spacer()
                Button {
                    navigationManager.navigate(to: .search)
                } label: {
                    Image("search-normal-80")
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 54)
            
            ScrollView {
                VStack (spacing: 0) {
                    
                    // 주간 제철 음식
                    HStack (alignment: .top) {
                        VStack (alignment: .leading, spacing: 13) {
                            Text("맛동산 pick")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.mdYellow30)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 4)
                                .background(.mdGray90)
                                .cornerRadius(32)
                            
                            VStack (alignment: .leading, spacing: 3) {
                                Text("\(month)월 \(week)째주")
                                Text("제철 음식은?")
                            }
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                            
                            Text("\(dateFormatter.string(from: Date()))")
                                .font(.caption)
                                .foregroundStyle(.mdCoolgray70)
                        }
                        
                        Spacer()
                        
                        Image("character")
                    }
                    .padding(24)
                    .background(.mdYellow30)
                    .cornerRadius(24)
                    .onTapGesture {
                        navigationManager.navigate(to: .detailView)
                    }
                    
                    // 주간 제철 기록장
                    WeeklyRecordView()
                    
                    // 투표결과
                    
                    // 제철 시세
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
