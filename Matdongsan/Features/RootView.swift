//
//  RootView.swift
//  Matdongsan
//
//  Created by sujeong on 1/28/26.
//

import SwiftUI

struct RootView: View {
    @StateObject private var auth = AuthState()

    var body: some View {
        Group {
            if auth.isLoggedIn {
                MainTabView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            auth.checkAppleLogin()
        }
        .environmentObject(auth)
    }
}
