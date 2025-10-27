//
//  AppVersionView.swift
//  Matdongsan
//
//  Created by sujeong on 10/28/25.
//

import SwiftUI

struct AppVersionView: View {
    let currentVersion = "1.0"
    let latestVersion = "1.2"

    var body: some View {
        VStack(spacing: 16) {
            // 앱 로고 카드
            VStack(spacing: 12) {
                Image("appversion-img")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 130)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(.mdYellow10)
            .cornerRadius(16)
            .padding(.horizontal, 24)
            .shadow(color: Color.black.opacity(0.05), radius: 5, y: 2)

            // 버전 정보
            VStack(spacing: 8) {
                HStack {
                    Text("사용중인 버전")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.mdGray80)
                    Spacer()
                    Text(currentVersion)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.mdGray50)
                }

                HStack {
                    Text("최신 버전")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.mdGray80)
                    Spacer()
                    Text(latestVersion)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.mdGray50)
                }
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .navigationTitle("앱 버전")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white)
    }
}

#Preview {
    NavigationStack {
        AppVersionView()
    }
}

