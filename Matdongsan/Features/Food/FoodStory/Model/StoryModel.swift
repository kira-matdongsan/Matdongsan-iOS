//
//  StoryModel.swift
//  Matdongsan
//
//  Created by sujeong on 2/18/26.
//


struct StoryModel: Identifiable {
    let id: Int64
    let nickname: String
    let profileImageUrl: String?
    let type: StoryType
    let content: StoryContent
    let isOwner: Bool?
    
    let likeCount: Int
    let isLiked: Bool
    let createdAt: String
}

extension StoryModel {
    static let mockRecipe = StoryModel(
        id: 1,
        nickname: "도란도란3",
        profileImageUrl: nil,
        type: .recipe,
        content: .recipe(
            Recipe(
                title: "찐옥수수",
                ingredients: ["옥수수"],
                instructions: "끓인다.",
                images: [],
                thumnails: []
            )
        ),
        isOwner: true,
        likeCount: 3,
        isLiked: false,
        createdAt: "2025.05.09"
    )
    
    static let mockRecord = StoryModel(id: 2, nickname: "도란도란2", profileImageUrl: nil, type: .seasonalNote, content: .seasonal(SeasonalRecord(title: "titletitle", recordedDate: "2026.02.05", content: "기록기록기록합시다", images: [], thumnails: [])), isOwner: true, likeCount: 4, isLiked: true, createdAt: "2026.02.05")
    
    static let mockPlace = StoryModel(
        id: 2,
        nickname: "도란도란3",
        profileImageUrl: nil,
        type: .place,
        content: .place(
            Place(
                name: "토오베",
                category: "차 전문점",
                address: "서울특별시 종로구 관훈동 118-36 3층",
                review: "여름시즌에만 한정 판매하는 옥수수 빙수를 꼭 먹어보세요. 정말 맛있습니다!!! 그치만 주말엔 웨이팅이..",
                images: [
                    "https://picsum.photos/300/300",
                    "https://picsum.photos/301/300",
                    "https://picsum.photos/302/300"
                ],
                thumbnailUrl: nil
            )
        ),
        isOwner: true,
        likeCount: 5,
        isLiked: false,
        createdAt: "2025.05.09"
    )
    
}

enum StoryContent {
    case recipe(Recipe)
    case seasonal(SeasonalRecord)
    case place(Place)
}

enum StoryType: String {
    case recipe = "RECIPE"
    case seasonalNote = "SEASONAL_NOTE"
    case place = "PLACE"
}

struct Recipe {
    let title: String
    let ingredients: [String]
    let instructions: String
    let images: [String]
    let thumnails: [String]
}

struct SeasonalRecord {
    let title: String
    let recordedDate: String
    let content: String
    let images: [String]
    let thumnails: [String]
}

struct Place {
    let name: String          // 토오베
    let category: String      // 차 전문점
    let address: String
    let review: String
    
    let images: [String]      // 전체 이미지 (팝업용)
    let thumbnailUrl: String?  // 썸네일 (1개)
}
