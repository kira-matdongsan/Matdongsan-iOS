//
//  VotingViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 2/18/26.
//

import Combine
import UIKit

@MainActor
class VotingViewModel: ObservableObject {

    @Published var isUploading = false
    @Published var errorMessage: String?
    
    var foodDataProvider: FoodDataProvider = FoodDataProvider()

    func uploadImagesAndVote(selectedImages: [UIImage], dishId: Int) async {
        isUploading = true
        defer { isUploading = false }

        do {
            // 1️⃣ presigned urls 요청
            let requestDto = PresignedUrlsRequestDto(
                fileType: FileType.DISH.rawValue,
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

            // 3️⃣ accessUrl들 모아서 post 요청
            try await foodDataProvider.postDishVote(dishId: Int64(dishId), imgUrls: imgUrls.compactMap{ $0.accessUrl })

        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func uploadImagesAndNewVote(selectedImages: [UIImage], dishName: String, foodId: Int) async {
        isUploading = true
        defer { isUploading = false }

        do {
            // 1️⃣ presigned urls 요청
            let requestDto = PresignedUrlsRequestDto(
                fileType: FileType.DISH.rawValue,
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

            // 3️⃣ accessUrl들 모아서 post 요청
            try await foodDataProvider.postNewDishVote(dishName: dishName, foodId: Int64(foodId), imgUrls: imgUrls.compactMap{ $0.accessUrl })

        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
