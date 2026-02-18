//
//  FoodDetailView.swift
//  Matdongsan
//
//  Created by sujeong on 4/22/25.
//

import SwiftUI

@available(iOS 18.0, *)
struct FoodDetailPageView: View {
    @State var isBlurred:Bool = false // temp
    
    @EnvironmentObject private var navigationManager:NavigationManager
    @State var position: ScrollPosition
        = .init(y: 0)
    
    let foodId: Int64
    @StateObject private var viewModel = FoodViewModel()
    
    var body: some View {
        ScrollView {
            VStack (spacing: 16) {
                FoodCardView(viewModel: viewModel)
                FoodDetailInfoView(viewModel: viewModel, position: $position)
                    .id(1)
                CustomDivider()
                DishRankingView(foodName: viewModel.foodName, foodEngName: viewModel.foodEngName)
                CustomDivider()
                FoodStory(foodName: viewModel.foodName, foodEngName: viewModel.foodEngName)
            }
            .scrollTargetLayout()
            .blur(radius: isBlurred ? 4 : 0)
        }
        .scrollPosition($position)
        .navigationBarBackButtonHidden()
        .navigationTitle(viewModel.foodName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    navigationManager.pop()
                } label: {
                    Image("back-arrow")
                        .frame(width: 24, height: 24)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .task {
            await viewModel.fetchFood(id: 170)
        }
    }
}

#Preview {
    if #available(iOS 18.0, *) {
        FoodDetailPageView(foodId: 170)
    } else {
        // Fallback on earlier versions
    }
}
