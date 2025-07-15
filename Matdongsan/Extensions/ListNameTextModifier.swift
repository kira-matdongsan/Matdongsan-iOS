//
//  ListNameTextModifier.swift
//  Matdongsan
//
//  Created by sujeong on 7/15/25.
//

import SwiftUI

struct FoodListNameTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.mdCoolgray90)
    }
}

extension View {
    func foodListNameTextStyle() -> some View {
        self.modifier(FoodListNameTextStyle())
    }
}
