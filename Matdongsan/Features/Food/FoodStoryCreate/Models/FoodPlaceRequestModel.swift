//
//  FoodPlaceRequestModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/16/25.
//


struct FoodPlaceRequestModel: Encodable {
    var name: String?
    let content: String
    var category: String?
    var address: String?
    var naverUrl: String?
    let imageUrls: [String]
}
