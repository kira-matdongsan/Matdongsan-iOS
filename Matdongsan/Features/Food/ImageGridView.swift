//
//  ImageGridView.swift
//  Matdongsan
//
//  Created by sujeong on 5/28/25.
//

import SwiftUI

struct ImageGridView: View {
    @Binding var isPresented:Bool
    var images:[String] = ["corn", "launchImage", "corn"]

    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 8) {
                Spacer()
                Text("옥수수")
                    .padding(6)
                    .background(Color(uiColor: UIColor(hexCode: "F4F4F4")).opacity(0.1))
                    .cornerRadius(10)
                    .font(.callout)
                    .foregroundStyle(.white)

                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "multiply.circle")
                        .tint(.mdCoolgray20)
                        .imageScale(.large)
                }
            }
            .padding([.bottom, .trailing], 20)
            
            
            ScrollView(.horizontal) {
                HStack (spacing: 10) {
                    ForEach(Array(images.enumerated()), id: \.offset) { i, image in
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width-90, height: UIScreen.main.bounds.width-90)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                            .scrollTransition { content, phase in
                                content
                                    .scaleEffect(y: phase.isIdentity ? 1 : 0.8)
                                    .opacity(phase.isIdentity ? 1 : 0.8)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(.horizontal, 45, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        
            Spacer()
        }
    }
}

#Preview {
    ImageGridView(isPresented: .constant(true))
        .background(Color(uiColor: UIColor(hexCode: "21272A")).opacity(0.4))
}
