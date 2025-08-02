//
//  Purchase.swift
//  Matdongsan
//
//  Created by sujeong on 8/2/25.
//

import Foundation

struct Purchase: Identifiable, Codable {
    let id: String
    let buyerNameMasked: String      // "김**"
    let location: String             // "서울"
    let totalPrice: Int              // 1200
    let quantity: Int                // 1
    let createdAt: String              // 구매 시각
}
