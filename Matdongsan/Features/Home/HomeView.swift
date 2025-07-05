//
//  HomeView.swift
//  Matdongsan
//
//  Created by sujeong on 7/5/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("Home")
                
                NavigationLink {
                    FoodDetailPageView()
                } label: {
                    Text("제철음식 상세화면")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
