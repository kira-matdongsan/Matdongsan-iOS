//
//  HomeView.swift
//  Matdongsan
//
//  Created by sujeong on 7/5/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var navigationManager = NavigationManager()

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
    
    // vote
    let dummyVoteResult = VoteResult(
        month: 8,
        results: [
            VoteItem(id: UUID().uuidString, name: "갈치", percentage: 17.4, count: 14, isFirst: false),
            VoteItem(id: UUID().uuidString, name: "옥수수", percentage: 65.3, count: 53, isFirst: true),
            VoteItem(id: UUID().uuidString, name: "자두", percentage: 12.7, count: 10, isFirst: false),
            VoteItem(id: UUID().uuidString, name: "한치", percentage: 4.6, count: 4, isFirst: false)
        ]
    )
    
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
                        
                        // 검색 아이콘
//                        Button {
//                            navigationManager.navigate(to: .search)
//                        } label: {
//                            Image("search-normal-80")
//                        }
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 54)
                    
                    ScrollView {
                        VStack (spacing: 0) {
                            
                            VStack (spacing: 0) {
                                // 주간 제철 음식
                                if enabledAnswer {
                                    ThisweekFoodView()
                                } else {
                                    ThisweekPlaceholderView()
                                }
                                
                                // 주간 제철 기록장
//                                WeeklyRecordView()
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
                            VoteResultView(voteResult: dummyVoteResult)
                            
//                            CustomDivider(opacity: 0.5)
//                                .padding(.vertical, 16)
                            
                            // 제철 시세
//                            FoodPriceView(foodPrice: HomeViewDummyData.dummySeasonalPrice)
                            
                        }
                    }
                    .scrollDisabled(true)
                }
//                if enabledQuiz, !enabledAnswer {
//                    WeeklyFoodQuizView(enabledQuiz: $enabledQuiz, enabledAnswer: $enabledAnswer)
//                } else if enabledQuiz, enabledAnswer {
//                    WeeklyFoodAnswerView(enabledQuiz: $enabledQuiz)
//                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .homeView:
                    HomeView()
                case .detailView:
                    if #available(iOS 18.0, *) {
                        FoodDetailPageView(foodId: 1)
                    } else {
                        // Fallback on earlier versions
                    }
                case .placeSearch:
                    PlaceSearchView()
                case .record:
                    FoodRecordWriteView()
                case .recipe:
                    FoodRecipeWriteView()
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
                    MVPMyPageView()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .environmentObject(navigationManager)
    }
}

#Preview {
    HomeView()
}
