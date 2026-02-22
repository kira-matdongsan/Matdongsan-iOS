//
//  FoodCardView.swift
//  Matdongsan
//
//  Created by sujeong on 4/23/25.
//

import SwiftUI

struct FoodCardView: View {
    @ObservedObject var viewModel: FoodViewModel

    @State var isLiked: Bool = false
    
    @State var flip: Bool = true
    @State var scale: CGFloat = 1
    
    let cardWidth = UIScreen.main.bounds.width - 32
    
    var body: some View {
        ZStack {
            if flip {
                // card front
                ZStack (alignment:.bottom) {
                    AsyncImage(url: URL(string: viewModel.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 312, height: 316)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 70)
                    
                    HStack (alignment: .bottom) {
                        VStack (alignment: .leading){
                            Text(viewModel.weekText)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 10)
                                .background(.mdWarmGray80)
                                .cornerRadius(16)
                                .foregroundStyle(Color(uiColor: viewModel.color))
                                .font(.system(size: 11))
                            
                            Text(viewModel.title)
                                .fontWeight(.semibold)
                                .padding(10)
                                .background(Color(uiColor: viewModel.color))
                                .cornerRadius(16)
                                .tint(.mdCoolgray80)
                                .font(.system(size: 18, weight: .bold))
                        }
                        Spacer()
//                        Button {
//                            // TODO - API call
//                            self.isLiked.toggle()
//                        } label: {
//                            viewModel.food?.isLiked ?? false ? Image(systemName: "heart.fill")
//                                .imageScale(.large)
//                                .foregroundStyle(.mdCyan40) : Image(systemName: "heart")
//                                .imageScale(.large)
//                                .foregroundStyle(.mdCoolgray20)
//                        }
//                        .padding(.bottom, 10)
                    }
                    .padding(16) // horizon
                }
                .background()
                .cornerRadius(24)
                .shadow(color: .mdCoolgray20, radius: 4, x: 1, y: 2)
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0), perspective: 0.2)
            } else {
                // card back
                ZStack {
                    AsyncImage(url: URL(string: viewModel.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 312, height: 316)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 70)
                    
                    Rectangle()
                        .foregroundStyle(Color(uiColor: viewModel.color))
                        .opacity(0.9)
                    VStack (alignment: .leading, spacing: 8){
                        Spacer()
                        Text(viewModel.weekText)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                            .background(.mdWarmGray80)
                            .cornerRadius(16)
                            .foregroundStyle(Color(uiColor: viewModel.color))
                            .font(.system(size: 11))
                        Text(viewModel.subTitle)
                            .bold()
                            .font(.system(size: 14, weight: .semibold))
                        Text(viewModel.description)
                            .font(.system(size: 12, weight: .regular))
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background()
                .cornerRadius(24)
                .shadow(color: .mdCoolgray20, radius: 4, x: 1, y: 2)
            }
        }
        .scaleEffect(scale)
        .rotation3DEffect(.degrees(flip ? 180 : 0), axis: (x: 0, y: 1, z: 0), perspective: 0.2)
        .frame(width: cardWidth)
        .padding([.horizontal, .top], 16)
        .animation(.easeInOut(duration: 0.4), value: flip)
        .onTapGesture {
            // Step 1: scale down
            withAnimation(.easeInOut(duration: 0.15)) {
                scale = 0.8
            }
            
            // Step 2: rotate after slight delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                
                // Step 3: scale back up
                withAnimation(.easeInOut(duration: 0.15)) {
                    flip.toggle()
                    scale = 1.0
                }
            }
        }
        .task {
            await viewModel.fetchFood(id: foodId ?? 0)
        }
    }
}

#Preview {
    FoodCardView(viewModel: FoodViewModel())
}
