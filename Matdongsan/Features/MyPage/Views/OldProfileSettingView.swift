//
//  ProfileSettingView.swift
//  Matdongsan
//
//  Created by sujeong on 2/7/25.
//

import SwiftUI

struct OldProfileSettingView: View {
    
    @ObservedObject private var profileSettingViewModel: ProfileSettingViewModel
    
    init() {
        self.profileSettingViewModel = ProfileSettingViewModel()
        self.profileSettingViewModel.getUserProfile()
    }
    
    var body: some View {
        ZStack{
            Color(.mdCoolgray10)
            
            VStack {
                Text("프로필 설정")
                    .font(.headline)
                    .bold()
                    .tint(.mdCoolgray70)
                    .padding(.top, 50) //temp
                // --- //
                VStack{
                    ZStack{
                        ZStack{
                            Circle()
                                .fill(Color.white)
                                .frame(width: 105, height: 105)
                            Image("human_gray")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 110, height: 110)
                        }
                        Button {
                            // TODO
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .tint(.mdCoolgray90)
                        }
                        .frame(width: 24, height: 24)
                        .padding(.bottom, 80)
                        .padding(.leading, 80)
                    }
                    HStack{
                        Text(self.profileSettingViewModel.nickname)
                            .fontWeight(.medium)
                        Button {
                            // TODO
                        } label: {
                            Image("edit_icon_2")
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width-40)// TODO safeArea 기준으로 간격 떼는법 찾아보기
                .padding(.vertical, 15)
                .background(.white)
                .cornerRadius(16)
                .padding(.vertical, 10)

                
                //--//
                Button {
                    
                } label: {
                    HStack {
                        Text("로그인 정보")
                            .fontWeight(.regular)
                        Spacer()
                        Text(self.profileSettingViewModel.email)
                            .tint(.mdSkyBlue50)
                        Image(systemName: "chevron.right")
                    }
                    .tint(.mdCoolgray90)
                }
                .padding(.horizontal, 20)
                .frame(width: UIScreen.main.bounds.size.width-40)
                .padding(.vertical, 15)
                .background(.white)
                .cornerRadius(16)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(20)
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OldProfileSettingView()
}
