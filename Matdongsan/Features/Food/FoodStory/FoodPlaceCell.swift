//
//  FoodPlaceCell.swift
//  Matdongsan
//
//  Created by sujeong on 5/8/25.
//

import SwiftUI

struct FoodPlaceCell: View {
    
    @Binding var story: StoryModel
    var foodName: String = ""
    var place: Place {
        if case let .place(place) = story.content {
            return place
        }
        fatalError("잘못된 타입")
    }
//    @State private var isLiked: Bool = false
    @State private var isClicked = false
    
    @State private var isPopoverAction = false
    @State private var selectedActionIdx = 0
    
    var onDelete: () -> Void
    let onPlaceTap: (String) -> Void
    var onActionTap: (CGPoint, Int64, Bool) -> Void
    
    var body: some View {
        VStack {
            HStack (spacing: 8) {
                AsyncImage(url: URL(string: story.profileImageUrl ?? "")) { image in
                    image
                        .resizable()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 36, height: 36)
                
                VStack (alignment: .leading, spacing: 2) {
                    Text(story.nickname)
                        .foregroundStyle(.mdCoolgray90)
                        .font(.system(size: 14))
                    Text(story.createdAt)
                        .foregroundStyle(.mdCoolgray30)
                        .fontWeight(.light)
                        .font(.system(size: 11))
                }
                
                Spacer()
                
                Image("place-icon")
                    .frame(width: 24, height: 24)
            }
            
            Divider()
                        
            VStack (alignment: .leading, spacing: 10) {
                
                HStack {
                    VStack (alignment: .leading, spacing: 8) {
                        
                        HStack (spacing: 8) {
                            Text(place.name)
                                .font(.system(size: 16, weight: .bold))
                                .padding(6)
                                .background(.mdGreen10)
                                .cornerRadius(8)
                                .onTapGesture {
                                    onPlaceTap(place.name)
                                }
                            
                            Text(place.category)
                                .foregroundStyle(.mdCoolgray90)
                                .font(.system(size: 12))
                        }
                        
                        Text(place.address)
                            .font(.system(size: 11, weight: .light))
                            .foregroundStyle(.mdCoolgray60)
                        
                        Spacer()
                    }
                    
                    Spacer()

                    if let imageUrl = place.thumbnailUrl {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.gray.opacity(0)
                        }
                        .frame(width: 78, height: 78)
                        .cornerRadius(10)
                        .onTapGesture {
                            isClicked.toggle()
                        }
                    }
                }
                .frame(height: 78)
            }
            .popover(isPresented: $isClicked) {
                if #available(iOS 18.0, *) {
                    ZStack {
                        Color(uiColor: UIColor(hexCode: "21272A")).opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                isClicked.toggle()
                            }
                        
                        ImageGridView(isPresented: $isClicked, selectedId: .constant(0), imageUrls: place.images, foodName: foodName)
                            .presentationBackground(Color.clear.opacity(0.01))
                            .presentationCompactAdaptation(.fullScreenCover)
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
            
            VStack (alignment: .leading, spacing: 8) {
                Text("식당 한줄평")
                    .font(.system(size: 11, weight: .semibold))

                Text(place.review)
                    .font(.system(size: 13, weight: .light))
                    .foregroundStyle(.mdCoolgray90)
                    .lineSpacing(1.8)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.mdCoolgray10.opacity(0.5))
            .cornerRadius(8)
            
            Divider()
            
            HStack (alignment: .center, spacing: 4) {
                // like feature is holded
//                Button {
//                    isLiked.toggle()
//                } label: {
//                    Image(systemName: isLiked ? "heart.fill" : "heart")
//                        .foregroundStyle(isLiked ? .mdCyan40 : .mdCoolgray40)
//                }
//                
//                Text("\(place.likeCount)")
//                    .font(.system(size: 11, weight: .bold))
//                    .foregroundStyle(.mdCoolgray40)
                Spacer()
                GeometryReader { geo in
                    Button {
                        let frame = geo.frame(in: .named("scroll"))
                        let position = CGPoint(x: frame.midX - 67, y: frame.maxY + 35)
                        onActionTap(position, story.id, story.isOwner ?? false)
                    } label: {
                        Image("vertical-ellipsis")
                    }
                }
                .frame(width: 24, height: 24)
            }
            .padding(.vertical, 1)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .mdCoolgray10, radius: 8, x: 1, y: 2)
    }
}

#Preview {
    FoodPlaceCell(
        story: .constant(.mockPlace), onDelete: {}, onPlaceTap: {_ in }, onActionTap: {_,_,_  in }
    )
}
