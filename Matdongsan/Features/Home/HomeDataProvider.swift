//
//  HomeDataProvider.swift
//  Matdongsan
//
//  Created by sujeong on 12/14/25.
//

import Foundation

struct HomeDataProvider {
    
    private let session = URLSession(
        configuration: .default,
        delegate: InsecureSessionDelegate(),
        delegateQueue: nil
    )
    
    func getHome() async throws -> HomeModel {
        let endpoint: String = NetworkConst.home
        
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
                ResponseDto<HomeModel>.self,
                from: data
            )
            return decoded.data
        } catch {
            throw NetworkError.invalidData
        }
    }
}
