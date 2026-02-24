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
    
}

enum StoryContent {
    case recipe(Recipe)
    case seasonal(SeasonalRecord)
}

enum StoryType: String {
    case recipe = "RECIPE"
    case seasonalNote = "SEASONAL_NOTE"
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
