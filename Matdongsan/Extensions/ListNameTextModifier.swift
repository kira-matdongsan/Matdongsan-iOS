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
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(.mdCoolgray90)
    }
}

extension View {
    func foodListNameTextStyle() -> some View {
        self.modifier(FoodListNameTextStyle())
    }
}
