//
//  APIService.swift
//  Matdongsan
//
//  Created by sujeong on 6/6/25.
//

import Foundation

struct APIService {
    let baseURL:String = "https://mds.hyeinisfree.me"
    
    /// 이미지 업로드용 S3 presigned URL을 요청하는 함수입니다.
    /// - Parameters:
    ///   - request: 업로드할 파일들의 정보를 담은 요청 DTO (`PresignedUrlsRequestDto`)
    ///   - completionHandler: 요청 성공 시 호출되는 클로저. S3 presigned URL 목록을 포함한 응답 DTO를 전달합니다.
    /// - Throws: URL 생성에 실패하면 `NetworkError.invalidURL`를 throw합니다.
    func getImgPresignedUrls(_ request: PresignedUrlsRequestDto, completionHandler: @escaping (PresignedUrlsResponseDto) -> Void) throws {
        let endpoint:String = baseURL + "/api/v1/files/presigned-urls"
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        // request object to json request
        do {
            let jsonData = try JSONEncoder().encode(request)
            urlRequest.httpBody = jsonData
        } catch {
            print("error")
            return
        }
        
        // request network call
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("error \(error.debugDescription)")
                return
            }
            
            guard let data = data else {
                print("invalid data")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            guard let output = try? JSONDecoder().decode(ResponseDto<PresignedUrlsResponseDto>.self, from: data) else {
                print("Error: JSON Data Parsing failed")
                return
            }
            
            completionHandler(output.data)
        }.resume()
    }
    
    /// S3 presigned URL을 사용하여 바이너리 이미지 데이터를 업로드하는 함수입니다.
    /// - Parameters:
    ///   - presignedURL: S3 presigned URL 문자열
    ///   - imageData: 업로드할 이미지의 바이너리 데이터 (`Data`)
    ///   - completionHandler: 업로드 성공 시 호출되는 클로저
    /// - Throws: URL 생성에 실패하면 `NetworkError.invalidURL`를 throw합니다.
    func uploadImgtoS3(_ presignedURL: String, _ imageData:Data, completionHandler: @escaping () -> Void ) throws {
        guard let url = URL(string: presignedURL) else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("image/png", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.uploadTask(with: urlRequest, from: imageData) { data, response, error in
            if let error = error {
                print("error: \(error)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("server error")
                return
            }

            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("got data: \(dataString)")
                completionHandler()
            } else {
                print("data failure")
            }
        }.resume()
    }
}
