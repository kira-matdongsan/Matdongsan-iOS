//
//  FoodRecordViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/15/25.
//

import Foundation
import Combine

final class FoodRecordViewModel: ObservableObject {

    @Published var isPosting = false
    @Published var isSuccess = false
    @Published var errorMessage: String?

    private let provider: FoodDataProvider

    init(provider: FoodDataProvider = FoodDataProvider()) {
        self.provider = provider
    }

    func postNote(
        foodId: Int64,
        content: String,
        recordedDate: String,
        imageUrls: [String]
    ) async {
        isPosting = true
        errorMessage = nil

        let request = FoodRecordRequestModel(
            content: content,
            recordedDate: recordedDate,
            imageUrls: imageUrls
        )

        do {
            try await provider.postFoodRecord(
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
