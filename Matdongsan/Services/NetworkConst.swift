//
//  NetworkConst.swift
//  Matdongsan
//
//  Created by sujeong on 2/8/26.
//

import Foundation

struct NetworkConst {
    static let baseURL: String = "https://mds.hyeinisfree.me/api/v1/"

    // MARK: - Auth
    static let socialSignIn: String = baseURL + "auth/oauth/signin"
    
    static let refreshToken: String = baseURL + "auth/reissue"
    
    // MARK: - Home
    static let home: String = baseURL + "home"
    
    // MARK: - Dish
    static let dish: String = baseURL + "dishes"
    static let vote: String = "/vote"
    
    // MARK: - My page
    static let profile: String = baseURL + "profile"
    static let nickname: String = baseURL + "profile/nickname" // patch
}
