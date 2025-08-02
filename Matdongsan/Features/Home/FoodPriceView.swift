//
//  FoodPriceView.swift
//  Matdongsan
//
//  Created by sujeong on 8/2/25.
//

import SwiftUI

struct FoodPriceView: View {
    @State var foodPrice: SeasonalFoodPrice
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            // 타이틀
            VStack (alignment: .leading, spacing: 4) {
                Text("맛동산 제철시세")
                    .font(.callout)
                    .bold()
                    .foregroundStyle(.mdCoolgray90)
                Text("제철음식의 가격 공유하고 다른 동네의 시세 알아보세요")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(.mdCoolgray60)
                
                Text(foodPrice.createdAt)
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundStyle(.mdWarmGray70)
                    .padding(5)
                    .background(.mdCoolgray10.opacity(0.5))
                    .cornerRadius(16)
            }
            .padding(.horizontal, 8)
            
            // 평균 & 입력 버튼
            VStack (spacing: 8) {
                ZStack (alignment: .bottom) {
                    Image("corn02")
                    Text(foodPrice.foodName)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 15)
                        .background(.white.opacity(0.5))
                        .cornerRadius(16)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.mdWarmGray10)
                .cornerRadius(16)
                
                Text("맛동산 평균 1개당")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(.mdWarmGray70)
                HStack (spacing: 8) {
                    Text(foodPrice.foodName)
                        .font(.callout)
                        .bold()
                        .foregroundStyle(.mdGray90)
                    Text("\(foodPrice.averagePricePerUnit)원")
                        .font(.callout)
                        .bold()
                        .foregroundStyle(.mdWarmGray80)
                        .padding(2)
                        .background(.mdYellow10)
                        .cornerRadius(8)
                }
                
                // 가격 입력 button
                HStack(spacing: 8) {
                    Button {
                        
                    } label: {
                        Spacer()
                        Text("비싸게 샀어요")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.mdWarmGray50)
                        Spacer()
                    }
                    .frame(height: 42)
                    .background(.mdWarmGray10)
                    .cornerRadius(8)
                    
                    Button {
                        
                    } label: {
                        Spacer()
                        Text("더 싸게 샀어요")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.mdWarmGray10)
                        Spacer()

                    }
                    .frame(height: 42)
                    .background(.mdWarmGray60)
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 8)
            
            Divider()
            
            // 다른 동네 시세 리스트
            VStack (alignment: .leading) {
                Text("🤔 다른 동네 시세는?")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.mdCoolgray80)
                    .padding(.bottom, 8)
                
                ForEach(Array(foodPrice.purchases.enumerated()), id: \.offset) { index, item in
                    VStack {
                        HStack (spacing: 4) {
                            Image("user-profile")
                                .resizable()
                                .frame(width: 18, height: 18)
                            Text("\(item.buyerNameMasked)님은 \(item.location)에서 \(item.totalPrice)원에 \(item.quantity)개 구매했어요!")
                                .font(.footnote)
                                .lineLimit(2)
                                .foregroundStyle(.mdCoolgray70)
                            Spacer(minLength: 4)
                            Text(item.createdAt)
                                .font(.footnote)
                                .fontWeight(.regular)
                                .foregroundStyle(.mdCoolgray40)
                        }
                        
                        if index < foodPrice.purchases.count - 1 {
                            Divider()
                                .foregroundStyle(.mdCoolgray10)
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
            
        }
        .padding(16)
    }
}

#Preview {
    FoodPriceView(foodPrice: HomeViewDummyData.dummySeasonalPrice)
        .border(.red)
}
