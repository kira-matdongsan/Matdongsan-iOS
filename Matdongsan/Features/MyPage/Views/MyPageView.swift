//
//  MyPageView.swift
//  Matdongsan
//
//  Created by sujeong on 2/5/25.
//

import SwiftUI

struct MyPageView: View {
    @State private var favoriteFoods: [Food] = [
        Food(name: "사과", month: 1),
        Food(name: "딸기", month: 5),
        Food(name: "바나나", month: 1),
        Food(name: "포도", month: 5),
        Food(name: "천혜향", month: 1),
        Food(name: "금귤", month: 5)]
    private let settings:[String] = ["공지사항", "이용약관", "앱 정보", "오픈소스"]
    private let accountMenu:[String] = ["로그아웃", "회원탈퇴"]
    
    var body: some View {
        VStack {
            // 프로필 부분
            VStack {
                Button {
                    
                } label: {
                    Image(systemName: "gearshape.fill")
                        .tint(.black)
                }
                .padding(.leading, 320)
                .padding(.bottom, 10)
                //--//
                HStack {
                    Image("human_img")
                        .resizable()
                        .frame(width: 48, height: 48)
                    Text("nickname")
                        .bold()
                    Spacer()
                    Button {
                        // TODO
                    } label: {
                        Text("프로필 설정")
                            .font(.callout)
                            .fontWeight(.medium)
                            .tint(.mdCoolgray80)
                            .padding(5)
                            .background(.mdCoolgray10)
                            .cornerRadius(4)
                    }
                }
                .padding(.horizontal, 20)
                //--//
                VStack(alignment:.leading){
                    Text("나만의 제철음식")
                        .foregroundStyle(.white)
                        .bold()
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(favoriteFoods, id: \.self) {
                                Text($0.name)
                                    .frame(width: 80, height: 80)
                                    .background(.mdSkyBlue10)
                                    .cornerRadius(22)
                            }
                            .padding(.horizontal, 3)
                        }
                    }
                }
                .padding(.leading,10)
                .padding(.vertical,10)
                .background(.mdSkyBlue50)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                //--//
                HStack{
                    VStack(alignment:.leading){
                        Button {
                            // TODO
                        } label: {
                            Image("human_img")
                                .resizable()
                                .frame(width: 28, height: 28)
                            Text("나의 포스팅")
                        }
                        .padding(10)
                        
                        Button {
                            // TODO
                        } label: {
                            Image("human_img")
                                .resizable()
                                .frame(width: 28, height: 28)
                            Text("나의 댓글")
                        }
                        .padding(10)
                    }
                    Spacer()
                    VStack(alignment:.leading){
                        Button {
                            // TODO
                        } label: {
                            Image("human_img")
                                .resizable()
                                .frame(width: 28, height: 28)
                            Text("출석체크")
                        }
                        .padding(10)

                        Button {
                            // TODO
                        } label: {
                            Image("human_img")
                                .resizable()
                                .frame(width: 28, height: 28)
                            Text("즐겨찾기")
                        }
                        .padding(10)
                    }
                    .padding(.trailing, 40)
                }
                .tint(.mdCoolgray80)
                .bold()
                .padding(.horizontal,20)
            }
            
            // 환경설정
            List {
                Section {
                    ForEach(settings, id: \.self) { item in
                        NavigationLink(destination: FoodSelectionJoinView()){
                            Text(item)
                        }
                    }
                }
                .listRowSeparator(.hidden)
                Section {
                    ForEach(accountMenu, id: \.self) { item in
                        NavigationLink(destination: FoodSelectionJoinView()){
                            Text(item)
                        }
                        .accentColor(Color.black) // 왜 안먹는지;
                    }
                }
                .listRowSeparator(.hidden)
            }
            .bold()
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    MyPageView()
}
