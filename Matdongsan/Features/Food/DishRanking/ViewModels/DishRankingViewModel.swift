//
//  DishRankingViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/14/25.
//

import Foundation
import Combine

@MainActor
final class DishRankingViewModel: ObservableObject {

    @Published var ranking: DishRankingModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let provider: FoodDataProvider

    init(provider: FoodDataProvider = FoodDataProvider()) {
        self.provider = provider
    }
    
    var participantText: String {
        "\(ranking?.totalVoteCount ?? -1)명 참여중"
    }
    
    var votingDateText: String {
        "\(ranking?.voteStartDate ?? "0")~\(ranking?.voteEndDate ?? "0")"
    }
    
    var contents: [DishRankItemModel] {
        ranking?.contents ?? []
    }

    func fetchRanking(foodId: Int64) async {
        isLoading = true
        errorMessage = nil

        do {
            ranking = try await provider.getDishRanking(foodId)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    func fetchImages() async {
        do {
            ranking = try await provider.getDishRanking(foodId ?? 170)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
}
