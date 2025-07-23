//
//  HomeView.swift
//  Matdongsan
//
//  Created by sujeong on 7/5/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var navigationManager:NavigationManager

    var body: some View {
        
        VStack {
            Text("Home")
            
            Button {
                navigationManager.navigate(to: .detailView)
            } label: {
                Text("제철음식 상세화면")
            }
        }
    }
}

#Preview {
    HomeView()
}
