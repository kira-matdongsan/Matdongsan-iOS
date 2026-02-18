//
//  MyPageResponseDto.swift
//  Matdongsan
//
//  Created by sujeong on 2/19/26.
//


struct MyPageResponseDto: Codable {
    let loginType: String
    let email: String?
    let nickname: String
    let profileImageUrl: String?
}
