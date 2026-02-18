//
//  MyPageViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 2/19/26.
//

import Foundation

@MainActor
final class MyPageViewModel: ObservableObject {
    
    @Published var myPage: MyPageResponseDto?
    @Published var errorMessage: String?
    
    private let provider = MyPageProvider()
    
    var nickname: String {
        myPage?.nickname ?? "unknown"
    }
    
    var profileImage: String {
        myPage?.profileImageUrl ?? ""
    }
    
    func loadMyPage() async {
        do {
            myPage = try await provider.fetchMyPage()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func changeNickname(nickname: String) async {
        do {
            try await provider.patchChangeNickname(nickname: nickname)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
