//
//  FoodDetailView.swift
//  Matdongsan
//
//  Created by sujeong on 4/22/25.
//

import SwiftUI

struct FoodDetailPageView: View {
    var body: some View {
        ScrollView {
            VStack (spacing: 16) {
                FoodCardView()
                FoodDetailInfoView()
                CustomDivider()
                    .padding(.vertical, 16)
                DishRankingView()
                CustomDivider()
                FoodStory()
            }
        }
    }
}

#Preview {
    FoodDetailPageView()
}
