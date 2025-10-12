////
////  TestingHome.swift
////  Matdongsan
////
////  Created by sujeong on 6/2/25.
////
//
//import SwiftUI
//
//struct TestingHome: View {
//    @StateObject private var navigationManager = NavigationManager()
//    
//    var body: some View {
//        NavigationStack(path: $navigationManager.path)  {
//            ZStack {
//                Color(.mdGray80)
//                
//                VStack (spacing: 16) {
//                    Image("dongsan")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 180)
//                    
//                    Text("맛동산 iOS 테스트 홈")
//                        .fontWeight(.bold)
//                        .padding(.horizontal, 16)
//                        .padding(.vertical, 8)
//                        .foregroundStyle(.mdCoolgray90)
//                        .background(.mdYellow)
//                        .cornerRadius(24)
//                        .padding(8)
//                    
//                    
//                    Group {
//                        Button {
//                            navigationManager.navigate(to: AppRoute.homeView)
//                        } label: {
//                            Text("🏠 홈화면")
//                        }
//                        Button {
//                            navigationManager.navigate(to: AppRoute.detailView)
//                        } label: {
//                            Text("🌽 옥수수 제철음식 상세화면")
//                        }
//                        
//                        NavigationLink(destination: JoinView()) {
//                            Text("🙌 회원가입")
//                            
//                        }
//                        
//                        NavigationLink(destination: LoginView()) {
//                            Text("✅ 로그인")
//                        }
//                        
//                        NavigationLink(destination: OnboardingView()) {
//                            Text("😆 온보딩")
//                                .frame(maxWidth: 300)
//                            
//                        }
//                    }
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                    .foregroundStyle(.white)
//                    .padding(.vertical, 14)
//                    .frame(maxWidth: 300)
//                    .background(.mdCoolgray50)
//                    .cornerRadius(12)
//                }
//            }
//            .ignoresSafeArea()
//            .navigationDestination(for: AppRoute.self) { route in
//                switch route {
//                case .homeView:
//                    HomeView()
//                case .detailView:
//                    if #available(iOS 18.0, *) {
//                        FoodDetailPageView()
//                    } else {
//                        // Fallback on earlier versions
//                    }
//                case .placeSearch:
//                    PlaceSearchView()
//                case .record:
//                    FoodRecordWriteView()
//                case .recipe:
//                    FoodRecipeWriteView()
//                case .place:
//                    FoodPlaceWriteView()
//                case .search:
//                    SearchView()
//                case .calendar:
//                    CalendarPageView(selectedDate: Date(), displayedMonth: Date())
//                case .priceInput:
//                    PricingInputView()
//                }
//            }
//        }
//        .environmentObject(navigationManager)
//    }
//}
//
//#Preview {
//    TestingHome()
//}
