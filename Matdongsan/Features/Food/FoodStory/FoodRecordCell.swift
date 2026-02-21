//
//  FoodRecordCell.swift
//  Matdongsan
//
//  Created by sujeong on 5/8/25.
//

import SwiftUI

struct FoodRecordCell: View {
    @Binding var story: StoryModel
    var foodName: String = ""
    var record: SeasonalRecord {
        guard case let .seasonal(record) = story.content else {
            return SeasonalRecord(
                title: "",
                recordedDate: "",
                content: "",
                images: [],
                thumnails: []
            )
        }
        return record
    }
    @State var isClicked = false
    @State var selectedId = 0
    @State private var showDeleteAlert = false
    var onDelete: () -> Void

    let cardWidth = UIScreen.main.bounds.width - 32

    var body: some View {
        VStack (spacing: 0) {
            HStack (spacing: 8) {
                AsyncImage(url: URL(string: story.profileImageUrl ?? "")) { image in
                    image.resizable()
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
                
                Image("record-icon")
                    .frame(width: 24, height: 24)
            }
            .padding(.bottom, 10)
            
            Divider()
            .padding(.bottom, 10)
            
            HStack(spacing: 6) {
                let thumbnails = record.thumnails
                let displayImages = thumbnails.prefix(4)
                let extraCount = thumbnails.count - 4

                ForEach(Array(displayImages.enumerated()), id: \.offset) { i, imageUrl in
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.gray.opacity(0.2)
                        }
                        .frame(width: 78, height: 78)
                        .clipped()
                        .cornerRadius(10)
                        .onTapGesture {
                            selectedId = i
                            isClicked.toggle()
                        }

                        // 마지막 + 추가 이미지 있을 때
                        if i == 3 && extraCount > 0 {
                            ZStack {
                                Color(uiColor: UIColor(hexCode: "#21272A")).opacity(0.5)
                                    .cornerRadius(32)

                                Text("+\(extraCount)")
                                    .font(.system(size: 10, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 24, height: 24)
                            .padding(.top, 4)
                            .padding(.trailing, 4)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, record.thumnails.isEmpty ? 0 : 10)
            .popover(isPresented: $isClicked) {
                if #available(iOS 18.0, *) {
                    ZStack {
                        Color(uiColor: UIColor(hexCode: "21272A")).opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                isClicked.toggle()
                            }
                        
                        ImageGridView(isPresented: $isClicked, selectedId: $selectedId, imageUrls: record.images, foodName: foodName)
                            .presentationBackground(Color.clear.opacity(0.01))
                            .presentationCompactAdaptation(.fullScreenCover)
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
            
            VStack (alignment: .leading, spacing: 8) {
                HStack {
                    Image("note-text")
                    Text(record.title)
                        .font(.system(size: 12, weight: .semibold))
                }
                
                Text(record.content)
                    .foregroundStyle(.mdCoolgray90)
                    .font(.system(size: 13, weight: .light))
                    .lineSpacing(1.8)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.mdCoolgray10.opacity(0.5))
            .cornerRadius(8)
            .padding(.bottom, 10)
            
            Divider()
                .padding(.bottom, 10)

            HStack (alignment: .center, spacing: 4) {
//                Button {
//                    // TODO
//                    self.isLiked.toggle()
//                } label: {
//                    isLiked ? Image(systemName: "heart.fill")
//                        .imageScale(.large)
//                        .foregroundStyle(.mdCyan40) : Image(systemName: "heart")
//                        .imageScale(.large)
//                        .foregroundStyle(.mdCoolgray40)
//                }
                
//                Text("\(likeCnt)")
//                    .font(.system(size: 11, weight: .bold))
//                    .foregroundStyle(.mdCoolgray40)
                
                Spacer()
                
                Button {
                    showDeleteAlert = true
                } label: {
                    Image("vertical-ellipsis")
                        .foregroundStyle(.mdCoolgray50)
                }
            }
            .padding(.vertical, 1)

        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .mdCoolgray10, radius: 6, x: 1, y: 2)
        .alert("삭제하시겠습니까?", isPresented: $showDeleteAlert) {
            Button("삭제", role: .destructive) {
                onDelete()
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("이 작업은 되돌릴 수 없습니다.")
        }
    }
}

#Preview {
    FoodRecordCell(story: .constant(.mockRecord), onDelete: {})
}
