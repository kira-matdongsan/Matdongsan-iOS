//
//  JoinCompletionView.swift
//  Matdongsan
//
//  Created by sujeong on 1/9/25.
//

import SwiftUI

struct FoodSelectionJoinView: View {
    @State private var selectedFoods: [Food] = []
    @State private var foods: [Food] = [
        Food(name: "사과", month: 1),
        Food(name: "딸기", month: 5),
        Food(name: "바나나", month: 1),
        Food(name: "포도", month: 5),
        Food(name: "2", month: 1),
        Food(name: "3", month: 5)]
    let columns = [GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8)]
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.2)
            VStack{
                VStack(alignment: .leading){
                    Text("좋아하는 제철음식을 선택해주세요.")
                        .fontWeight(.medium)
                        .padding(.bottom,3)
//                        .padding(.trailing,30)
                        .font(.title3)
                    Text("선택된 제철음식을 기반으로 맞춤 제철음식\n콘텐츠와 알림을 전달드릴게요.")
                        .font(.subheadline)
                        .tint(.mdGray50)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2, reservesSpace: true)
                        .padding(.bottom,10)
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(foods, id: \.self) { food in
                                // 이걸 버튼으로 구현;
                                VStack{
                                    Image("사과")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 80)
                                    HStack{
                                        Text("\(food.month)월")
                                            .padding(5)
                                            .background(.mdCoolgray20)
                                            .fontWeight(.semibold)
                                            .tint(.mdCoolgray80)
                                            .cornerRadius(6)
                                        Text(food.name)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .padding(.vertical, 10)
                                .frame(minWidth: 150)
                                .background(.mdCoolgray10)
                                .cornerRadius(16)
                                .padding(.bottom, 5)
                            }
                        }
                    }
                    
//                    .background(.mdCoolgray80)

                }
                .padding(16)
                .background(.white)
                .cornerRadius(18)
                .frame(maxHeight:400) // temp
                .padding(.vertical, 160) // temp
                .padding(.horizontal, 20)
                
                
                HStack{
                    Button {
                        // TODO
                    } label: {
                        Text("나중에 하기")
                            .frame(maxWidth: .infinity, maxHeight: 52)
                    }
                    .foregroundColor(.white)
                    .bold()
                    .background(.mdCoolgray30)
                    .cornerRadius(12)
                    
                    Button {
                        // TODO
                    } label: {
                        Text("완료하기")
                            .frame(maxWidth: .infinity, maxHeight: 52)
                    }
                    .foregroundColor(.white)
                    .bold()
                    .background(.mdCoolgray90)
                    .cornerRadius(12)
                }
                .padding(.horizontal, 20)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    FoodSelectionJoinView()
}
