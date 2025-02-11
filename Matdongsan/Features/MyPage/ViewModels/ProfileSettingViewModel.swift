//
//  ProfileSettingViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 2/11/25.
//

import Foundation

class ProfileSettingViewModel: ObservableObject {
    @Published var userProfile: UserProfile?
    
    init(userProfile: UserProfile? = nil) {
        self.userProfile = userProfile
    }
    
    func getUserProfile() {
        let url = URL(string: "http://127.0.0.1:5000/user")!
        
        // completion handler를 후행클로저로
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 에러 있으면 처리 후 종료
            if let error = error {
                print(error.localizedDescription)
                return
            }
            // API 응답이 성공적인 상태코드로 완료되면 이어서 코드 실행
            guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                print(response.debugDescription)
                return
            }
            // 데이터 인코딩 & 패치
            if let data = data {
                DispatchQueue.main.async {
                    guard let userProfile = try? JSONDecoder().decode(UserProfile.self, from: data) else {
                        print("error")
                        return
                    }
                    self.userProfile = userProfile
                }
            }
        }
        
        task.resume()
    }
    
    var id: String {
        self.userProfile?.id ?? "none"
    }
    
    var nickname: String {
        self.userProfile?.nickname ?? "none"
    }
    
    var email: String {
        self.userProfile?.email ?? "none"
    }
    
}
