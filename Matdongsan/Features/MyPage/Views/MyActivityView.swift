//
//  MyActivityView.swift
//  Matdongsan
//
//  Created by sujeong on 10/27/25.
//

import SwiftUI

struct MyActivityView: View {
    @State private var selectedTab: ActivityTab = .written

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 8) {
                Button(action: { selectedTab = .written }) {
                    Text("작성한 글")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(selectedTab == .written ? .white : .mdCoolgray40)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(selectedTab == .written ? .mdSkyBlue50 : .mdCoolgray10)
                        .cornerRadius(10)
                }

                Button(action: { selectedTab = .liked }) {
                    Text("좋아요한 글")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(selectedTab == .liked ? .white : .mdCoolgray40)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(selectedTab == .liked ? .mdSkyBlue50 : .mdCoolgray10)
                        .cornerRadius(10)
                }

                Button(action: { selectedTab = .voted }) {
                    Text("투표한 요리")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(selectedTab == .voted ? .white : .mdCoolgray40)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(selectedTab == .voted ? .mdSkyBlue50 : .mdCoolgray10)
                        .cornerRadius(10)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background{
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .stroke(.mdCoolgray10)
            }
            .padding(.horizontal, 24)

            ScrollView {
                if selectedTab == .written {
                    VStack(spacing: 16) {
                        FoodPlaceCell()
                        FoodRecipeCell()
                        FoodRecordCell()
                    }
                } else if selectedTab == .liked {
                    EmptyItemView(text: "좋아요한 글이 없어요")
                        .padding(12)
                } else {
                    MyVotedListView()
                }
            }
            .padding(.horizontal, 16)
            .scrollIndicators(.hidden)
        }
        .navigationTitle("내 활동")
        .navigationBarTitleDisplayMode(.inline)
    }
}

enum ActivityTab {
    case written, liked, voted
}


#Preview {
    MyActivityView()
}
