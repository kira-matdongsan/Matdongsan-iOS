//
//  FoodRecipeViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/15/25.
//

import Foundation
import Combine
import UIKit

@MainActor
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
        selectedImages: [UIImage]
    ) async throws {
        isPosting = true
        errorMessage = nil
        
        // 1️⃣ presigned urls 요청
        let requestDto = PresignedUrlsRequestDto(
            fileType: FileType.FOOD_STORY.rawValue,
            fileNames: (0..<selectedImages.count).map { "\($0).png" }
        )

        let response = try await APIService().getImgPresignedUrls(requestDto)
        let imgUrls = response.contents

        // 2️⃣ S3 업로드
        for (i, imgUrl) in imgUrls.enumerated() {
            guard let imageData = selectedImages[i].pngData() else { continue }

            try await APIService().uploadImgtoS3(
                imgUrl.presignedUrl,
                imageData
            )

            print("uploaded:", imgUrl.accessUrl)
        }

        let request = FoodRecipeRequestModel(
            name: name,
            ingredients: ingredients,
            instructions: instructions,
            imageUrls: imgUrls.compactMap({ $0.accessUrl })
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
