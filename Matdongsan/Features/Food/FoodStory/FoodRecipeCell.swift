//
//  FoodRecipeCell.swift
//  Matdongsan
//
//  Created by sujeong on 5/8/25.
//

import SwiftUI

struct FoodRecipeCell: View {
    
    private var nickname: String = "도란도란3"
    private var createdAt: String = "2025.05.09"
    private var title:String = "찐옥수수"
    private var ingredients:[String] = ["옥수수", "소금 2T", "뉴슈가 1T"]
    private var instructions:String = "1. 옥수수 껍질을 두 세장 남겨두고 나머지는 다 손질해줍니다. 옥수수 껍질이 조금 남아있어야 맛있어요!\n2.옥수수가 잠길정도로 물을 부어주고, 소금과 뉴슈가를 2:1 비율로 넣어주세요. 뉴슈가가 없으면 설탕을 소금보다 조금 더 많이 넣어주세요.\n3. 센불로 20분정도 끓인 후 중불에서 20분 끓여서 먹으면 됩니다."
    @State private var isLiked: Bool = false
    private var likeCnt: Int = 0
    
    var images:[String] = ["corn", "launchImage", "corn"]
    @State var isClicked = false
    @State var selectedId = 0
    
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
                
                Image("recipe-icon")
                    .frame(width: 24, height: 24)
            }
            
            Divider()
            
            VStack (alignment: .leading, spacing: 10) {
                
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .padding(6)
                    .background(.mdOrange10)
                    .cornerRadius(8)
                
                VStack (alignment: .leading, spacing: 10) {
                    Text("• 재료")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.mdCoolgray90)

                    Text(ingredients.joined(separator: ", "))
                        .font(.system(size: 13, weight: .light))
                        .foregroundStyle(.mdCoolgray80)
                }
                
                VStack (alignment: .leading, spacing: 10) {
                    Text("• 조리 방법")
                        .bold()
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.mdCoolgray90)

                    Text(instructions)
                        .font(.system(size: 12, weight: .light))
                        .foregroundStyle(.mdCoolgray80)
                        .lineSpacing(1.6)
                }
                
                
                HStack {
                    LazyHGrid(rows: [GridItem()], spacing: 6) {
                        ForEach(Array(images.enumerated()), id: \.offset) { i, imageName in
                            Image(imageName)
                                .resizable()
                                .frame(width: 78, height: 78)
                                .cornerRadius(10)
                                .onTapGesture {
                                    selectedId = i
                                    isClicked.toggle()
                                }
                        }
                    }
                    .frame(height: 78)
                    Spacer()
                }
                .popover(isPresented: $isClicked) {
                    if #available(iOS 18.0, *) {
                        ZStack {
                            Color(uiColor: UIColor(hexCode: "21272A")).opacity(0.4)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    isClicked.toggle()
                                }
                            
                            ImageGridView(isPresented: $isClicked, selectedId: $selectedId)
                                .presentationBackground(Color.clear.opacity(0.01))
                                .presentationCompactAdaptation(.fullScreenCover)
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            
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
        .shadow(color: .mdCoolgray10, radius: 6, x: 1, y: 2)
    }
}

#Preview {
    FoodRecipeCell()
}
