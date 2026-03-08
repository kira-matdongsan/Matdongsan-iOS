//
//  FoodStory.swift
//  Matdongsan
//
//  Created by sujeong on 5/8/25.
//

import SwiftUI

struct FoodStory: View {
    @EnvironmentObject var navigationManager:NavigationManager
    @EnvironmentObject var authManager: AuthManager

    @StateObject private var viewModel = FoodStoryViewModel(foodId: foodId ?? 0)
    @State private var showLoginAlert = false

    var foodName: String = ""
    var foodEngName: String = ""
    var stories:[String] = ["전체", "레시피", "제철기록"]
    //    var storyIconMap:[String:String] = ["레시피":"recipe-icon", "플레이스":"place-icon", "제철기록":"record-icon"]
    @State var colorMap:[String:UIColor] = [
        "레시피":UIColor.mdOrange40,
        "제철기록":UIColor.mdTeal40,
        "전체":UIColor.mdCoolgray10
    ]
    
    @State var selectedSortIndex:Int = 0
    @State var isPopoverSort:Bool = false
    
    @State var selectedFilterIndex:Int = 0
    @State var isPopoverFilter:Bool = false
    
    @State var showStorySheet:Bool = false
    
    @State private var showActionMenu = false
    @State private var actionMenuPosition: CGPoint = .zero
    @State private var selectedStoryId: Int?
    
    @State private var showDeleteAlert = false
    @State private var showReportAlert = false
    @State private var showBlockUserAlert = false
    
    @State var reportReason = ""
        
    var body: some View {
        ZStack {
            VStack (spacing: 16) {
                VStack (alignment: .leading, spacing: 4) {
                    Text("나의 제철음식 이야기")
                        .font(.system(size: 16, weight: .bold))
                    HStack {
                        Text("제철음식과 관련된 이야기를 공유해주세요")
                            .foregroundStyle(.mdCoolgray60)
                            .font(.system(size: 14, weight: .light))
                        Spacer()
                    }
                }
                
                HStack (spacing: 8) {
                    // 정렬
                    Button {
                        isPopoverSort.toggle()
                    } label: {
                        HStack (spacing: 4) {
                            Text(viewModel.selectedSort)
                                .tint(.mdCoolgray60)
                            Image("arrow-circle-down")
                        }
                        .padding(4)
                        .background(.mdCoolgray10) //.opacity(0.5) temp
                        .cornerRadius(4)
                    }
                    
                    // 필터
                    Button {
                        isPopoverFilter.toggle()
                    } label: {
                        HStack (spacing: 4) {
                            Text(viewModel.selectedFilter)
                                .tint(viewModel.selectedFilter == "전체" ? .mdCoolgray60 : .white)
                            Image(viewModel.selectedFilter == "전체" ? "arrow-circle-down" : "arrow-circle-down-w" )
                        }
                        .padding(4)
                        .background(Color(uiColor: colorMap[viewModel.selectedFilter] ?? .mdCoolgray10))
                        .cornerRadius(4)
                    }
                    
                    Spacer()
                    
                    // 작성
                    Button {
                        if authManager.isLoggedIn {
                            showStorySheet.toggle()
                        } else {
                            showLoginAlert = true
                        }
                    } label: {
                        Text("작성하기")
                        Image("message-edit")
                    }
                    .tint(.mdCoolgray60)
                    .padding(4)
                    .background(.mdCoolgray10.opacity(0.5))
                    .cornerRadius(4)
                    .sensoryFeedback(.selection, trigger: showStorySheet)
                    
                }
                .font(.system(size: 14))
                
                if viewModel.filteredStories.isEmpty {
                    PlaceholderView(showStorySheet: $showStorySheet, showLoginAlert: $showLoginAlert)
                }

                ForEach(viewModel.filteredStories.map(\.id), id: \.self) { id in
                    if let index = viewModel.stories.firstIndex(where: { $0.id == id }) {
                        let storyBinding = $viewModel.stories[index]
                        let storyValue = viewModel.stories[index]

                        switch storyValue.content {
                        case .recipe:
                            FoodRecipeCell(story: storyBinding, foodName: foodName, onDelete:{
                                Task {
                                    await viewModel.deleteStory(storyId: id)
                                }
                            }, onActionTap: { position, storyId in
                                showActionMenu = true
                                actionMenuPosition = position
                                selectedStoryId = Int(storyId)
                            })
                        case .seasonal:
                            FoodRecordCell(story: storyBinding, foodName: foodName, onDelete:{
                                Task {
                                    await viewModel.deleteStory(storyId: id)
                                }
                            }, onActionTap: { position, storyId in
                                showActionMenu = true
                                actionMenuPosition = position
                                selectedStoryId = Int(storyId)
                            })
                        }
                    }
                }
            }
            .padding(16)
            .sheet(isPresented: $showStorySheet) {
                VStack {
                    Rectangle()
                        .fill(Color.mdCoolgray30)
                        .frame(width: 40, height: 4)
                        .cornerRadius(3)
                        .padding(.bottom, 18)
                        .padding(.top, 16)
                    HStack {
                        Text("제철음식 이야기")
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                        Button {
                            showStorySheet = false
                        } label: {
                            Image("close-circle")
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 24)
                    
                    Button {
                        showStorySheet = false
                        navigationManager.navigate(to: AppRoute.recipe(foodName: foodName, foodEngName: foodEngName))
                    } label: {
                        HStack (spacing: 10) {
                            Image("recipe-icon")
                                .resizable()
                                .frame(width: 48, height: 48)
                            VStack (alignment:.leading, spacing: 4) {
                                Text("레시피")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.mdGray90)
                                Text("제철음식으로 만드는 나만의 레시피")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(.mdGray60)
                            }
                            Spacer()
                        }
                        .padding(4)
                    }
                    
                    Divider()
                    
                    Button {
                        showStorySheet = false
                        navigationManager.navigate(to: AppRoute.record(foodName: foodName, foodEngName: foodEngName))
                    } label: {
                        HStack (spacing: 10) {
                            Image("record-icon")
                                .resizable()
                                .frame(width: 48, height: 48)
                            VStack (alignment:.leading, spacing: 4) {
                                Text("제철기록")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.mdGray90)
                                Text("기록하고 싶은 나만의 제철음식 이야기")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(.mdGray60)
                            }
                            Spacer()
                        }
                        .padding(4)
                    }
                    
//                    Divider()
//                    
//                    Button {
//                        showStorySheet = false
//                        navigationManager.navigate(to: AppRoute.place)
//                    } label: {
//                        HStack (spacing: 10) {
//                            Image("place-icon")
//                                .resizable()
//                                .frame(width: 48, height: 48)
//                            VStack (alignment:.leading, spacing: 4) {
//                                Text("플레이스")
//                                    .font(.system(size: 16, weight: .bold))
//                                    .foregroundStyle(.mdGray90)
//                                Text("제철음식을 맛볼 수 있는 공간 소개")
//                                    .font(.system(size: 14, weight: .regular))
//                                    .foregroundStyle(.mdGray60)
//                            }
//                            Spacer()
//                        }
//                        .padding(4)
//                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .presentationDetents([.height(250)])
                .presentationCornerRadius(32)
            }
            .coordinateSpace(name: "scroll")
            
            // 정렬 메뉴
            if isPopoverSort {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPopoverSort = false
                    }
                    .zIndex(99)
                SortDropdownView(selectedSortIdx: $selectedSortIndex, isPresenting: $isPopoverSort, selectedSort: $viewModel.selectedSort)
                    .zIndex(100)
                    .position(x: 70, y: 120) // temp
            }
            
            // 필터 메뉴
            if isPopoverFilter {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPopoverFilter = false
                    }
                    .zIndex(99)
                FilterDropdownView(selectedIdx: $selectedFilterIndex, isPresenting: $isPopoverFilter, selectedItem: $viewModel.selectedFilter)
                    .zIndex(100)
                    .position(x: 155, y: 160) // temp
            }
            
            if showActionMenu {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showActionMenu = false
                    }
                    .zIndex(99)
                ActionDropdownView(
                    isPresenting: $showActionMenu,
                    onDelete: {
                        showDeleteAlert = true
                    },
                    onReport: {
                        showReportAlert = true
                    },
                    onBlockUser: {
                        showBlockUserAlert = true
                    }
                )
                .zIndex(101)
                .position(actionMenuPosition)
            }
        }
        .padding(.bottom, 50) // for drop down menu
        .alert("로그인이 필요합니다", isPresented: $showLoginAlert) {
            Button("취소", role: .cancel) { }
            Button("로그인 하기") {
                navigationManager.navigate(to: .login)
            }
        } message: {
            Text("투표는 로그인 후 이용하실 수 있어요.")
        }
        .alert("삭제하시겠습니까?", isPresented: $showDeleteAlert) {
            Button("삭제", role: .destructive) {
                if let id = selectedStoryId {
                    Task {
                        await viewModel.deleteStory(storyId: Int64(id))
                    }
                }
            }
            Button("취소", role: .cancel) {
                showDeleteAlert = false
            }
        } message: {
            Text("이 작업은 되돌릴 수 없습니다.")
        }
        .alert("신고하시겠습니까?", isPresented: $showReportAlert) {
            TextField("신고사유를 입력해 주세요.", text: $reportReason)
            Button("신고하기", role: .destructive) {
                if let id = selectedStoryId {
                    Task {
//                        await viewModel.reportStory(storyId: id, reason: reason)
                    }
                }
            }
            Button("취소", role: .cancel) {
                showReportAlert = false
            }
        } message: {
            Text("신고된 게시글은 담당자 확인 후 이용약관 및 운영정책에 따라 조치됩니다.")
        }
        .task {
            await viewModel.fetchStories()
        }
    }
}

#Preview {
    ScrollView {
        FoodStory()
            .environmentObject(NavigationManager())
    }
}
