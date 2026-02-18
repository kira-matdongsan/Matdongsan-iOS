//
//  RootView.swift
//  Matdongsan
//
//  Created by sujeong on 1/28/26.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var showLoginAfterOnboarding = false

    var body: some View {
        if hasSeenOnboarding {
            MainTabView(showLogin: showLoginAfterOnboarding)
        } else {
            OnboardingView(
                onLoginTap: {
                    hasSeenOnboarding = true
                    showLoginAfterOnboarding = true
                },
                onSkipTap: {
                    hasSeenOnboarding = true
                }
            )
        }
    }
}
