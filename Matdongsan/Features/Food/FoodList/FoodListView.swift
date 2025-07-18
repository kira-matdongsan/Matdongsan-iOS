//
//  FoodListView.swift
//  Matdongsan
//
//  Created by sujeong on 6/28/25.
//

import SwiftUI

struct FoodListView: View {
    
    var month:Int = 7; // default
    var foodList:[Food] = [Food(id: 1, name: "옥수수"), Food(id: 2, name: "복숭아"), Food(id: 3, name: "옥수수"), Food(id: 4, name: "복숭아"), Food(id: 5, name: "옥수수"), Food(id: 6, name: "복숭아"), Food(id: 7, name: "옥수수"), Food(id: 8, name: "복숭아")]
    
    var body: some View {
        ScrollView {
            VStack (spacing: 0) {
                ZStack (alignment: .bottom) {
                    Image("corn_bg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth:.infinity, maxHeight: 280)
                    
                    HStack {
                        VStack (alignment: .leading) {
                            Text("2025년 7월")
                            Text("둘째주의 제철음식은?")
                        }
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(.mdCoolgray90)
                        .padding(.leading, 8)
                        Spacer()
                        Text("옥수수")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.mdCoolgray80)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background()
                            .cornerRadius(8)
                    }
                    .padding(8)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(16)
                }
                
                ScrollView {
                    VStack (spacing: 8) {
                        HStack {
                            Image("arrow-left")
                                .resizable()
                                .frame(width: 16, height: 16)
                            
                            ZStack {
                                Image("star-sk")
                                    .resizable()
                                    .frame(width: 43, height: 43)
                                Text("\(month)월")
                                    .foregroundStyle(.white)
                                    .font(.footnote)
                            }
                            
                            Image("arrow-right")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                        .padding(16)
                        
                        ForEach(foodList, id: \.id) { food in
                            HStack (spacing: 8) {
                                Image("cornfirst")
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                VStack (alignment: .leading, spacing: 6) {
                                    Text(food.name)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.mdCoolgray90)
                                    Text("제철 시기 | \(1)")
                                        .font(.footnote)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.mdCoolgray80)
                                        .padding(8)
                                        .background(Color.mdCoolgray10)
                                        .cornerRadius(8)
                                }
                                Spacer()
                                Image(systemName: "heart")
                                    .foregroundStyle(.mdCoolgray20)
                            }
                            .padding(8)
                            .background(.white)
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 24)
                }
                .background(Color.mdCoolgray10)
            }
        }
//        .disabled(true)
        .ignoresSafeArea()
    }
}

#Preview {
    FoodListView()
}
