//
//  FoodPlaceRequestModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/16/25.
//


struct FoodPlaceRequestModel: Encodable {
    let name: String
    let content: String
    let category: String
    let address: String
    let naverUrl: String
    let imageUrls: [String]
}