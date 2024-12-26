//
//  JoinView.swift
//  Matdongsan
//
//  Created by sujeong on 12/20/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(.맛동산아이콘)
                    .padding(40)
                    .background(.mdCoolgray80)
                    .cornerRadius(20)
                
                Text("Text")
                    .padding(32)
                    .foregroundStyle(.mdGray90)
                
                NavigationLink(destination: EmailLoginView()){
                    Text("이메일 로그인")
                }
                .bold()
                .frame(width: 260, height: 50)
                .background(.mdCoolgray80)
                .cornerRadius(15)
                .foregroundColor(.white)
                .padding(.bottom, 18)
        
                
                Button {
                    // action
                } label: {
                    Image("naverBtn")
                        .resizable()
                        .frame(width: 28, height: 28)
                    Text("네이버 로그인")
                }
                .bold()
                .frame(width: 260, height: 50)
                .background(.mdCoolgray80)
                .cornerRadius(15)
                .foregroundColor(.white)
                .padding(.bottom, 18)

                
                Button {
                    // action
                } label: {
                    Image("kakaoBtn")
                        .resizable()
                        .frame(width: 28, height: 28)
                    Text("카카오 로그인")
                }
                .bold()
                .frame(width: 260, height: 50)
                .background(.mdCoolgray80)
                .cornerRadius(15)
                .foregroundColor(.white)
                .padding(.bottom, 48)
                
                HStack {
                    Button {
                        // TODO
                    } label: {
                        Text("비밀번호 찾기")
                    }
                    
                    Text("/")
                        .padding(-3.0)
                    
                    Button {
                        // TODO
                    } label: {
                        Text("회원가입")
                    }
                }
                .font(.callout)
                .tint(.mdGray100)
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // TODO
                    } label: {
                        Image(systemName: "chevron.backward")
                            .tint(.black)
                    }
                    .padding(10)
                }
            })
        }
    }
}

#Preview {
    LoginView()
}
