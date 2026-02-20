//
//  AppVersionView.swift
//  Matdongsan
//
//  Created by sujeong on 10/28/25.
//

import SwiftUI

struct AppVersionView: View {
    @State private var latestVersion = ""
    
    let currentVersion: String =
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
    var body: some View {
        VStack(spacing: 16) {

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
                    Text(latestVersion.isEmpty ? "-" : latestVersion)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.mdGray50)
                }
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .navigationTitle("앱 버전")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await fetchLatestVersion()
        }
    }

    func fetchLatestVersion() async {
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        let urlString = "https://itunes.apple.com/lookup?bundleId=\(bundleID)&country=kr"
        
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                let results = json["results"] as? [[String: Any]],
                let appStoreVersion = results.first?["version"] as? String
            {
                await MainActor.run {
                    self.latestVersion = appStoreVersion
                }
            }
        } catch {
            print("버전 조회 실패:", error)
        }
    }
}

#Preview {
    NavigationStack {
        AppVersionView()
    }
}

