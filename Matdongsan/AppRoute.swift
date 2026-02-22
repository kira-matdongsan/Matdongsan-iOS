//
//  AppRoute.swift
//  Matdongsan
//
//  Created by sujeong on 6/21/25.
//

import Foundation

enum AppRoute:Hashable {
    case homeView
    case detailView
    case placeSearch
    case record(foodName: String, foodEngName: String)
    case recipe(foodName: String, foodEngName: String)
    case place
    case search
    case calendar
    case priceInput
    case profileSetting
    case myActivity
    case appVersion
    case contract
    case privacy
    case notification
    case myPage
    case login
    case dishVoting(dishId: Int, dishName: String)
    case newDishVoting(foodName: String, foodEngName: String)
}
