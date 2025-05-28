//
//  FilterDropdownView.swift
//  Matdongsan
//
//  Created by sujeong on 5/27/25.
//

import SwiftUI

struct FilterDropdownView: View {
    
    var categories:[String] = ["전체", "레시피", "플레이스","제철기록"]
    @Binding var selectedIdx:Int
    @Binding var isPresenting:Bool
    @Binding var selectedItem:String
    var storyIconMap:[String:String] = ["레시피":"recipe-line-icon", "플레이스":"place-line-icon", "제철기록":"record-line-icon"]
    
    var body: some View {
        LazyVGrid(columns: [GridItem()], spacing: 0) {
            ForEach(Array(categories.enumerated()), id: \.offset) { i, category in
                HStack {
                    if i != 0 {
                        Image(storyIconMap[category] ?? "")
                    }
                    Text(category)
                        .font(.system(size: 15))
                        .foregroundStyle(i == selectedIdx ? .mdCoolgray80 : .mdCoolgray60)
                    Spacer()
                    Image(i == selectedIdx ? "checked_icon" : "unchecked_icon")
                }
                .frame(height: 28)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .onTapGesture {
                    
                    selectedIdx = i
                    selectedItem = categories[selectedIdx]
                    isPresenting = false
                }

                if i != categories.count-1 {
                    Rectangle()
                        .frame(height:1)
                        .foregroundStyle(.mdCoolgray20)
                }
            }
            
        }
        .background()
        .frame(width:120)
        .cornerRadius(8)
        .clipped()
        .shadow(color: .mdCoolgray20, radius: 10, x: 0, y: 4)
        
    }
}

#Preview {
    FilterDropdownView(selectedIdx: .constant(0), isPresenting: .constant(true), selectedItem: .constant("전체"))
}
