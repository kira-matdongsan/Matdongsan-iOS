//
//  FoodRecordRequestModel.swift
//  Matdongsan
//
//  Created by sujeong on 12/15/25.
//

struct FoodRecordRequestModel: Encodable {
    let content: String
    let recordedDate: String
    let imageUrls: [String]
}
