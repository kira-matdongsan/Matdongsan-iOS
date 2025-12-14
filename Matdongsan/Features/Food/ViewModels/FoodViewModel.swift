//
//  FoodViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/8/25.
//

import Foundation

@MainActor
class FoodViewModel: ObservableObject {
    
    @Published var food: FoodModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let foodDataProvider = FoodDataProvider()
    
    func fetchFood(id: Int64) async {
        isLoading = true
        errorMessage = nil
        
        do {
            food = try await foodDataProvider.getFoodInfo(id)
            print(food)
        } catch {
            errorMessage = "잘못된 요청입니다."
        }
        
        isLoading = false
    }
}
