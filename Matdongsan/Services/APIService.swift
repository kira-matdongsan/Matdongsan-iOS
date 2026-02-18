//
//  APIService.swift
//  Matdongsan
//
//  Created by sujeong on 6/6/25.
//

import Foundation
import Combine

struct APIService {
    let baseURL:String = "https://mds.hyeinisfree.me"
    
    /// 이미지 업로드용 S3 presigned URL을 요청하는 함수입니다.
    /// - Parameters:
    ///   - request: 업로드할 파일들의 정보를 담은 요청 DTO (`PresignedUrlsRequestDto`)
    ///   - completionHandler: 요청 성공 시 호출되는 클로저. S3 presigned URL 목록을 포함한 응답 DTO를 전달합니다.
    /// - Throws: URL 생성에 실패하면 `NetworkError.invalidURL`를 throw합니다.
    func getImgPresignedUrls(
        _ request: PresignedUrlsRequestDto
    ) async throws -> PresignedUrlsResponseDto {
        
        let endpoint = baseURL + "/api/v1/files/presigned-urls"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = try JSONEncoder().encode(request)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        let decoded = try JSONDecoder()
            .decode(ResponseDto<PresignedUrlsResponseDto>.self, from: data)
        
        return decoded.data
    }

    
    /// S3 presigned URL을 사용하여 바이너리 이미지 데이터를 업로드하는 함수입니다.
    /// - Parameters:
    ///   - presignedURL: S3 presigned URL 문자열
    ///   - imageData: 업로드할 이미지의 바이너리 데이터 (`Data`)
    ///   - completionHandler: 업로드 성공 시 호출되는 클로저
    /// - Throws: URL 생성에 실패하면 `NetworkError.invalidURL`를 throw합니다.
    func uploadImgtoS3(
        _ presignedURL: String,
        _ imageData: Data
    ) async throws {
        
        guard let url = URL(string: presignedURL) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("image/png", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await URLSession.shared.upload(
            for: urlRequest,
            from: imageData
        )
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
    }

}
