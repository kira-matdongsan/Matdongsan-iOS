//
//  StoryDto.swift
//  Matdongsan
//
//  Created by sujeong on 2/18/26.
//

struct PagedStoryDto: Codable {
    let content: [StoryDto]
    let currentPage: Int
    let totalPages: Int
    let totalElements: Int
    let hasNext: Bool
}

extension PagedStoryDto {
    func toDomain() -> [StoryModel] {
        content.map { $0.toDomain() }
    }
}

struct StoryDto: Codable, Identifiable {
    let id: Int64
    let nickname: String
    let profileImageUrl: String?
    let type: String
    let createdAt: String
    let images: [PostImageDto]

    let content: String
    let recordedDate: String?
    
    let name: String?
    let ingredients: String?
    let instructions: String?
    
    let category: String?
    let address: String?
    let naverUrl: String?
    let likeCount: Int?
    let isLiked: Bool?
}

struct PostImageDto: Codable {
    let imageUrl: String?
    let thumbnailUrl: String?
}

extension StoryDto {
    func toDomain() -> StoryModel {
        
        let storyType = StoryType(rawValue: type) ?? .seasonalNote
        
        let imageUrls: [String] = images.map { $0.imageUrl ?? "" }
        let thumbnailUrls: [String] = images.map { $0.thumbnailUrl ?? "" }
        
        let storyContent: StoryContent
        
        switch storyType {
        case .recipe:
            storyContent = .recipe(
                Recipe(
                    title: name ?? "",
                    ingredients: ingredients?.components(separatedBy: ", ") ?? [],
                    instructions: instructions ?? "",
                    images: imageUrls,
                    thumnails: thumbnailUrls
                )
            )
            
        case .seasonalNote:
            storyContent = .seasonal(
                SeasonalRecord(
                    title: name ?? "",
                    recordedDate: recordedDate ?? "",
                    content: content,
                    images: imageUrls,
                    thumnails: thumbnailUrls
                )
            )
        }
        
        return StoryModel(
            id: id,
            nickname: nickname,
            profileImageUrl: profileImageUrl,
            type: storyType,
            content: storyContent,
            likeCount: likeCount ?? 0,
            isLiked: isLiked ?? false,
            createdAt: createdAt
        )
    }
}
