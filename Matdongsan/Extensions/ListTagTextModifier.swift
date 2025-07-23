//
//  ListTagTextModifier.swift
//  Matdongsan
//
//  Created by sujeong on 7/15/25.
//

import SwiftUI

struct ListTagTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundStyle(.mdCoolgray80)
            .padding(8)
            .background(Color.mdCoolgray10)
            .cornerRadius(8)
    }
}

extension View {
    func listTagTextStyle() -> some View {
        self.modifier(ListTagTextStyle())
    }
}
