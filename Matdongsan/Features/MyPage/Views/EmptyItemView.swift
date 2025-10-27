//
//  EmptyItemView.swift
//  Matdongsan
//
//  Created by sujeong on 10/28/25.
//

import SwiftUI

struct EmptyItemView: View {
    var text: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image("empty-dongsan")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
            
            Text(text)
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.mdCoolgray60)
        }
        .padding(32)
        .frame(maxWidth: .infinity, minHeight: 170)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(
                    color: Color.black.opacity(0.08),
                    radius: 6, x: 0, y: 2
                )
        )
    }
}

#Preview {
    EmptyItemView(text: "투표한 요리가 없어요")
}
