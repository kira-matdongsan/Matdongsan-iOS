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
        "\(ranking?.totalVoteCount ?? 0)명 참여중"
    }

    func fetchRanking() async {
        isLoading = true
        errorMessage = nil

        do {
            ranking = try await provider.getDishRanking(1)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
