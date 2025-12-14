//
//  FoodDataProvider.swift
//  Matdongsan
//
//  Created by sujeong on 12/14/25.
//

import Foundation

struct FoodDataProvider {
    
    private let session = URLSession(
        configuration: .default,
        delegate: InsecureSessionDelegate(),
        delegateQueue: nil
    )
    
    func getFoodInfo(_ id: Int64) async throws -> FoodModel {
        let endpoint: String = FoodNetworkConst.baseUrl + "\(id)" + FoodNetworkConst.info
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: urlRequest)
                
        guard let response = response as? HTTPURLResponse,
              (200..<300) ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoded = try JSONDecoder().decode(
                ResponseDto<FoodModel>.self,
                from: data
            )
            return decoded.data
        } catch {
            throw NetworkError.invalidData
        }
        
    }
}
