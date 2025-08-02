//
//  VotingResult.swift
//  Matdongsan
//
//  Created by sujeong on 8/2/25.
//

import Foundation

struct VoteResult: Codable {
    let month: Int
    let results: [VoteItem]
    
    init(month: Int, results: [VoteItem]) {
        self.month = month
        self.results = results
    }
}

struct VoteItem: Identifiable, Codable {
    let id: String
    let name: String       // 항목 이름 (ex. "갈치")
    let percentage: Double // 투표율 (ex. 17.4)
    let count: Int         // 투표 수 (ex. 14)
    let isFirst: Bool      // 일등 여부 (ex. true)
}
