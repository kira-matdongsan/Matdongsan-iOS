//
//  DishRankingView.swift
//  Matdongsan
//
//  Created by sujeong on 5/8/25.
//

import SwiftUI

struct DishRankingView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var navigationManager: NavigationManager

    @State private var showLoginAlert = false
    
    @StateObject private var viewModel = DishRankingViewModel()
    var foodName: String = "딸기"
    var foodEngName: String = "strawberry"
    let columns = [GridItem(.flexible())]
    @State var currentHeight:CGFloat = 360
    @State var selectedTab = 0
    @State var isPresentedImageView:Bool = false
    @State var selectedItem: Int = 0
    
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
                        Text("투표기간 | \(viewModel.votingDateText)")
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.mdCoolgray10.opacity(0.5))
                    .cornerRadius(16)
                    Spacer()
                    HStack (spacing: 4) {
                        Text(viewModel.participantText)
                        Image("wifi")
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.mdYellow20)
                    .cornerRadius(16)
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
                                                isPresentedImageView.toggle()
                                                selectedItem = index
                                            } label: {
                                                DishCell(item: item)
                                            }
                                            
                                            Button {
                                                if authManager.isLoggedIn {
                                                    navigationManager.navigate(to: .dishVoting(dishId: item.id, dishName: item.name))
                                                } else {
                                                    showLoginAlert = true
                                                }
                                            } label: {
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
                                    } else {
                                        Button {
                                            if authManager.isLoggedIn {
                                                navigationManager.navigate(to: .newDishVoting(foodName: foodName, foodEngName: foodEngName))
                                            } else {
                                                showLoginAlert = true
                                            }
                                        } label: {
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
                                
                                if let imgUrl = viewModel.contents[selectedItem].thumbnailUrl {
                                    ImageGridView(isPresented: $isPresentedImageView, selectedId: .constant(0), imageUrls: [imgUrl], foodName: foodName)
                                        .presentationBackground(.ultraThinMaterial.opacity(0.5))
                                        .presentationCompactAdaptation(.fullScreenCover)
                                }
                            }
                            
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
                else {
                    Button {
                        if authManager.isLoggedIn {
                            navigationManager.navigate(to: .newDishVoting(foodName: foodName, foodEngName: foodEngName))
                        } else {
                            showLoginAlert = true
                        }
                    } label: {
                        AddingBanner()
                    }
                }
            }
        }
        .padding(16)
        .alert("로그인이 필요합니다", isPresented: $showLoginAlert) {
            Button("취소", role: .cancel) { }
            Button("로그인 하기") {
                navigationManager.navigate(to: .login)
            }
        } message: {
            Text("투표는 로그인 후 이용하실 수 있어요.")
        }
        .task {
            await viewModel.fetchRanking(foodId: foodId ?? 170)
        }
    }
}

#Preview {
    DishRankingView(foodName: "딸기")
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    
    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue()) { $1 }
    }
}

struct AddingBanner: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 8) {
                Text("좋아하는 제철요리가 여기 없나요?")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.mdCoolgray90)
                
                Text("제철요리 등록하기")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.mdCoolgray90)

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
        .foregroundStyle(.mdCoolgray90)
    }
}

struct DishCell: View {
    var item: DishRankItemModel
    
    var body: some View {
        HStack (spacing: 8) {
            VStack {
                if item.rank == 1 {
                    Image("Trophy")
                        .resizable()
                        .scaledToFit()
                }
                Text("\(item.rank ?? 0)")
            }
            .frame(width: 26)
            .font(.system(size: 14, weight: .bold))
            .foregroundStyle(.mdGray60)
            
            AsyncImage(url: URL(string: item.thumbnailUrl ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 72, height: 72)
            .clipped()
            .cornerRadius(8)
            
            VStack (alignment:.leading, spacing: 8) {
                Text("\(item.voteCount ?? 0)명이 선택했어요.")
                    .padding(4)
                    .font(.system(size: 11, weight: .light))
                    .fontWeight(.thin)
                    .background(.mdCoolgray10)
                    .cornerRadius(8)
                    .foregroundStyle(.mdWarmGray70)
                Text(item.name)
                    .font(.system(size: 14, weight: .bold))
            }
            
            Spacer()
            
            
        }
        .foregroundStyle(.mdCoolgray90)
        
    }
}
