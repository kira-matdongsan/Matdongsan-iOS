//
//  MyPageView.swift
//  Matdongsan
//
//  Created by sujeong on 2/5/25.
//

import SwiftUI

import SwiftUI

struct MyPageView: View {
    @StateObject private var navigationManager = NavigationManager()
    @State private var favoriteFoods: [Food] = [
        Food(id: 1, name: "사과"),
        Food(id: 2, name: "딸기"),
        Food(id: 3, name: "바나나"),
        Food(id: 4, name: "포도"),
        Food(id: 5, name: "2"),
        Food(id: 6, name: "3")]
    private let settings:[String] = ["공지사항", "이용약관", "앱 정보", "오픈소스"]
    private let accountMenu:[String] = ["로그아웃", "회원탈퇴"]
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack(spacing: 0) {
                // 상단 바
                VStack(spacing: 12) {
                    ZStack {
                        Text("마이페이지")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                        HStack {
                            Spacer()
                            Button {
                                // 알림 버튼 액션
                                navigationManager.navigate(to: .notification)
                            } label: {
                                Image("notification") // 에셋 이름
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 1)
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // 프로필 카드
                        VStack(spacing: 4) {
                            Button {
                                navigationManager.navigate(to: .profileSetting)
                            } label: {
                                ZStack(alignment: .topTrailing) {
                                    Image("dongsan-profile")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 72, height: 72)
                                        .clipShape(Circle())
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.mdCoolgray90)
                                        .background(Circle().fill(Color.white))
                                }
                            }
                            
                            Text("말랑딸기찹쌀떡")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.mdGray90)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, y: 2)
                        .padding(.horizontal, 24)
                        
                        // 내 활동
                        Button {
                            navigationManager.navigate(to: .myActivity)
                        } label: {
                            HStack {
                                Image("magic-star")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                Text("내 활동")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.mdGray90)
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.05), radius: 3, y: 2)
                            .padding(.horizontal, 24)
                        }
                        
                        // 좋아하는 제철음식
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("좋아하는 제철음식")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.mdGray90)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(favoriteFoods, id: \.self) { food in
                                        VStack(spacing: 6) {
                                            ZStack(alignment: .bottomTrailing) {
                                                RoundedRectangle(cornerRadius: 16)
                                                    .fill(.mdCoolgray10)
                                                    .frame(width: 72, height: 72)
                                                
                                                // 하트 버튼
                                                Button {
                                                    // 좋아요 액션
                                                } label: {
                                                    Image(systemName: "heart.fill")
                                                        .foregroundColor(.mdSkyBlue40)
                                                        .frame(width: 16, height: 16)
                                                        .padding(6)
                                                        .padding(4)
                                                }
                                            }
                                            
                                            Text(food.name)
                                                .font(.system(size: 12))
                                                .foregroundColor(.mdCoolgray40)
                                                .lineLimit(1)
                                        }
                                    }
                                }
                                .padding(.horizontal, 4)
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        // 하단 구분선
                        Rectangle()
                            .fill(.mdCoolgray10)
                            .frame(height: 6)
                            .padding(.top, 8)
                        
                        // 설정 리스트
                        VStack(alignment: .leading, spacing: 8) {
                            // 이용약관
                            Button {
                                navigationManager.navigate(to: .contract)
                            } label: {
                                HStack {
                                    Text("이용약관")
                                        .font(.system(size: 14))
                                        .foregroundColor(.mdCoolgray40)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray.opacity(0.6))
                                }
                            }
                            
                            // 앱 버전
                            Button {
                                navigationManager.navigate(to: .appVersion)
                            } label: {
                                HStack {
                                    Text("앱 버전")
                                        .font(.system(size: 14))
                                        .foregroundColor(.mdCoolgray40)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray.opacity(0.6))
                                }
                            }

                            
                            // 오픈소스
                            HStack {
                                Text("오픈소스")
                                    .font(.system(size: 14))
                                    .foregroundColor(.mdCoolgray40)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray.opacity(0.6))
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.top, 24)
                }
            }
            .background(Color.white)
            .ignoresSafeArea(edges: .bottom)
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .profileSetting:
                    ProfileSettingView()
                case .myActivity:
                    MyActivityView()
                case .appVersion:
                    AppVersionView()
                case .contract:
                    ContractView()
                case .notification:
                    NotificationView()
                default:
                    ProfileSettingView()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .environmentObject(navigationManager)
    }
}

#Preview {
    MyPageView()
}

