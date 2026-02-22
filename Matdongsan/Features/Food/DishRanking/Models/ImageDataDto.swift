//
//  ImageUploadDataDto.swift
//  Matdongsan
//
//  Created by sujeong on 2/22/26.
//


struct ImageDataDto: Codable {
    let contents: [ImageContentDto]
}

struct ImageContentDto: Codable {
    let imageId: Int64
    let imageUrl: String
}
