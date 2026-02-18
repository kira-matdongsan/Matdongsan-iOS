//
//  MyPageProvider.swift
//  Matdongsan
//
//  Created by sujeong on 2/19/26.
//

import Foundation


final class MyPageProvider {
        
    func fetchMyPage() async throws -> MyPageResponseDto {
        guard let url = URL(string: NetworkConst.profile) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = TokenManager.shared.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        if let responseString = String(data: data, encoding: .utf8) {
            print(123,responseString)
        }
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        let decoded = try JSONDecoder()
            .decode(ResponseDto<MyPageResponseDto>.self, from: data)
        
        return decoded.data
    }
    
    func patchChangeNickname(nickname: String) async throws {
        guard let url = URL(string: NetworkConst.nickname) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = TokenManager.shared.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            let body: [String: Any] = [
                "nickname": nickname
            ]
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            throw NetworkError.invalidData
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        if let responseString = String(data: data, encoding: .utf8) {
            print(123,responseString)
        }
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode) else {
            throw NetworkError.invalidResponse
        }
        print("닉네임 변경 완료")
    }
}
