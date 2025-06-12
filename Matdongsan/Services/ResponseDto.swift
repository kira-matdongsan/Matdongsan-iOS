//
//  ResponseDto.swift
//  Matdongsan
//
//  Created by sujeong on 6/6/25.
//

import Foundation

struct ResponseDto<T: Codable>:Codable {
    var success:Bool
    var code:Int
    var message:String
    var data:T
}
