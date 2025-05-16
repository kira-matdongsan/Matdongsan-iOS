//
//  FoodStory.swift
//  Matdongsan
//
//  Created by sujeong on 5/8/25.
//

import SwiftUI

struct FoodStory: View {
    
    private var stories:[Any] = ["story", "place", "review"]
    
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
                Button {
                    // TODO
                } label: {
                    Text("최신순")
                    Image("arrow-circle-down")
                }
                .tint(.mdCoolgray60)
                .padding(4)
                .background(.mdCoolgray10.opacity(0.5))
                .cornerRadius(4)
                
                Button {
                    // TODO
                } label: {
                    Text("전체")
                    Image("arrow-circle-down")
                }
                .tint(.mdCoolgray60)
                .padding(4)
                .background(.mdCoolgray10.opacity(0.5))
                .cornerRadius(4)
                
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
