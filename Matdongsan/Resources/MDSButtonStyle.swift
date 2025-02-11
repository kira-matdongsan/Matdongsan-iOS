//
//  MDSButtonStyle.swift
//  Matdongsan
//
//  Created by sujeong on 2/10/25.
//

import SwiftUI

struct MDSButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .cornerRadius(4)
    }
}

extension View {
    public func mdsBtn() -> some View {
        modifier(MDSButtonStyle())
    }
}
