//
//  HomeDishRankingView.swift
//  Matdongsan
//
//  Created by sujeong on 5/8/25.
//

import SwiftUI

struct HomeDishRankingView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @StateObject private var viewModel = DishRankingViewModel()

    var foodName: String = ""
    let columns = [GridItem(.flexible())]
    @State var currentHeight:CGFloat = 360
    @State var selectedTab = 0
    @State var isPresentedImageView:Bool = false
    
    private var items: [DishRankItemModel?] {
        viewModel.contents.map { Optional($0) } + [nil]
    }
    
    var body: some View {
        VStack (spacing: 16) {
            VStack (alignment: .leading, spacing: 4) {
                Text("맛동산 Pick 제철요리")
                    .font(.system(size: 16, weight: .bold))
                HStack {
                    Text("맛동산에서 선정된 \(foodName)의 제철요리는 무엇일까요?")
                        .foregroundStyle(.mdCoolgray60)
                        .font(.system(size: 14, weight: .light))
                    Spacer()
                }
            }
            .padding(.horizontal, 8)
            
            VStack (spacing: 8) {
                HStack{
                    HStack (spacing: 4) {
                        Text(viewModel.participantText)
                        Image("wifi")
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.mdYellow20)
                    .cornerRadius(16)
                    
                    Spacer()

                    Button {
                        navigationManager.navigate(to: .detailView)
                    } label: {
                        Text("투표하기")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.mdCoolgray40)
                            .padding(.trailing, 16)
                    }
                }
                .foregroundStyle(.mdWarmGray70)
                .font(.system(size: 11))
                .padding(.horizontal, 8)
                
                if !viewModel.contents.isEmpty {
                    TabView (selection: $selectedTab) {
                        // 한 페이지에 3개씩 묶어서 보여줌
                        ForEach(0..<((items.count + 2) / 3), id: \.self) { pageIndex in
                            let start = pageIndex * 3
                            let end = min(start + 3, items.count)
                            LazyVGrid(columns: columns, spacing: 0) {
                                ForEach(start..<end, id: \.self) { index in
                                    let item = items[index]
                                    if let item = item {
                                        HStack {
                                            Button {
//                                                isPresentedImageView.toggle()
                                            } label: {
                                                DishCell(item: item)
                                            }
                                        }
                                    } else {
                                        NavigationLink(destination: NewDishVotingView(foodName: foodName)) {
                                            AddingBanner()
                                        }
                                    }
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                            }
                            .fixedSize(horizontal: false, vertical: true)
                            .background(alignment: .center) {
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(key: ViewHeightKey.self, value: [pageIndex: geometry.size.height])
                                }
                            }
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never)) // temp
                    .frame(height: currentHeight)
                    .onPreferenceChange(ViewHeightKey.self) { newHeights in
                        if let selectedHeight = newHeights[selectedTab] {
                            withAnimation(.smooth(duration: 0.1)) {
                                currentHeight = selectedHeight
                            }
                        }
                    }
                    .popover(isPresented: $isPresentedImageView) {
                        if #available(iOS 18.0, *) {
                            ZStack {
                                Color(uiColor: UIColor(hexCode: "21272A")).opacity(0.4)
                                    .ignoresSafeArea()
                                    .onTapGesture {
                                        isPresentedImageView.toggle()
                                    }
                                
                                ImageGridView(isPresented: $isPresentedImageView, selectedId: .constant(0))
                                    .presentationBackground(.ultraThinMaterial.opacity(0.5))
                                    .presentationCompactAdaptation(.fullScreenCover)
                            }
                            
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
                else {
                    NavigationLink(destination: NewDishVotingView(foodName: foodName)) {
                        AddingBanner()
                    }
                }
            }
        }
        .padding(16)
        .task {
            await viewModel.fetchRanking()
        }
    }
}

#Preview {
    HomeDishRankingView()
}
