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
    @State var discovered:Bool = false
    var weeks:[Int] = [4,5,6,7,8,9,10]
    
    var body: some View {
        
        VStack (spacing: 0) {
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
                    VStack {
                        if discovered {
                            ThisweekFoodView()
                        } else {
                            ThisweekPlaceholderView()
                        }
                    }
                    .onTapGesture {
                        discovered.toggle()
                    }
                    
                    // 주간 제철 기록장
                    WeeklyRecordView()
                    
                    // 투표결과
                    
                    // 제철 시세
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeView()
}
