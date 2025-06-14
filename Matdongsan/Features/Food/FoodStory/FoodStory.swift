//
//  FoodStory.swift
//  Matdongsan
//
//  Created by sujeong on 5/8/25.
//

import SwiftUI

struct FoodStory: View {
    @State var selectedCategory:String = "전체"
    private var stories:[String] = ["전체", "레시피", "플레이스", "제철기록"]
    var storyIconMap:[String:String] = ["레시피":"recipe-icon", "플레이스":"place-icon", "제철기록":"record-icon"]
    
    @State var selectedSortIndex:Int = 0
    @State var selectedSort:String = "최신순"
    @State var isPopoverSort:Bool = false
    
    @State var selectedFilterIndex:Int = 0
    @State var selectedFilter:String = "전체"
    @State var isPopoverFilter:Bool = false
    
    
    var body: some View {
        ZStack {
            VStack (spacing: 16) {
                VStack (alignment: .leading, spacing: 4) {
                    Text("나의 제철음식 이야기")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    HStack {
                        Text("제철음식과 관련된 이야기를 공유해주세요")
                            .foregroundStyle(.mdCoolgray60)
                            .font(.system(size: 14))
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
                        .background(.mdCoolgray10.opacity(0.5))
                        .cornerRadius(4)
                    }
                    
                    // 필터
                    Button {
                        isPopoverFilter.toggle()
                    } label: {
                        HStack (spacing: 4) {
                            Text(selectedFilter)
                                .tint(.mdCoolgray60)
                            Image("arrow-circle-down")
                        }
                        .padding(4)
                        .background(.mdCoolgray10.opacity(0.5))
                        .cornerRadius(4)
                    }
                    
                    Spacer()
                    
                    // 작성
                    NavigationLink(destination: FoodRecordWriteView()) {
                        Text("작성하기")
                        Image("message-edit")
                    }
                    .tint(.mdCoolgray60)
                    .padding(4)
                    .background(.mdCoolgray10.opacity(0.5))
                    .cornerRadius(4)
                    
                }
                .font(.system(size: 15))
                
                PlaceholderView()
                
                FoodRecordCell()
                
                FoodRecipeCell()
                
                FoodPlaceCell()
                
            }
            .padding(.horizontal, 8)
            .padding(16)
            
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
    }
}
