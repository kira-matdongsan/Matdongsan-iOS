//
//  MenuButtonStyle.swift
//  Matdongsan
//
//  Created by sujeong on 5/20/25.
//

import SwiftUI

struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack (spacing: 4) {
            Image("record-icon")
            configuration.label
        }
    }
}

