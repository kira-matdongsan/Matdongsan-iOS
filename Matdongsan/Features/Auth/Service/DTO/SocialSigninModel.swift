//
//  SocialSigninModel.swift
//  Matdongsan
//
//  Created by sujeong on 2/8/26.
//

import Foundation

struct SocialSigninModel: Codable {
    let accessToken: String
    let refreshToken: String
    let newUser: Bool
}
