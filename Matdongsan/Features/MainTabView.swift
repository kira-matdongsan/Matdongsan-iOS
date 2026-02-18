//
//  MainTabView.swift
//  Matdongsan
//
//  Created by sujeong on 7/5/25.
//

import SwiftUI

struct MainTabView: View {
    @State var showLogin: Bool
    @StateObject private var auth = AuthState()

    var body: some View {
        HomeView()
            .fullScreenCover(isPresented: $showLogin) {
                LoginView()
            }
            .environmentObject(auth)
//            .tabItem {
//                Image(systemName: "1.square.fill")
//                Text("First")
//            }
//        TabView {
//            HomeView()
//                .tabItem {
//                    Image(systemName: "1.square.fill")
//                    Text("First")
//                }
//            FoodListView()
//                .tabItem {
//                    Image(systemName: "2.square.fill")
//                    Text("Second")
//                }
//            MyPageView()
//                .tabItem {
//                    Image(systemName: "3.square.fill")
//                    Text("Third")
//                }
//        }
//        .toolbarBackground(.white, for: .tabBar)
    }
}

#Preview {
    MainTabView(showLogin: true)
}
