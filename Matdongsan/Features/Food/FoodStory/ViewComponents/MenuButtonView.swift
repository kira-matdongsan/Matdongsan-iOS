//
//  MenuButtonView.swift
//  Matdongsan
//
//  Created by sujeong on 5/29/25.
//

import SwiftUI

struct MenuButtonView: View {
    @Binding var selectedSortIdx:Int
    @Binding var selectedSort:String
    @Binding var isPresenting:Bool
    var sort:String
    var index:Int
    @State var isSelected:Bool = false
    
    var body: some View {
        Button {
            //
            selectedSortIdx = index
            selectedSort = sort
            isSelected = true
            withAnimation(.easeIn(duration: 0.07), {
                isPresenting = false
            })
        } label: {
            ZStack {
                if isSelected {
                    Rectangle()
                        .fill(.mdCoolgray10)
                }
                HStack {
                    if selectedSortIdx == index {
                        Text(sort)
                            .font(.system(size: 14))
                            .foregroundStyle(.mdCoolgray80)
                        Spacer()
                        Image("checked_icon")
                    } else {
                        Text(sort)
                            .font(.system(size: 14))
                            .foregroundStyle(.mdCoolgray60)
                        Spacer()
                        Image("unchecked_icon")
                    }
                }
                .frame(height: 28)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
            }
            
        }
    }
}

#Preview {
    MenuButtonView(selectedSortIdx: .constant(0), selectedSort: .constant("최신순"), isPresenting: .constant(true), sort: "최신순", index: 0)
}
