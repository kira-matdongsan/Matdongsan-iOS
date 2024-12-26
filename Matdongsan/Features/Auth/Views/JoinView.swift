//
//  JoinView.swift
//  Matdongsan
//
//  Created by sujeong on 12/20/24.
//

import SwiftUI

struct JoinView: View {
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
                
                NavigationLink(destination: EmailJoinEmailInputView()){
                    Text("이메일 회원가입")
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
                    Text("네이버 회원가입")
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
                    Text("카카오 회원가입")
                }
                .bold()
                .frame(width: 260, height: 50)
                .background(.mdCoolgray80)
                .cornerRadius(15)
                .foregroundColor(.white)
                .padding(.bottom, 48)
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
    JoinView()
}
