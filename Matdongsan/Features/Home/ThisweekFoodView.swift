//
//  ThisWeekFood.swift
//  Matdongsan
//
//  Created by sujeong on 7/28/25.
//

import SwiftUI

struct ThisweekFoodView: View {
    @EnvironmentObject private var navigationManager:NavigationManager

    private var food: String = "옥수수 🌽"
    private var subTitle: String = "알맹이부터 수염까지\n아낌없이 주는"
    
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 12) {
                Text("이번주 제철음식")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.mdGray80)
                    .padding(8)
                    .background(.mdYellow10)
                    .cornerRadius(32)
                
                Text(food)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.mdGray90)
                
                Text(subTitle)
                    .font(.system(size: 13, weight: .bold))
                    .lineLimit(2)
                    .foregroundStyle(.mdGray90)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
            
            Image("corn02")
                .resizable()
                .scaledToFit()
                .frame(width: 97, height: 105)
                .onTapGesture {
                    navigationManager.navigate(to: .detailView)
                }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .background()
        .cornerRadius(24)
        .frame(height: 148)
        .shadow(color: Color(uiColor: UIColor(hexCode: "DDE1E6", alpha: 0.6)), radius: 3, x: 1, y: 2)
    }
}

#Preview {
    ThisweekFoodView()
//        .background(.mdGray10)
}
