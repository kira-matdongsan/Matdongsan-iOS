//
//  FoodDetailInfoView.swift
//  Matdongsan
//
//  Created by sujeong on 4/22/25.
//

import SwiftUI

@available(iOS 18.0, *)
struct FoodDetailInfoView: View {
    
    @ObservedObject var viewModel: FoodViewModel

    @State private var fold:Bool = true
    @Binding var position:ScrollPosition
    let cardWidth = UIScreen.main.bounds.width

    var body: some View {
        if let food = viewModel.food {
            VStack {
                if fold {
                    VStack {
                        HStack {
                            Text("\(food.name) 자세히 알아보기")
                            Spacer()
                            Image(systemName: "plus")
                                .foregroundStyle(.mdCoolgray30)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 4)
                        .background(.mdCoolgray10)
                        .cornerRadius(8)
                        .font(.system(size: 14))
                        .frame(width: UIScreen.main.bounds.width-64)

                        LazyHGrid(rows:[GridItem()]) {
                            ForEach(food.detailInfoItems) { item in
                                Text("\(item.title)")
                                    .fixedSize()
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background{
                                        RoundedRectangle(cornerRadius: 24)
                                            .fill(.white)
                                            .stroke(.mdCoolgray10)
                                    }
                                    .foregroundStyle(.mdCoolgray30)
                                    .font(.system(size: 13))
                            }
                        }
                        .gridCellUnsizedAxes(.horizontal)
                        .frame(width: UIScreen.main.bounds.width-64)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background()
                    .cornerRadius(16)
                    .shadow(color: .mdCoolgray20, radius: 4, x:1, y:2)
                    .padding([.horizontal, .bottom], 16)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            position.scrollTo(y: 400)
                            fold.toggle()
                        }
                    }

                } else {
                    VStack (alignment: .leading) {
                        HStack {
                            Text("\(food.name) 자세히 알아보기")
                                .foregroundStyle(.mdCoolgray90)
                            Spacer()
                            Image(systemName: "chevron.up")
                                .foregroundStyle(.mdCoolgray30)
                        }
                        .padding(.vertical, 12)
                        .font(.system(size: 14))
                        .background()
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                fold.toggle()
                            }
                        }
                        
                        ForEach(food.detailInfoItems) { item in
                            let title = item.title == "효능" ? "\(food.name)의 효능" : item.title
                            VStack (alignment: .leading, spacing: 8.0) {
                                Text("\(title)")
                                    .fixedSize()
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background{
                                        RoundedRectangle(cornerRadius: 24)
                                            .fill(.white)
                                            .stroke(.mdCoolgray30)
                                    }
                                    .foregroundStyle(.mdCoolgray90)
                                    .font(.system(size: 13))
                                Text(item.value)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundStyle(.mdCoolgray50)
                                    .font(.system(size: 14))
                                Divider()
                                    .padding(.bottom, 8)
                            }
                        }
                        
                        VStack (alignment: .leading, spacing: 8.0) {
                            Text("영양성분")
                                .fixedSize()
                                .padding(.horizontal, 6)
                                .padding(.vertical, 4)
                                .background{
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(.white)
                                        .stroke(.mdCoolgray30)
                                }
                                .foregroundStyle(.mdCoolgray90)
                                .font(.system(size: 13))
                            HStack {
                                Spacer()
                                Text("100g 당 기준")
                                    .font(.system(size: 12))
                            }
                            Divider()
                            ForEach(food.nutrients?.nutritionItems ?? []) { nutrition in
                                HStack {
                                    Text(nutrition.title)
                                    Spacer()
                                    Text(nutrition.value)
                                }
                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal, 8)
                            .font(.system(size: 13))
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 16)
                    .foregroundStyle(.mdCoolgray50)
                    .background{
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.white)
                            .stroke(.mdCoolgray20)
                    }
                    .padding([.horizontal, .bottom], 16)

                }
            }
            .frame(width: cardWidth)
        }
    }
}

#Preview {
    ScrollView {
        if #available(iOS 18.0, *) {
            FoodDetailInfoView(viewModel: FoodViewModel(), position: .constant(ScrollPosition(id: 0)))
        } else {
            // Fallback on earlier versions
        }
    }
}
