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
                Image("맛동산 아이콘")
                    .padding(40)
                    .background(.gray)
                    .cornerRadius(20)
                
                Text("Text")
                    .padding(32)
                
                Button {
                    // action
                } label: {
                    Text("이메일 회원가입")
                }
                .bold()
                .frame(width: 250, height: 52)
                .background(.black)
                .cornerRadius(15)
                .foregroundColor(.white)
                .padding(.bottom, 18)
        
                
                Button {
                    // action
                } label: {
                    Image("맛동산 아이콘")
                        .resizable()
                        .frame(width: 28, height: 28)
                    Text("네이버 회원가입")
                }
                .bold()
                .frame(width: 250, height: 52)
                .background(.black)
                .cornerRadius(15)
                .foregroundColor(.white)
                .padding(.bottom, 18)

                
                Button {
                    // action
                } label: {
                    Image("맛동산 아이콘")
                        .resizable()
                        .frame(width: 28, height: 28)
                    Text("카카오 회원가입")
                }
                .bold()
                .frame(width: 250, height: 52)
                .background(.black)
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
