//
//  Food.swift
//  Matdongsan
//
//  Created by sujeong on 5/21/25.
//

import Foundation

struct Food: Codable, Hashable, Identifiable {
    var id: Int64                   // 제철음식 ID
    var name: String                // 제철음식명
    var englishName: String         // 제철음식명 영문
    var isFeatured: Bool = false    // 공개 여부
    var lastFeaturedAt: Date        // 마지막(최근) 공개일
    var imageUrl: String            // 대표 이미지 URL
    var subtitle: String            // 소제목
    var description: String         // 설명
//    var seasonMonths: []          // 제철시기
    var regions: String             // 주요 산지
    var benefits: String            // 효능
    var buyingTips: String          // 구입요령
    var preparationTips: String     // 손질요령
//    var nutrients: Nutrients      // 영양성분
    var createdAt: Date
    var updatedAt: Date
}

/*
 id               BIGINT AUTO_INCREMENT PRIMARY KEY, -- 제철음식 ID
     name             VARCHAR(255) NOT NULL,             -- 제철음식명
     english_name     VARCHAR(255),                      -- 제철음식명 영문
     is_featured      BOOLEAN DEFAULT FALSE,             -- 공개 여부
     last_featured_at DATETIME,                          -- 마지막 공개일 (featured_food.start_at)
     image_url        TEXT,                              -- 대표 이미지
     subtitle         VARCHAR(255),                      -- 소제목
     description      TEXT,                              -- 설명
     season_months    JSON,                              -- 제철시기
     regions          TEXT,                              -- 주요 산지
     benefits         TEXT,                              -- 효능
     buying_tips      TEXT,                              -- 구입요령
     preparation_tips TEXT,                              -- 손질요령
     nutrients        JSON,                              -- 영양성분
     created_at       DATETIME,
     updated_at       DATETIME
 */
