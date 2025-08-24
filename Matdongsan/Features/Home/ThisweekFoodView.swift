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
    private var subTitle: String = "알맹이부터 수염까지 아낌없이 주는"
    
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
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.mdGray90)
                
                Text(subTitle)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.mdGray90)
            }
            .frame(maxWidth: 150) // temp
            
            Spacer()
            
            Image("corn02")
                .resizable()
                .scaledToFit()
                .frame(width: 137, height: 190)
                .onTapGesture {
                    navigationManager.navigate(to: .detailView)
                    
                }
        }
        .padding(24)
        .background()
        .cornerRadius(24)
        .frame(height: 238)
        .shadow(color: Color(uiColor: UIColor(hexCode: "DDE1E6", alpha: 0.6)), radius: 3, x: 1, y: 2)
    }
}

#Preview {
    ThisweekFoodView()
        .background(.mdGray10)
}
