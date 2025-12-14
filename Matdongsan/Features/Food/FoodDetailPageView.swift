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
                DishRankingView()
                CustomDivider()
                FoodStory()
            }
            .scrollTargetLayout()
            .blur(radius: isBlurred ? 4 : 0)
        }
        .scrollPosition($position)
        .navigationBarBackButtonHidden()
        .navigationTitle("옥수수")
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
            await viewModel.fetchFood(id: 1)
        }
    }
}

#Preview {
    if #available(iOS 18.0, *) {
        FoodDetailPageView(foodId: 1)
    } else {
        // Fallback on earlier versions
    }
}
