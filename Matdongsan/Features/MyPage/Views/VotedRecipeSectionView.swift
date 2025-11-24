//
//  VotedRecipeSectionView.swift
//  Matdongsan
//
//  Created by sujeong on 10/28/25.
//

import SwiftUI

struct VotedRecipeSectionView: View {
    let title: String
    let imageCount: Int = 4 // 썸네일 개수 예시
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 섹션 헤더
            HStack {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.mdGray90)
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .frame(width: 14, height: 10)
                    .foregroundColor(.mdGray40)
            }
            
            // 썸네일 리스트
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<imageCount, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.mdGray10)
                            .frame(width: 80, height: 80)
                    }
                }
            }
            
            Divider()
                .background(Color.mdCoolgray10)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

#Preview {
    VotedRecipeSectionView(title: "옥수수")
}
