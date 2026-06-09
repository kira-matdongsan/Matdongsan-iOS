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
    
    private let clientId: String = "Lo1oPZFBR15FGmaahZcC"
    private let clientSecret: String = "2vvsZj2YV4"
    
    @Published var selectedPlace: PlaceInfo?

    private let provider: FoodDataProvider

    init(provider: FoodDataProvider = FoodDataProvider()) {
        self.provider = provider
    }
    
    func searchPlace(keyword: String) async throws -> [PlaceInfo] {

        var components = URLComponents(
            string: "https://openapi.naver.com/v1/search/local.json"
        )!

        components.queryItems = [
            URLQueryItem(name: "query", value: keyword),
            URLQueryItem(name: "display", value: "10"),
            URLQueryItem(name: "start", value: "1"),
            URLQueryItem(name: "sort", value: "random")
        ]

        let url = components.url!

        var request = URLRequest(url: url)

        request.setValue(
            clientId,
            forHTTPHeaderField: "X-Naver-Client-Id"
        )

        request.setValue(
            clientSecret,
            forHTTPHeaderField: "X-Naver-Client-Secret"
        )

        let (data, _) = try await URLSession.shared.data(for: request)

        let result = try JSONDecoder().decode(
            LocalSearchResponse.self,
            from: data
        )

        return result.items
    }
    
    func postPlace(
        foodId: Int64,
        name: String,
        category: String?,
        address: String?,
        link: String?,
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
            category: category,
            address: address,
            naverUrl: link,
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
    
    func reset() {
        selectedPlace = nil
        isSuccess = false
    }

}
