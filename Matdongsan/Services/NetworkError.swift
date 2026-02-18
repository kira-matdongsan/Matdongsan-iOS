//
//  Error.swift
//  Matdongsan
//
//  Created by sujeong on 6/6/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case emptyData
    case serverError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)
}
