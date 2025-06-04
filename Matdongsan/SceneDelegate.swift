//
//  SceneDelegate.swift
//  Matdongsan
//
//  Created by sujeong on 2/19/25.
//

import Foundation
import SwiftUI
import NidThirdPartyLogin

// UI Lifecycle 담당
class SceneDelegate: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?
    
    // 앱 연결되면 실행되는 함수 (뷰 띄우기)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        // 얘네 없이도 되긴 하는데 왜 필요한 건지 찾아봐야됨
        
        window?.rootViewController = UIHostingController(rootView: TestingHome()) // UIKit와 호환될 수 있도록
        window?.makeKeyAndVisible()
        
    }

    // 외부 앱에서 앱으로 돌아왔을 때 URL 처리
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if NidOAuth.shared.handleURL(url) == true {
                // 네이버앱에서 전달된 URL인 경우(NidOAuth)
                return
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
}
