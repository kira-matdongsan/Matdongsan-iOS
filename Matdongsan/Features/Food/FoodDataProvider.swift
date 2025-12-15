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
    
    // 제철 음식 정보 상세 조회
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
    
    // 제철 요리 순위 목록 조회
    func getDishRanking(_ id: Int64) async throws -> DishRankingModel {
        let endpoint: String = FoodNetworkConst.baseUrl + "\(id)" + FoodNetworkConst.rank
        
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
                ResponseDto<DishRankingModel>.self,
                from: data
            )
            return decoded.data
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    // 제철 음식 기록 스토리 작성
    func postFoodRecord(foodId: Int64, request: FoodRecordRequestModel) async throws {
        let endpoint: String = FoodNetworkConst.baseUrl + "\(foodId)" + FoodNetworkConst.postRecord
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            throw NetworkError.invalidData
        }
        
        let (_, response) = try await URLSession.shared.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode) else {
            throw NetworkError.invalidResponse
        }
    }
    
    // 제철 음식 레시피 스토리 작성
    func postFoodRecipe(foodId: Int64, request: FoodRecipeRequestModel) async throws {
        let endpoint: String = FoodNetworkConst.baseUrl + "\(foodId)" + FoodNetworkConst.postRecord
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            throw NetworkError.invalidData
        }
        
        let (_, response) = try await URLSession.shared.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode) else {
            throw NetworkError.invalidResponse
        }
    }
    
    
}
