//
//  FoodPlaceCell.swift
//  Matdongsan
//
//  Created by sujeong on 5/8/25.
//

import SwiftUI

struct FoodPlaceCell: View {
    private var userId:String = "" // current user 어떻게 할까
    private var nickname: String = "도란도란3" // author
    private var createdAt: String = "2025.05.09"
    
    private var place_name:String = "토오베"
    private var category:String = "차 전문점"
    private var address:String = "서울특별시 종로구 관훈동 118-36 3층"
    private var review:String = "여름시즌에만 한정 판매하는 옥수수 빙수를 꼭 먹어보세요. 정말 맛있습니다!!! 그치만 주말엔 웨이팅이.."
    
    @State private var isLiked: Bool = false
    private var likeCnt: Int = 0
    
    var images:[String] = ["corn", "launchImage", "corn"]
    @State var isClicked = false
    
    var body: some View {
        VStack {
            HStack (spacing: 8) {
                Image("user-profile")
                    .frame(width: 36, height: 36)
                VStack (alignment: .leading, spacing: 2) {
                    Text(nickname)
                        .foregroundStyle(.mdCoolgray90)
                        .font(.system(size: 14))
                    Text(createdAt)
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
                            Text(place_name)
                                .font(.system(size: 16, weight: .bold))
                                .padding(6)
                                .background(.mdGreen10)
                                .cornerRadius(8)
                            
                            Text(category)
                                .foregroundStyle(.mdCoolgray90)
                                .font(.system(size: 12))
                        }
                        
                        Text(address)
                            .font(.system(size: 11, weight: .light))
                            .foregroundStyle(.mdCoolgray60)
                        
                        Spacer()
                        
                    }
                    
                    Spacer()
                    
                    Image("cornfirst")
                        .resizable()
                        .frame(width: 78, height: 78)
                        .onTapGesture {
                            isClicked.toggle()
                        }
                        .popover(isPresented: $isClicked) {
                            if #available(iOS 18.0, *) {
                                ZStack {
                                    Color(uiColor: UIColor(hexCode: "21272A")).opacity(0.4)
                                        .ignoresSafeArea()
                                        .onTapGesture {
                                            isClicked.toggle()
                                        }
                                    
                                    ImageGridView(isPresented: $isClicked, selectedId: .constant(0))
                                        .presentationBackground(Color.clear.opacity(0.01))
                                        .presentationCompactAdaptation(.fullScreenCover)
                                }
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                }
                .frame(height: 78) // temp
            }
            
            VStack (alignment: .leading, spacing: 8) {
                Text("식당 한줄평")
                    .font(.system(size: 11, weight: .semibold))

                Text(review)
                    .font(.system(size: 13, weight: .light))
                    .fontWeight(.thin)
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
                Button {
                    // TODO
                    self.isLiked.toggle()
                } label: {
                    isLiked ? Image(systemName: "heart.fill")
                        .imageScale(.large)
                        .foregroundStyle(.mdCyan40) : Image(systemName: "heart")
                        .imageScale(.large)
                        .foregroundStyle(.mdCoolgray40)
                }
                
                Text("\(likeCnt)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.mdCoolgray40)
                
                Spacer()
                
                Button {
                    // TODO
                } label: {
                    Image("vertical-ellipsis")
                }
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
    FoodPlaceCell()
}
