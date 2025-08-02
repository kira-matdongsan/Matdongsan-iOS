//
//  CustomDivider.swift
//  Matdongsan
//
//  Created by sujeong on 4/22/25.
//

import SwiftUI

struct CustomDivider: View {
    var opacity: CGFloat = 1.0
    
    var body: some View {
        Rectangle()
            .frame(maxHeight: 8)
            .foregroundStyle(.mdCoolgray10)
            .opacity(opacity)
        
    }
}
