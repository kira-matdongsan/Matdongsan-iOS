//
//  MatdongsanApp.swift
//  Matdongsan
//
//  Created by sujeong on 12/17/24.
//

import SwiftUI
import NidThirdPartyLogin

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NidOAuth.shared.initialize()
        NidOAuth.shared.setLoginBehavior(.appPreferredWithInAppBrowserFallback) // 네이버 앱이 있으면 앱으로 연결, 없으면 앱 내에서 safari 뷰 호출
        
        
        
        return true
    }
    
    // scene delegate 연결
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}

@main
struct MatdongsanApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainTabView() // 실행안되는듯
        }
    }
}
