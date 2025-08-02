//
//  SeasonalFoodPrice.swift
//  Matdongsan
//
//  Created by sujeong on 8/2/25.
//

import Foundation

struct SeasonalFoodPrice: Identifiable, Codable {
    let id: String
    let foodName: String                  // "옥수수"
    let averagePricePerUnit: Int         // 1150
    let purchases: [Purchase]            // 구매 정보
    let createdAt: String                // "2025년 7월 18일 오후 5시 37분"
}
