//
//  ThisWeekFood.swift
//  Matdongsan
//
//  Created by sujeong on 7/28/25.
//

import SwiftUI

struct ThisweekFoodView: View {
    @EnvironmentObject private var navigationManager:NavigationManager

    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 12) {
                Text("이번주 제철음식")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.mdGray80)
                    .padding(8)
                    .background(.mdYellow10)
                    .cornerRadius(32)
                
                Text(viewModel.foodName)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.mdGray90)
                
                Text(viewModel.subTitle)
                    .font(.system(size: 13, weight: .bold))
                    .lineLimit(2)
                    .foregroundStyle(.mdGray90)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
            
            AsyncImage(url: URL(string: viewModel.thumnail ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 97, height: 105)
            .clipped()
            .cornerRadius(8)
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
    ThisweekFoodView(viewModel: HomeViewModel())
}
