//
//  MatdongsanApp.swift
//  Matdongsan
//
//  Created by sujeong on 12/17/24.
//

import SwiftUI
import NidThirdPartyLogin
import AuthenticationServices
import KakaoSDKCommon
import KakaoSDKAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // 네이버
        NidOAuth.shared.initialize()
        NidOAuth.shared.setLoginBehavior(.appPreferredWithInAppBrowserFallback) // 네이버 앱이 있으면 앱으로 연결, 없으면 앱 내에서 safari 뷰 호출
        // 카카오
        KakaoSDK.initSDK(appKey: "87307be9ae9968790e414ca67b20e251")
        
        return true
    }
}

@main
struct MatdongsanApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.white // 원하는 배경색
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.white // 원하는 배경색
        tabBarAppearance.shadowColor = .clear
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
