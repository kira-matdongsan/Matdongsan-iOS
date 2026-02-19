//
//  DishRankingPageView.swift
//  Matdongsan
//
//  Created by sujeong on 2/20/26.
//

import SwiftUI

struct DishRankingPageView: View {
    let items: [DishRankItemModel?]
    let pageIndex: Int
    let columns: [GridItem]
    let foodName: String
    let foodEngName: String
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var navigationManager: NavigationManager
    
    @Binding var showLoginAlert: Bool
    @Binding var isPresentedImageView: Bool
    @Binding var selectedItem: Int
    
    var body: some View {
        let start = pageIndex * 3
        let end = min(start + 3, items.count)

        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(start..<end, id: \.self) { index in
                pageItemView(index: index)
            }
        }
    }
    
    @ViewBuilder
    private func pageItemView(index: Int) -> some View {
        let item = items[index]
        
        if let item = item {
            HStack {
                Button {
                    isPresentedImageView.toggle()
                    selectedItem = index
                } label: {
                    DishCell(item: item)
                }
                
                Button {
                    if authManager.isLoggedIn {
                        navigationManager.navigate(
                            to: .dishVoting(
                                dishId: item.id,
                                dishName: item.name
                            )
                        )
                    } else {
                        showLoginAlert = true
                    }
                } label: {
                    voteButton
                }
            }
        } else {
            Button {
                if authManager.isLoggedIn {
                    navigationManager.navigate(
                        to: .newDishVoting(
                            foodName: foodName,
                            foodEngName: foodEngName
                        )
                    )
                } else {
                    showLoginAlert = true
                }
            } label: {
                AddingBanner()
            }
        }
    }
    
    private var voteButton: some View {
        Text("투표하기")
            .font(.system(size: 14, weight: .bold))
            .foregroundStyle(.mdCoolgray90)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.mdCoolgray10)
                    .frame(width: 65, height: 36)
            }
            .padding(.trailing, 16)
    }
}
