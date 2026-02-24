//
//  ImageGridView.swift
//  Matdongsan
//
//  Created by sujeong on 5/28/25.
//

import SwiftUI

@available(iOS 18.0, *)
struct ImageGridView: View {
    // 스토리인지, 요리인지 구별해서 신고하기 띄워야함 -> Enum으로 처리할까봐
    @Binding var isPresented:Bool
    @Binding var selectedId:Int
    @State var position:ScrollPosition = .init(id: 0)
    var imageUrls:[String] = []
    var foodName: String = ""

    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Spacer()
                
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
                    ForEach(Array(imageUrls.enumerated()), id: \.offset) { i, imageUrl in
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width-90, height: UIScreen.main.bounds.width-90)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(y: phase.isIdentity ? 1 : 0.8)
                                .opacity(phase.isIdentity ? 1 : 0.8)
                        }
                        .id(i)
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(.horizontal, 45, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .scrollPosition($position)
        }
        .onAppear {
            position.scrollTo(id: selectedId)
        }
    }
}

#Preview {
    if #available(iOS 18.0, *) {
        ZStack {
            Color(uiColor: UIColor(hexCode: "21272A")).opacity(0.4)
            ImageGridView(isPresented: .constant(true), selectedId: .constant(0))
        }
        .ignoresSafeArea()
    } else {
        // Fallback on earlier versions
    }
}
