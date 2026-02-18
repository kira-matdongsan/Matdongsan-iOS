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
        
        if let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
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
            if let responseString = String(data: data, encoding: .utf8) {
                print(responseString)
            }
            let decoded = try JSONDecoder().decode(
                ResponseDto<DishRankingModel>.self,
                from: data
            )
            return decoded.data
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    // 제철 요리 투표
    func postDishVote(dishId: Int64, imgUrls: [String]) async throws {
        let endpoint: String = NetworkConst.dish + "\(dishId)" + NetworkConst.vote
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = TokenManager.shared.accessToken {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        do {
            let body: [String: Any] = [
                "imageUrls": imgUrls
            ]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            throw NetworkError.invalidData
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        if let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
        }
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode) else {
            throw NetworkError.invalidResponse
        }
        print("제철 요리 투표 완료")
    }
    
    // 제철 요리 등록 & 투표
    func postNewDishVote(dishName: String, foodId: Int64, imgUrls: [String]) async throws {
        let endpoint: String = FoodNetworkConst.baseUrl + "\(foodId)" + FoodNetworkConst.newDishVote
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = TokenManager.shared.accessToken {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        do {
            let body: [String: Any] = [
                "name": dishName,
                "imageUrls": imgUrls
            ]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            throw NetworkError.invalidData
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        if let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
        }
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode) else {
            throw NetworkError.invalidResponse
        }
        print("제철 요리 등록 & 투표 완료")
    }
    
    // 제철 음식 스토리 목록 조회
    func getFoodStories(_ id: Int64) async throws -> PagedStoryDto {
        let endpoint: String = FoodNetworkConst.baseUrl + "\(id)" + FoodNetworkConst.getStories
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: urlRequest)
        if let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
        }
        guard let response = response as? HTTPURLResponse,
              (200..<300) ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        do {
            if let responseString = String(data: data, encoding: .utf8) {
                print(responseString)
            }
            let decoded = try JSONDecoder().decode(
                ResponseDto<PagedStoryDto>.self,
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
        if let token = TokenManager.shared.accessToken {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            throw NetworkError.invalidData
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        if let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
        }
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode) else {
            throw NetworkError.invalidResponse
        }
        print("제철 음식 기록 스토리 작성 완료")
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
        if let token = TokenManager.shared.accessToken {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            throw NetworkError.invalidData
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        if let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
        }
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode) else {
            throw NetworkError.invalidResponse
        }
    }
    
    // 제철 음식 플레이스 스토리 작성
    func postFoodPlace(foodId: Int64, request: FoodPlaceRequestModel) async throws {
        let endpoint: String = FoodNetworkConst.baseUrl + "\(foodId)" + FoodNetworkConst.postRecord
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = TokenManager.shared.accessToken {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
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
    
    // 제철 음식 스토리 삭제
    func deleteStory(_ id: Int64) async throws {
        let endpoint: String = FoodNetworkConst.baseUrl + FoodNetworkConst.deleteStory + "\(id)"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = TokenManager.shared.accessToken {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        if let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
        }
        guard let response = response as? HTTPURLResponse,
              (200..<300) ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        if let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
        }
    }
}
