//
//  ActionDropdownView.swift
//  Matdongsan
//
//  Created by sujeong on 5/27/25.
//
import SwiftUI

struct ActionDropdownView: View {

    @Binding var isPresenting: Bool
    
    var onDelete: (() -> Void)?
    var onReport: (() -> Void)?
    var onBlockUser: (() -> Void)?

    var body: some View {
        LazyVGrid(columns: [GridItem()], spacing: 0) {

            if let onDelete {
                actionButton("삭제하기") {
                    onDelete()
                }
            }

            if let onReport {
                dividerIfNeeded()
                actionButton("게시글 신고") {
                    onReport()
                }
            }

            if let onBlockUser {
                dividerIfNeeded()
                actionButton("사용자 차단") {
                    onBlockUser()
                }
            }
        }
        .frame(width: 106)
        .background(.white)
        .cornerRadius(8)
        .clipped()
        .shadow(color: .mdCoolgray20, radius: 10, x: 0, y: 4)
    }

    private func actionButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
            withAnimation(.easeIn(duration: 0.07)) {
                isPresenting = false
            }
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundStyle(.mdCoolgray60)
            }
            .frame(height: 28)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
        }
    }

    private func dividerIfNeeded() -> some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.mdCoolgray20)
    }
}

#Preview {
    ActionDropdownView(
        isPresenting: .constant(true),
        onDelete: {},
        onReport: {},
        onBlockUser: {}
    )
}
