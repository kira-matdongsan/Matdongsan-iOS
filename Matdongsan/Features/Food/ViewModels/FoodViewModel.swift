//
//  FoodViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/8/25.
//

import Foundation
import UIKit

@MainActor
class FoodViewModel: ObservableObject {
    
    @Published var food: FoodModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let foodDataProvider = FoodDataProvider()
    
    var weekText: String {
        food?.weekText ?? ""
    }
    
    var foodName: String {
        food?.name ?? ""
    }
    
    var foodEngName: String {
        food?.englishName ?? ""
    }
    
    var title: String {
        "\(food?.name ?? "") \(food?.englishName ?? "")"
    }
    
    var subTitle: String {
        food?.subtitle?.replacingOccurrences(of: "\\n", with: " ") ?? ""
    }
    
    var description: String {
        food?.description ?? ""
    }
    
    var imageUrl: String {
        food?.imageUrl ?? ""
    }
    
    var color: UIColor {
        UIColor(hexCode: food?.color ?? "#FFFFFF")
    }
    
    func fetchFood(id: Int64) async {
        isLoading = true
        errorMessage = nil
        
        do {
            food = try await foodDataProvider.getFoodInfo(id)
        } catch {
            errorMessage = "잘못된 요청입니다."
        }
        
        isLoading = false
    }
}
