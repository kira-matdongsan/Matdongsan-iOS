//
//  StoryCreateSheetView.swift
//  Matdongsan
//
//  Created by sujeong on 3/8/26.
//

import SwiftUI

struct StoryCreateSheetView: View {
    @EnvironmentObject var navigationManager:NavigationManager
    
    @Binding var showStorySheet: Bool
    
    var foodName: String = ""
    var foodEngName: String = ""
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.mdCoolgray30)
                .frame(width: 40, height: 4)
                .cornerRadius(3)
                .padding(.bottom, 18)
                .padding(.top, 16)
            HStack {
                Text("제철음식 이야기")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
                Button {
                    showStorySheet = false
                } label: {
                    Image("close-circle")
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 24)
            
            Button {
                showStorySheet = false
                navigationManager.navigate(to: AppRoute.recipe(foodName: foodName, foodEngName: foodEngName))
            } label: {
                HStack (spacing: 10) {
                    Image("recipe-icon")
                        .resizable()
                        .frame(width: 48, height: 48)
                    VStack (alignment:.leading, spacing: 4) {
                        Text("레시피")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.mdGray90)
                        Text("제철음식으로 만드는 나만의 레시피")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.mdGray60)
                    }
                    Spacer()
                }
                .padding(4)
            }
            
            Divider()
            
            Button {
                showStorySheet = false
                navigationManager.navigate(to: AppRoute.record(foodName: foodName, foodEngName: foodEngName))
            } label: {
                HStack (spacing: 10) {
                    Image("record-icon")
                        .resizable()
                        .frame(width: 48, height: 48)
                    VStack (alignment:.leading, spacing: 4) {
                        Text("제철기록")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.mdGray90)
                        Text("기록하고 싶은 나만의 제철음식 이야기")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.mdGray60)
                    }
                    Spacer()
                }
                .padding(4)
            }
            
//                    Divider()
//
//                    Button {
//                        showStorySheet = false
//                        navigationManager.navigate(to: AppRoute.place)
//                    } label: {
//                        HStack (spacing: 10) {
//                            Image("place-icon")
//                                .resizable()
//                                .frame(width: 48, height: 48)
//                            VStack (alignment:.leading, spacing: 4) {
//                                Text("플레이스")
//                                    .font(.system(size: 16, weight: .bold))
//                                    .foregroundStyle(.mdGray90)
//                                Text("제철음식을 맛볼 수 있는 공간 소개")
//                                    .font(.system(size: 14, weight: .regular))
//                                    .foregroundStyle(.mdGray60)
//                            }
//                            Spacer()
//                        }
//                        .padding(4)
//                    }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .presentationDetents([.height(250)])
        .presentationCornerRadius(32)
    }
}

#Preview {
    StoryCreateSheetView(showStorySheet: .constant(true))
}
