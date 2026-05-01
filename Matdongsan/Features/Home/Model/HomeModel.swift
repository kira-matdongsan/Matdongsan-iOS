//
//  HomeModel.swift
//  Matdongsan
//
//  Created by sujeong on 2/15/26.
//


struct HomeModel: Codable {
    let banner: HomeBannerModel
    let featuredFood: FeaturedFoodModel
    let weeklyRecord: WeeklyRecordModel?
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

struct WeeklyRecordModel: Codable {
    let records: [WeeklyRecord]
}

struct WeeklyRecord: Codable {
    let date: String          // "yyyy-MM-dd"
    let foodName: String
    let subTitle: String
}
