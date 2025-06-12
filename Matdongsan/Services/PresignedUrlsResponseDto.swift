//
//  PresignedUrlRequestDto.swift
//  Matdongsan
//
//  Created by sujeong on 6/6/25.
//

import Foundation

struct PresignedUrlsResponseDto:Codable {
    var contents:[ImageUrlResponse]
}


struct ImageUrlResponse:Codable {
    var fileName: String
    var presignedUrl: String
    var accessUrl: String
}
