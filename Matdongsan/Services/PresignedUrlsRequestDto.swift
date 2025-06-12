//
//  PresignedUrlRequestDto.swift
//  Matdongsan
//
//  Created by sujeong on 6/6/25.
//

import Foundation

struct PresignedUrlsRequestDto:Codable {
    var fileType:String = FileType.FOOD_STORY.rawValue
    var fileNames:[String]
}
