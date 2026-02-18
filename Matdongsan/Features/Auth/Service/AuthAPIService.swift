//
//  AuthAPIService.swift
//  Matdongsan
//
//  Created by sujeong on 2/8/26.
//

import Foundation
struct AuthAPIService {
//    if let httpResponse = response as? HTTPURLResponse,
//       httpResponse.statusCode == 401 {
//
//        // 🔥 토큰 만료
//        self.refreshToken { success in
//            if success {
//                // 🔁 원래 요청 다시 실행
//                self.request(request, completion: completion)
//            } else {
//                completion(.failure(NetworkError.serverError))
//            }
//        }
//        return
//    }

    func postSocialSignIn(
        _ provider: String,
        _ authToken: String,
        completion: @escaping (Result<SocialSigninModel, Error>) -> Void
    ) {
        guard let url = URL(string: NetworkConst.socialSignIn) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = [
            "provider": provider,
            "token": authToken
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }

            do {
                let decoded = try JSONDecoder()
                    .decode(ResponseDto<SocialSigninModel>.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded.data))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    private func refreshToken(completion: @escaping (Bool) -> Void) {
        guard let accessToken = TokenManager.shared.accessToken else {
            completion(false)
            return
        }
        guard let refreshToken = TokenManager.shared.refreshToken else {
            completion(false)
            return
        }

        var request = URLRequest(url: URL(string: NetworkConst.refreshToken)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["accessToken": accessToken, "refreshToken": refreshToken]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data,
                  let decoded = try? JSONDecoder().decode(SocialSigninModel.self, from: data)
            else {
                completion(false)
                return
            }

            TokenManager.shared.save(
                accessToken: decoded.accessToken,
                refreshToken: decoded.refreshToken
            )

            completion(true)

        }.resume()
    }

}
