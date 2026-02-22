//
//  PlaceholderView.swift
//  Matdongsan
//
//  Created by sujeong on 5/11/25.
//

import SwiftUI

struct PlaceholderView: View {
    @EnvironmentObject var navigationManager:NavigationManager
    @EnvironmentObject var authManager: AuthManager
    
    @Binding var showStorySheet: Bool
    @Binding var showLoginAlert: Bool
    
    var body: some View {
        VStack (spacing: 16) {
            Image("modal-icon")
                .frame(width: 48, height: 48)
            
            Text("첫 번째 이야기를 작성해주세요")
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.mdCoolgray90)
            
            Button {
                if authManager.isLoggedIn {
                    showStorySheet.toggle()
                } else {
                    showLoginAlert = true
                }
            } label: {
                Text("작성하기")
            }
            .tint(.mdWarmGray80)
            .font(.system(size: 14, weight: .semibold))
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .foregroundStyle(.mdGray10)
            )

        }
        .padding(.vertical, 32)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .mdCoolgray10, radius: 8, x: 0, y: 4)
    }
}

#Preview {
    PlaceholderView(showStorySheet: .constant(false), showLoginAlert: .constant(false))
}
