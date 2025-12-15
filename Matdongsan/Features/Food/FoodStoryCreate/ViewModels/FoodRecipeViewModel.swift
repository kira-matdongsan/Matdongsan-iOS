//
//  FoodRecipeViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/15/25.
//

import Foundation
import Combine

final class FoodRecipeViewModel: ObservableObject {

    @Published var isPosting = false
    @Published var isSuccess = false
    @Published var errorMessage: String?

    private let provider: FoodDataProvider

    init(provider: FoodDataProvider = FoodDataProvider()) {
        self.provider = provider
    }

    func postRecipe(
        foodId: Int64,
        name: String,
        ingredients: String,
        instructions: String,
        imageUrls: [String]
    ) async {
        isPosting = true
        errorMessage = nil

        let request = FoodRecipeRequestModel(
            name: name,
            ingredients: ingredients,
            instructions: instructions,
            imageUrls: imageUrls
        )

        do {
            try await provider.postFoodRecipe(
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
