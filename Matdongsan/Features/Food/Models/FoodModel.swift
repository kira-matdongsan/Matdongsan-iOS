//
//  FoodModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/8/25.
//

import Foundation

struct FoodModel: Codable {
    let weekText: String
    let id: Int
    let name: String
    let englishName: String?
    let subtitle: String?
    let description: String?
    let imageUrl: String?
    let color: String?
    let isFeatured: Bool?
    let lastFeaturedDate: String?
    let isLiked: Bool?
    let seasonMonths: String?
    let regions: String?
    let benefits: String?
    let buyingTips: String?
    let preparationTips: String?
    let nutrients: Nutrients?
}

struct DetailInfoItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
}

extension FoodModel {

    var detailInfoItems: [DetailInfoItem] {
        [
            DetailInfoItem(title: "제철시기", value: seasonMonths ?? ""),
            DetailInfoItem(title: "주요산지", value: regions ?? ""),
            DetailInfoItem(title: "효능", value: benefits ?? ""),
            DetailInfoItem(title: "구입요령", value: buyingTips ?? ""),
            DetailInfoItem(title: "손질요령", value: preparationTips ?? "")
        ]
    }
}

struct Nutrients: Codable {
    let servingSizeLabel: String?
    let servingSizeGram: Int?
    let calories: Int?
    let carbohydrate: Double?
    let dietaryFiber: Double?
    let sugars: Double?
    let protein: Double?
    let fat: Double?
}

struct NutritionItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
}

extension Nutrients {
    var nutritionItems: [NutritionItem] {
        [
            NutritionItem(title: "에너지", value: "\(calories)kcal"),
            NutritionItem(title: "탄수화물", value: "\(carbohydrate)g"),
            NutritionItem(title: "식이섬유", value: "\(dietaryFiber)g"),
            NutritionItem(title: "당", value: "\(sugars)g"),
            NutritionItem(title: "단백질", value: "\(protein)g"),
            NutritionItem(title: "지방", value: "\(fat)g")
        ]
    }
}
extension Nutrients {
    static let mock = Nutrients(
        servingSizeLabel: "100g",
        servingSizeGram: 100,
        calories: 82,
        carbohydrate: 19,
        dietaryFiber: 2.7,
        sugars: 3.2,
        protein: 6.9,
        fat: 1.2
    )
}

extension FoodModel {
    static let mock = FoodModel(
        weekText: "2026년 2월 둘째주",
        id: 1,
        name: "옥수수",
        englishName: "Corn",
        subtitle: "알맹이부터 수염까지 아낌없이 주는",
        description: """
맛동산에서 7월 둘째주로 선정한 제철음식은 바로 ‘옥수수’ 입니다.
더워지기 시작하는 초여름에는 아삭아삭한 초당옥수수부터
땡볕 더위엔 쫀득쫀득한 찰옥수수까지
옥수수는 다양한 식감으로 여름 대표 간식입니다.
""",
        imageUrl: "https://example.com/corn.png",
        color: "#FFEB7B",
        isFeatured: true,
        lastFeaturedDate: "2025-07-07",
        isLiked: true,
        seasonMonths: "7~8월",
        regions: "강원 홍천, 영월, 평창, 충북 괴산, 전남 등지",
        benefits: "비타민B1, B2, E와 함께 칼륨, 철분 등 무기질이 풍부하며 식이섬유도 많이 들어 있어 다이어트와 변비 예방에 효과가 있습니다.",
        buyingTips: "찰옥수수는 겉껍질이 푸르고 윤기가 나며, 알맹이가 꽉 차 있는 것이 좋습니다.",
        preparationTips: "찰옥수수의 껍질과 수염을 같이 잡고 아래로 세게 벗긴다.",
        nutrients: .mock
    )
}
