//
//  HomeView.swift
//  Matdongsan
//
//  Created by sujeong on 7/5/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var navigationManager = NavigationManager()
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    @EnvironmentObject var authManager: AuthManager
    
    let month: Int = 7
    let week: String = "넷"
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }
    @State var enabledQuiz: Bool = true
    @State var enabledAnswer: Bool = false

    var weeks:[Int] = [4,5,6,7,8,9,10]
    var foodId: Int? {
        viewModel.model?.featuredFood.foodId
    }
    
    var body: some View {
        NavigationStack(path: $navigationManager.path)  {
            ZStack {
                VStack (spacing: 0) {
                    // 탑바 (로고, 검색 아이콘)
                    HStack {
                        Image("small-logo")
                        Spacer()
                        
                        // MVP: 홈
                        Button {
                            navigationManager.navigate(to: .myPage)
                        } label: {
                            Image("user")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 54)
                    
                    ScrollView {
                        VStack (spacing: 0) {
                            
                            VStack (spacing: 0) {
                                // 주간 제철 음식
                                if enabledAnswer {
                                    ThisweekFoodView(viewModel: viewModel)
                                } else {
                                    ThisweekPlaceholderView(viewModel: viewModel)
                                }
                            }
                            .onTapGesture {
                                enabledAnswer.toggle()
                                // TODO: 한번 클릭했는지 저장하기 (1주일마다)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            
                            CustomDivider(opacity: 0.5)
                                .padding(.vertical, 16)
                            
                            // 투표결과
                            HomeDishRankingView(foodName: viewModel.foodName)
                            
                            // 제철 시세
//                            FoodPriceView(foodPrice: HomeViewDummyData.dummySeasonalPrice)
                            
                        }
                    }
                    .scrollDisabled(true)
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .homeView:
                    SearchView()
                case .detailView:
                    if #available(iOS 18.0, *) {
                        FoodDetailPageView(foodId: 1)
                    } else {
                        // Fallback on earlier versions
                    }
                case .placeSearch:
                    PlaceSearchView()
                case .record(let foodName, let foodEngName):
                    FoodRecordWriteView(foodName: foodName, foodEngName: foodEngName)
                case .recipe(let foodName, let foodEngName):
                    FoodRecipeWriteView(foodName: foodName, foodEngName: foodEngName)
                case .place:
                    FoodPlaceWriteView()
                case .search:
                    SearchView()
                case .calendar:
                    CalendarPageView(selectedDate: Date(), displayedMonth: Date())
                case .priceInput:
                    PricingInputView()
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
                case .myPage:
                    if authManager.isLoggedIn {
                        MVPMyPageView()
                    } else {
                        UnloginMyPageView()
                    }
                case .login:
                    LoginView(authManager: authManager)
                case .dishVoting(let dishId, let dishName):
                    DishVotingView(dishId: dishId, dishName: dishName)
                case .newDishVoting(let foodName, let foodEngName):
                    NewDishVotingView(foodName: foodName, foodEngName: foodEngName)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .environmentObject(navigationManager)
        .task {
            await viewModel.fetchHome()
        }
    }
}

#Preview {
    HomeView()
}
