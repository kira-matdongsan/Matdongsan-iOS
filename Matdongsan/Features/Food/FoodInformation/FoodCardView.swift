//
//  FoodCardView.swift
//  Matdongsan
//
//  Created by sujeong on 4/23/25.
//

import SwiftUI

struct FoodCardView: View {
    
    let food: FoodModel
    
    var foodTitle: String = "옥수수 Corn"
    var seasonWeek: String = "2025년 7월 둘째주"
    @State var isLiked: Bool = false
    
    @State var flip: Bool = true
    @State var scale: CGFloat = 1
    
    var description: String = "7월 둘째주 선정된 제철음식은 바로 ‘옥수수' 에요. 더워지기 시작하는 초여름에는 아삭아삭한 초당옥수수부터 땡볕 더위엔 쫀득쫀득한 찰옥수수까지 다양한 식감으로 여름 대표 간식으로 불리운답니다."
    
    var descTitle: String = "알맹이부터 수염까지 아낌없이 주는"
    
    var body: some View {
        ZStack {
            if flip {
                // card front
                ZStack (alignment:.bottom) {
                    Image("corn")
                        .padding(.bottom, 70)
                    
                    HStack (alignment: .bottom) {
                        VStack (alignment: .leading){
                            Text(seasonWeek)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 10)
                                .background(.mdWarmGray80)
                                .cornerRadius(16)
                                .foregroundStyle(.mdYellow30)
                                .font(.system(size: 11))
                            
                            Text("\(food.name) \(food.englishName)")
                                .fontWeight(.semibold)
                                .padding(10)
                                .background(.mdYellow30)
                                .cornerRadius(16)
                                .tint(.mdCoolgray80)
                                .font(.system(size: 18, weight: .bold))
                        }
                        Spacer()
                        Button {
                            // TODO - API call
                            self.isLiked.toggle()
                        } label: {
                            food.isLiked ? Image(systemName: "heart.fill")
                                .imageScale(.large)
                                .foregroundStyle(.mdCyan40) : Image(systemName: "heart")
                                .imageScale(.large)
                                .foregroundStyle(.mdCoolgray20)
                        }
                        .padding(.bottom, 10)
                    }
                    .padding(16) // horizon
                }
                .background()
                .cornerRadius(24)
                .shadow(color: .mdCoolgray20, radius: 4, x: 1, y: 2)
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0), perspective: 0.2)
            } else {
                // card back
                ZStack {
                    Image("corn")
                        .padding(.bottom, 70)
                    Rectangle()
                        .foregroundStyle(.mdYellow30)
                        .opacity(0.9)
                    VStack (alignment: .leading, spacing: 8){
                        Spacer()
                        Text(seasonWeek)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                            .background(.mdWarmGray80)
                            .cornerRadius(16)
                            .foregroundStyle(.mdYellow30)
                            .font(.system(size: 11))
                        Text(food.subtitle)
                            .bold()
                            .font(.system(size: 14, weight: .semibold))
                        Text(food.description)
                            .font(.system(size: 12, weight: .regular))
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .background()
                .cornerRadius(24)
                .shadow(color: .mdCoolgray20, radius: 4, x: 1, y: 2)
            }
        }
        .padding([.horizontal, .top], 16)
        .scaleEffect(scale)
        .rotation3DEffect(.degrees(flip ? 180 : 0), axis: (x: 0, y: 1, z: 0), perspective: 0.2)
        .animation(.easeInOut(duration: 0.4), value: flip)
        .onTapGesture {
            // Step 1: scale down
            withAnimation(.easeInOut(duration: 0.15)) {
                scale = 0.8
            }
            
            // Step 2: rotate after slight delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                
                // Step 3: scale back up
                withAnimation(.easeInOut(duration: 0.15)) {
                    flip.toggle()
                    scale = 1.0
                }
            }

        }
    }
}

#Preview {
    FoodCardView(food: .mock)
}
