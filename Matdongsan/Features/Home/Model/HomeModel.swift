//
//  HomeModel.swift
//  Matdongsan
//
//  Created by sujeong on 2/15/26.
//


struct HomeModel: Codable {
    let banner: HomeBannerModel
    let featuredFood: FeaturedFoodModel
}

struct HomeBannerModel: Codable {
    let weekText: String
}

struct FeaturedFoodModel: Codable {
    let foodId: Int
    let name: String
    let subtitle: String?
    let thumbnail: String?
}
