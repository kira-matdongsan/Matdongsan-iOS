//
//  FoodRankingModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/14/25.
//

struct DishRankingModel: Codable {
    let totalVoteCount: Int?
    let voteStartDate: String?
    let voteEndDate: String?
    let contents: [DishRankItemModel]
}

struct DishRankItemModel: Codable, Identifiable {
    let id: Int
    let name: String
    let thumbnailUrl: String?
    let rank: Int?
    let voteCount: Int?
}
