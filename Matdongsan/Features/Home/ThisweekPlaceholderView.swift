//
//  ThisweekPlaceholderView.swift
//  Matdongsan
//
//  Created by sujeong on 7/29/25.
//

import SwiftUI

struct ThisweekPlaceholderView: View {
    
    @EnvironmentObject private var navigationManager:NavigationManager

    let month: Int = 7
    let week: String = "넷"
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }
    
    var body: some View {
        HStack (alignment: .top) {
            VStack (alignment: .leading, spacing: 13) {
                Text("맛동산 pick")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.mdYellow30)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                    .background(.mdGray90)
                    .cornerRadius(32)
                
                VStack (alignment: .leading, spacing: 3) {
                    Text("\(month)월 \(week)째주")
                    Text("제철 음식은?")
                }
                .font(.system(size: 22, weight: .bold))
                
                Text("\(dateFormatter.string(from: Date()))")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.mdCoolgray70)
            }
            
            Spacer()
            
            Image("character")
            
        }
        .padding(24)
        .background(.mdYellow30)
        .frame(height: 238)
        .cornerRadius(24)
        
    }
}

#Preview {
    ThisweekPlaceholderView()
}
