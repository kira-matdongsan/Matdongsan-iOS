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
    @State var selectedSort:String = "최신순"
    private var sorts:[String] = ["최신순", "좋아요순"]
    
    var body: some View {
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
            .padding(.horizontal, 8)
            
            // 필터
            HStack (spacing: 8) {
                Menu {
                    ForEach(sorts, id: \.self) { item in
                        Button {
                            selectedSort = item
                        } label: {
                            HStack (spacing: 4) {
                                Text(item)
                                    .tint(.mdCoolgray60)
                                Image(selectedSort == item ? "checked_icon" : "unchecked_icon")
                            }
                        }
                    }
                } label: {
                    Text(selectedSort)
                    Image("arrow-circle-down")
                }
                .tint(.mdCoolgray60)
                .padding(4)
                .background(.mdCoolgray10.opacity(0.5))
                .cornerRadius(4)

                
//                Menu {
//                    ForEach(stories, id: \.self) { item in
//                        Button {
//                            selectedCategory = item
//                        } label: {
//                            HStack (spacing: 4) {
//                                Text(item)
//                                    .tint(.mdCoolgray60)
//                                Image(selectedCategory == item ? "checked_icon" : "unchecked_icon")
//                            }
//                        }
//                    }
//                } label: {
//                    Text(selectedCategory)
//                    Image("arrow-circle-down")
//                }
//                .tint(.mdCoolgray60)
//                .padding(4)
//                .background(.mdCoolgray10.opacity(0.5))
//                .cornerRadius(4)
//                .menuStyle(MenuButtonStyle())
                
                Spacer()
                
                Button {
                    // TODO
                } label: {
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
        .padding(16)
    }
}

#Preview {
    ScrollView {
        FoodStory()
    }
}
