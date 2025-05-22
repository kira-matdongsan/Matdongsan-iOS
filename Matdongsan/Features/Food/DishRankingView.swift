//
//  DishRankingView.swift
//  Matdongsan
//
//  Created by sujeong on 5/8/25.
//

import SwiftUI

struct DishRankingView: View {
    
    let items:[Int] = Array(1..<4)
    let columns = [GridItem(.flexible())]
    @State var gridSize:CGSize = .zero
    
    var body: some View {
        VStack (spacing: 16) {
            VStack (alignment: .leading, spacing: 4) {
                Text("맛동산 Pick 제철요리")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                HStack {
                    Text("맛동산에서 선정된 옥수수의 제철요리는 무엇일까요?")
                        .foregroundStyle(.mdCoolgray60)
                        .font(.system(size: 14))
                    Spacer()
                }
            }
            .padding(.horizontal, 8)
            
            VStack (spacing: 8) {
                HStack{
                    HStack (spacing: 4) {
                        Text("투표기간 | 25.07.07~25.07.13")
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.mdCoolgray10.opacity(0.5))
                    .cornerRadius(16)
                    Spacer()
                    HStack (spacing: 4) {
                        Text("\(1)명 참여중")
                        Image("wifi")
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.mdYellow20)
                    .cornerRadius(16)
                }
                .foregroundStyle(.mdWarmGray70)
                .font(.system(size: 13))
                .padding(.horizontal, 8)
                
                TabView {
                    // 한 페이지에 3개씩 묶어서 보여줌
                    ForEach(0..<(items.count % 3 == 0 ? items.count/3 : items.count/3+1), id: \.self) { pageIndex in
                        let start = pageIndex * 3
                        let end = min(start + 3, items.count)
                        let pageItems = items[start..<end]
                        
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(pageItems, id: \.self) { item in
                                if item == items.last {
                                    AddingBanner()
                                } else {
                                    DishCell(item: item)
                                }
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .background(
                            GeometryReader { innerGeometry in
                                Color.clear
                                    .onAppear {
                                        gridSize = innerGeometry.size
                                    }
                                    .onChange(of: innerGeometry.size) {
                                        gridSize = innerGeometry.size
                                    }
                            }
                        )
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never)) // temp
                .frame(height: gridSize.height)
            }
        }
        .padding(16)
    }
}

#Preview {
    DishRankingView(gridSize: CGSizeMake(.infinity, .infinity))
}

struct AddingBanner: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 8) {
                Text("좋아하는 제철요리가 여기 없나요?")
                    .font(.system(size: 13))
                
                Text("제철요리 등록하기")
                    .font(.system(size: 16))
                    .bold()
            }
            Spacer()
            Image("add_food_img")
                .frame(height: 60)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.mdYellow)
        .cornerRadius(12)
        .padding(.vertical, 8)
    }
}

struct DishCell: View {
    var item: Int
    
    var body: some View {
        HStack (spacing: 8) {
            VStack {
                if Int(item) == 1 {
                    Image("Trophy")
                        .resizable()
                        .scaledToFit()
                }
                Text("\(item)")
            }
            .frame(width: 26)
            .font(.system(size: 15))
            
            Image("cornfirst")
                .resizable()
                .frame(width: 72, height: 72)
                .cornerRadius(8)
            
            VStack (alignment:.leading, spacing: 8) {
                Text("\(6)명이 선택했어요.")
                    .padding(4)
                    .font(.system(size: 13))
                    .fontWeight(.thin)
                    .background(.mdCoolgray10)
                    .cornerRadius(8)
                    .foregroundStyle(.mdWarmGray70)
                Text("찐옥수수")
                    .font(.system(size: 15))
                    .bold()
            }
            Spacer()
        }
    }
}
