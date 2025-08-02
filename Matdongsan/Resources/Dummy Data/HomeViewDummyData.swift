//
//  HomeViewDummyData.swift
//  Matdongsan
//
//  Created by sujeong on 8/2/25.
//

import Foundation

struct HomeViewDummyData {
    static var dummySeasonalPrice = SeasonalFoodPrice(
        id: UUID().uuidString,
        foodName: "옥수수",
        averagePricePerUnit: 1150,
        purchases: [
            Purchase(
                id: UUID().uuidString,
                buyerNameMasked: "김**",
                location: "서울",
                totalPrice: 1200,
                quantity: 1,
                createdAt: "6분 전"
            ),
            Purchase(
                id: UUID().uuidString,
                buyerNameMasked: "김**",
                location: "속초중앙시장",
                totalPrice: 12000,
                quantity: 6,
                createdAt: "어제"
            ),
            Purchase(
                id: UUID().uuidString,
                buyerNameMasked: "김**",
                location: "서울",
                totalPrice: 1200,
                quantity: 1,
                createdAt: "07.12"
            )
        ],
        createdAt: "2025년 7월 18일 오후 5시 37분"
    )
}
