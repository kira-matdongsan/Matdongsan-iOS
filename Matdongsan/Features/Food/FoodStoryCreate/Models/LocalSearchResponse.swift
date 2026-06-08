//
//  LocalSearchResponse.swift
//  Matdongsan
//
//  Created by sujeong on 6/8/26.
//


struct LocalSearchResponse: Decodable {
    let items: [PlaceInfo]
}

struct PlaceInfo: Decodable, Identifiable {
    let title: String
    let category: String
    let link: String
    let address: String

    var id: String {
        title + address
    }
    
    var displayTitle: String {
        title
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
    }
}
