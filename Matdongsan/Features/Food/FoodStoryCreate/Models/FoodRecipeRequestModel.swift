//
//  FoodRecipeRequestModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/16/25.
//


struct FoodRecipeRequestModel: Encodable {
    let name: String
    let ingredients: String
    let instructions: String
    let imageUrls: [String]
}
