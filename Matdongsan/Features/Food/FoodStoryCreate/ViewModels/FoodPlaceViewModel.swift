//
//  FoodPlaceViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/15/25.
//

import Foundation
import Combine
import UIKit

@MainActor
final class FoodPlaceViewModel: ObservableObject {

    @Published var isPosting: Bool = false
    @Published var isSuccess: Bool = false
    @Published var errorMessage: String?

    private let provider: FoodDataProvider

    init(provider: FoodDataProvider = FoodDataProvider()) {
        self.provider = provider
    }
    
    func postPlace(
        foodId: Int64,
        name: String,
        content: String,
        selectedImages: [UIImage]
    ) async throws {
        guard !isPosting else { return }
        
        isPosting = true
        defer { isPosting = false }
        errorMessage = nil
        
        // 1️⃣ presigned urls 요청
        let requestDto = PresignedUrlsRequestDto(
            fileType: FileType.FOOD_STORY.rawValue,
            fileNames: (0..<selectedImages.count).map { "\($0).png" }
        )

        let response = try await APIService().getImgPresignedUrls(requestDto)
        let imgUrls = response.contents

        // 2️⃣ S3 업로드
        try await withThrowingTaskGroup(of: Void.self) { group in
            for (i, imgUrl) in imgUrls.enumerated() {
                guard let imageData = selectedImages[i].jpegData(compressionQuality: 0.5) else { continue }

                group.addTask {
                    try await APIService().uploadImgtoS3(
                        imgUrl.presignedUrl,
                        imageData
                    )
                }
            }

            try await group.waitForAll()
        }
        
        // 3. post
        let request = FoodPlaceRequestModel(
            name: name,
            content: content,
            category: "category",
            address: "address",
            imageUrls: imgUrls.compactMap({ $0.accessUrl })
        )
        
        do {
            try await provider.postFoodPlace(
                foodId: foodId,
                request: request
            )
            isSuccess = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }

}
