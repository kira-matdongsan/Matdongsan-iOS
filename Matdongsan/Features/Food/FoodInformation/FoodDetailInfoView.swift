//
//  FoodDetailInfoView.swift
//  Matdongsan
//
//  Created by sujeong on 4/22/25.
//

import SwiftUI

@available(iOS 18.0, *)
struct FoodDetailInfoView: View {
    
    @State private var fold:Bool = true
    @State private var food:String = "옥수수"
    @Binding var position:ScrollPosition
    var detailCategories:[String] = ["제철시기", "주요산지", "효능", "구입요령", "손질요령"]
    var detailInfo:[String:String] = [
        "제철시기": "7-8월",
        "주요산지": "강원 홍천, 영원, 평창, 충북 괴산, 전남 등지",
        "효능": "비타민B1, B2, E와 함께 칼륨, 철분 등 무기질이 풍부하며 식이섬유도 많이 들어 있어 다이어트와 변비 예방에 효과가 있습니다.",
        "구입요령": "찰옥수수는 겉껍질이 푸르고 윤기가 나며, 알맹이가 꽉 차 있는 것이 좋습니다. 옥수수 중간 아랫부분을 눌렀을 때 탄력이 있는 것을 고르는 것이 좋습니다.",
        "손질요령": "찰옥수수의 껍질과 수염을 같이 잡고 아래로 세게 벗긴다."
    ]
    var nutritionCategories = [
        "에너지", "탄수화물", "식이섬유", "당", "단백질", "지방"
    ]
    var nutritions:[String:String] = [
        "에너지":"86kcal",
        "탄수화물":"19g",
        "식이섬유":"2.7g",
        "당":"3.2g",
        "단백질":"3.2g",
        "지방":"1.2g"
    ]
    // 영양성분 데이터 어떻게 받을지, 숫자로 주는건지, 단위 붙여서 문자열로 주는지
    
    var body: some View {
        VStack {
            if fold {
                VStack {
                    HStack {
                        Text("\(food) 자세히 알아보기")
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
                        ForEach(detailCategories, id: \.self) { category in
                            Text("\(category)")
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
                        Text("\(food) 자세히 알아보기")
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
                    
                    ForEach(detailCategories, id: \.self) { category in
                        let title = category == "효능" ? "\(food)의 효능" : category
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
                            Text(detailInfo[category] ?? "")
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
                        ForEach(nutritionCategories, id: \.self) { nutrition in
                            HStack {
                                Text(nutrition)
                                Spacer()
                                Text(nutritions[nutrition] ?? "")
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
    }
}

#Preview {
    ScrollView {
        if #available(iOS 18.0, *) {
            FoodDetailInfoView(position: .constant(ScrollPosition(id: 0)))
        } else {
            // Fallback on earlier versions
        }
    }
}
