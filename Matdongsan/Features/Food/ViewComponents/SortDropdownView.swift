//
//  FilterDropdownView.swift
//  Matdongsan
//
//  Created by sujeong on 5/27/25.
//

import SwiftUI

struct SortDropdownView: View {
    
    var sorts:[String] = ["최신순", "좋아요순"]
    @Binding var selectedSortIdx:Int
    @Binding var isPresenting:Bool
    @Binding var selectedSort:String
    
    var body: some View {
        LazyVGrid(columns: [GridItem()], spacing: 0) {
            ForEach(Array(sorts.enumerated()), id: \.offset) { i, sort in
                HStack {
                    Text(sort)
                        .font(.system(size: 15))
                        .foregroundStyle(i == selectedSortIdx ? .mdCoolgray80 : .mdCoolgray60)
                    Spacer()
                    Image(i == selectedSortIdx ? "checked_icon" : "unchecked_icon")
                }
                .frame(height: 28)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .onTapGesture {
                    selectedSortIdx = i
                    selectedSort = sorts[selectedSortIdx]
                    isPresenting = false
                }

                if i != sorts.count-1 {
                    Divider()
                        .frame(height: 5) // 안나와..
                        .gridCellUnsizedAxes(.horizontal)
                }
            }
            
        }
        .frame(width:106)
        .background()
        .cornerRadius(8)
        .clipped()
        .shadow(color: .mdCoolgray20, radius: 10, x: 0, y: 4)
        
    }
}

#Preview {
    SortDropdownView(selectedSortIdx: .constant(0), isPresenting: .constant(true), selectedSort: .constant("최신순"))
}
