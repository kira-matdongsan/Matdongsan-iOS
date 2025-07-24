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
    
    var body: some View {
        ScrollView {
            VStack (spacing: 16) {
                FoodCardView()
                FoodDetailInfoView(position: $position)
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
    }
}

#Preview {
    if #available(iOS 18.0, *) {
        FoodDetailPageView()
    } else {
        // Fallback on earlier versions
    }
}
