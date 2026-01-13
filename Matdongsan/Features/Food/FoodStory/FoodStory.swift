//
//  FoodStory.swift
//  Matdongsan
//
//  Created by sujeong on 5/8/25.
//

import SwiftUI

struct FoodStory: View {
    @State var selectedCategory:String = "전체"
    var stories:[String] = ["전체", "레시피", "제철기록"]
    //    var storyIconMap:[String:String] = ["레시피":"recipe-icon", "플레이스":"place-icon", "제철기록":"record-icon"]
    @State var colorMap:[String:UIColor] = [
        "레시피":UIColor.mdOrange40,
//        "플레이스":UIColor.mdGreen40,
        "제철기록":UIColor.mdTeal40,
        "전체":UIColor.mdCoolgray10
    ]
    
    @State var selectedSortIndex:Int = 0
    @State var selectedSort:String = "최신순"
    @State var isPopoverSort:Bool = false
    
    @State var selectedFilterIndex:Int = 0
    @State var selectedFilter:String = "전체"
    @State var isPopoverFilter:Bool = false
    
    @State var showStorySheet:Bool = false
    
    @EnvironmentObject var navigationManager:NavigationManager
    
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
                            Text(selectedSort)
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
                            Text(selectedFilter)
                                .tint(selectedFilter == "전체" ? .mdCoolgray60 : .white)
                            Image(selectedFilter == "전체" ? "arrow-circle-down" : "arrow-circle-down-w" )
                        }
                        .padding(4)
                        .background(Color(uiColor: colorMap[selectedFilter] ?? .mdCoolgray10))
                        .cornerRadius(4)
                    }
                    
                    Spacer()
                    
                    // 작성
                    Button {
                        showStorySheet.toggle()
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

                PlaceholderView()
                
                FoodRecordCell()
                
                FoodRecipeCell()
                
//                FoodPlaceCell()
                
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
                        navigationManager.navigate(to: AppRoute.recipe)
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
                        navigationManager.navigate(to: AppRoute.record)
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
            
            // 정렬 메뉴
            if isPopoverSort {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPopoverSort = false
                    }
                    .zIndex(99)
                SortDropdownView(selectedSortIdx: $selectedSortIndex, isPresenting: $isPopoverSort, selectedSort: $selectedSort)
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
                FilterDropdownView(selectedIdx: $selectedFilterIndex, isPresenting: $isPopoverFilter, selectedItem: $selectedFilter)
                    .zIndex(100)
                    .position(x: 155, y: 160) // temp
            }
        }
    }
}

#Preview {
    ScrollView {
        FoodStory()
            .environmentObject(NavigationManager())
    }
}
