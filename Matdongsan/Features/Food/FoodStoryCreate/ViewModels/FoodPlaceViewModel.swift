//
//  FoodPlaceViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/15/25.
//

import Foundation
import Combine

final class FoodPlaceViewModel: ObservableObject {

    @Published var isPosting: Bool = false
    @Published var isSuccess: Bool = false
    @Published var errorMessage: String?

    private let provider: FoodDataProvider

    init(provider: FoodDataProvider = FoodDataProvider()) {
        self.provider = provider
    }

    func submit(
        foodId: Int64,
        request: FoodPlaceRequestModel
    ) async {
        guard !isPosting else { return }

        isPosting = true
        errorMessage = nil

        do {
            try await provider.postFoodPlace(
                foodId: foodId,
                request: request
            )
            isSuccess = true
        } catch {
            errorMessage = error.localizedDescription
        }

        isPosting = false
    }
}
