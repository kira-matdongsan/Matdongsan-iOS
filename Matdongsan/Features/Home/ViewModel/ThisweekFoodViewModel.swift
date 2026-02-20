//
//  ThisweekFoodViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 2/14/26.
//

import Foundation
import Combine

@MainActor
final class ThisweekFoodViewModel: ObservableObject {

    @Published var model: FoodModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let provider: FoodDataProvider

    init(provider: FoodDataProvider = FoodDataProvider()) {
        self.provider = provider
    }
    
    func fetchRanking(foodId: Int64) async {
        isLoading = true
        errorMessage = nil

        do {
            model = try await provider.getFoodInfo(foodId)
            print(model)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
