//
//  MyVotedListView.swift
//  Matdongsan
//
//  Created by sujeong on 10/28/25.
//

import SwiftUI

struct MyVotedListView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VotedRecipeSectionView(title: "콘옥수수")
                VotedRecipeSectionView(title: "쭈꾸미 볶음")
            }
            .padding(.top, 16)
        }
        .background(.white)
    }
}

#Preview {
    MyVotedListView()
}

