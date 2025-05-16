//
//  PlaceholderView.swift
//  Matdongsan
//
//  Created by sujeong on 5/11/25.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        
        
        VStack (spacing: 16) {
            Image("modal-icon")
                .frame(width: 48, height: 48)
            
            Text("첫 번째 이야기를 작성해주세요")
                .foregroundStyle(.mdCoolgray90)
            
            Button {
                // TODO
            } label: {
                Text("작성하기")
            }
            .tint(.mdWarmGray70)
            .padding(8)
            .background(.mdCoolgray10)
            .cornerRadius(8)
        }
        .padding(.vertical, 32)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .mdCoolgray10, radius: 8, x: 0, y: 4)
    }
}

#Preview {
    PlaceholderView()
}
