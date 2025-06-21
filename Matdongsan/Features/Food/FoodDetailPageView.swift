//
//  FoodDetailView.swift
//  Matdongsan
//
//  Created by sujeong on 4/22/25.
//

import SwiftUI

struct FoodDetailPageView: View {
    @State var isBlurred:Bool = false // temp
    
    @EnvironmentObject private var navigationManager:NavigationManager
    
    var body: some View {
        ScrollView {
            VStack (spacing: 16) {
                FoodCardView()
                FoodDetailInfoView()
                CustomDivider()
                DishRankingView()
                CustomDivider()
                FoodStory()
            }
            .blur(radius: isBlurred ? 4 : 0)
        }
    }
}

#Preview {
    FoodDetailPageView()
}
