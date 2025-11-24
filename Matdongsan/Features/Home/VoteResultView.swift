//
//  VotingResultView.swift
//  Matdongsan
//
//  Created by sujeong on 8/2/25.
//

import SwiftUI

struct VoteResultView: View {
    @EnvironmentObject private var navigationManager:NavigationManager

    @State var voteResult: VoteResult

    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            // 타이틀
            HStack {
                VStack (alignment: .leading, spacing: 4) {
                    Text("맛동산 Pick 제철요리")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.mdCoolgray90)
                    Text("여러분이 좋아하는 제철요리에 투표해주세요")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(.mdCoolgray60)
                }
                .padding(.horizontal, 8)
                
                Spacer()
                
                Button {
                    navigationManager.navigate(to: .detailView)
                } label: {
                    HStack {
                        Text("투표하기")
                            .foregroundStyle(.mdWarmGray80)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke()
                            .foregroundStyle(.mdGray10)
                    )
                }
            }
            
            // 결과 그래프
            VStack(spacing: 8) {
                ForEach(voteResult.results, id: \.id) { item in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(item.isFirst ? .mdYellow10 : Color.mdCoolgray10.opacity(0.5))
                            .strokeBorder(item.isFirst ? .mdYellow30 : .clear)
                        UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 12, bottomTrailingRadius: item.percentage == 100.0 ? 12 : 0, topTrailingRadius: item.percentage == 100.0 ? 12 : 0)
                            .fill(item.isFirst ? .mdYellow30 : .mdCoolgray20)
                            .frame(width: (UIScreen.main.bounds.width - 16 * 2) * (item.percentage / 100.0))
                        
                        // text
                        HStack (spacing: 8) {
                            Text(item.name)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.mdCoolgray100)
                            Spacer()
                            Text(String(format: "%.1f%%", item.percentage) + " (\(item.count)명)")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.mdCoolgray80)
                            Image(item.isFirst ? "verify-yl" : "verify-gr")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        .padding(.horizontal, 16)
                    }
                    .frame(height: 50)
                }
            }
        }
        .padding(16)
    }
}

#Preview {
    let dummyVoteResult = VoteResult(
        month: 8,
        results: [
            VoteItem(id: UUID().uuidString, name: "갈치", percentage: 17.4, count: 14, isFirst: false),
            VoteItem(id: UUID().uuidString, name: "옥수수", percentage: 65.3, count: 53, isFirst: true),
            VoteItem(id: UUID().uuidString, name: "자두", percentage: 12.7, count: 10, isFirst: false),
            VoteItem(id: UUID().uuidString, name: "한치", percentage: 4.6, count: 4, isFirst: false)
        ]
    )
    VoteResultView(voteResult: dummyVoteResult)
        .background()
        .border(.red)
}
