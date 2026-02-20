//
//  TokenResponse.swift
//  Matdongsan
//
//  Created by sujeong on 2/21/26.
//


struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}