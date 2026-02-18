//
//  HomeViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 2/15/26.
//

import Foundation

var foodId: Int64? = 0

class HomeViewModel: ObservableObject {
    @Published var model: HomeModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let provider: HomeDataProvider
    
    var weekText: String {
        model?.banner.weekText ?? ""
    }
    
    var foodName: String {
        model?.featuredFood.name ?? ""
    }
    
    var subTitle: String {
        model?.featuredFood.subtitle?.replacingOccurrences(of: "\\n", with: "\n") ?? ""
    }
    
    var thumnail: String? {
        model?.featuredFood.thumbnail
    }

    init(provider: HomeDataProvider = HomeDataProvider()) {
        self.provider = provider
    }
    
    @MainActor
    func fetchHome() async {
        isLoading = true
        errorMessage = nil

        do {
            model = try await provider.getHome()
            print(model)
            UserDefaults.standard.set(model?.featuredFood.foodId, forKey: "foodId")
            foodId = Int64(model?.featuredFood.foodId ?? 0)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
