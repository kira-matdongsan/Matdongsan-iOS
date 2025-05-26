//
//  FoodRecordCell.swift
//  Matdongsan
//
//  Created by sujeong on 5/8/25.
//

import SwiftUI

struct FoodRecordCell: View {
    
    private var nickname: String = "도란도란3"
    private var createdAt: String = "2025.05.09"
    private var title: String = "2024.10.08의 기록"
    private var content: String = "길가에 트럭을 보면 그냥 지나치지 못하고 항상 옥수수를 사먹는데 이태원 길가에 있던 옥수수 사장님이 개시 손님이라고 해서 뭔가 기분이 좋았당! 집에 가서 먹으려고 했는데 못참고 길옥수수를 했다."
    @State private var isLiked: Bool = false
    private var likeCnt: Int = 0


    
    var body: some View {
        VStack {
            HStack (spacing: 8) {
                Image("user-profile")
                    .frame(width: 36, height: 36)
                VStack (alignment: .leading, spacing: 2) {
                    Text(nickname)
                        .foregroundStyle(.mdCoolgray90)
                        .font(.system(size: 15))
                    Text(createdAt)
                        .foregroundStyle(.mdCoolgray30)
                        .fontWeight(.light)
                        .font(.system(size: 13))
                }
                
                Spacer()
                
                Image("record-icon")
                    .frame(width: 24, height: 24)
            }
            
            Divider()
            
            HStack {
                LazyHGrid(rows: [GridItem()]) {
                    Image("cornfirst")
                        .resizable()
                        .frame(width: 78, height: 78)
                    
                    Image("cornfirst")
                        .resizable()
                        .frame(width: 78, height: 78)
                    
                    Image("cornfirst")
                        .resizable()
                        .frame(width: 78, height: 78)
                    
                }
                .frame(height: 78)
                Spacer()
            }
            
            VStack (alignment: .leading, spacing: 8) {
                HStack {
                    Image("note-text")
                    Text(title)
                        .font(.system(size: 14))
                }
                
                Text(content)
                    .fontWeight(.thin)
                    .foregroundStyle(.mdCoolgray90)
                    .font(.system(size: 15))

            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.mdCoolgray10.opacity(0.5))
            .cornerRadius(8)
            
            Divider()
            
            HStack (alignment: .center, spacing: 4) {
                Button {
                    // TODO
                    self.isLiked.toggle()
                } label: {
                    isLiked ? Image(systemName: "heart.fill")
                        .imageScale(.large)
                        .foregroundStyle(.mdCyan40) : Image(systemName: "heart")
                        .imageScale(.large)
                        .foregroundStyle(.mdCoolgray50)
                }
                
                Text("\(likeCnt)")
                    .font(.callout)
                    .foregroundStyle(.mdCoolgray50)
                
                Spacer()
                
                Button {
                    // TODO
                } label: {
                    Image(systemName: "ellipsis")
                        .imageScale(.large)
                        .foregroundStyle(.mdCoolgray50)
                }
            }
            .padding(.vertical, 1)

        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .mdCoolgray10, radius: 6, x: 1, y: 2)
    }
}

#Preview {
    FoodRecordCell()
}
