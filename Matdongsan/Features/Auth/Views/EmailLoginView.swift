//
//  JoinView.swift
//  Matdongsan
//
//  Created by sujeong on 12/20/24.
//

import SwiftUI

struct EmailLoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("로그인")
                        .fontWeight(.semibold)
                        .foregroundStyle(.mdGray90)
                        .font(.title2)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                        .frame(alignment: .leading)
                    Spacer()
                }
                
                TextField("이메일", text: $email)
                    .frame(height: 48)
                    .padding(.leading, 24.0)
                    .background(.mdCoolgray10)
                    .cornerRadius(8)
                    .padding(.horizontal,20)
                    .padding(.bottom, 16)

                ZStack {
                    TextField("비밀번호", text: $password)
                        .frame(height: 48)
                        .padding(.horizontal, 20)
                        .background(.mdCoolgray10)
                        .cornerRadius(8)
                    HStack{
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("보기")
                        }
                        .font(.footnote)
                        .tint(.mdGray90)
                        .frame(width: 48, height: 24)
                        .buttonStyle(.borderless)
                        .padding(.trailing, 20)
                    }
                }
                .padding(.horizontal,20)
                

                HStack {
                    Text("로그인에 실패했어요. 다시 시도해주세요.")
                        .font(.footnote)
                        .foregroundColor(.mdRed)

                    Spacer()
                }
                .padding(.leading, 20)
                
                Button {
                    // action
                } label: {
                    Text("로그인")
                }
                .foregroundColor(.white)
                .bold()
                .frame(width: 360, height: 52)
                .background(.mdCoolgray80)
                .cornerRadius(12)
                .padding(.bottom, 18)
                .padding(.horizontal, 20)
                .padding(.top,72)
                
                HStack{
                    Button {
                        // TODO
                    } label: {
                        Text("비밀번호 찾기")
                    }
                }
                .font(.callout)
                .tint(.mdCoolgray30)
                
                Spacer(minLength: 20)

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
    EmailLoginView()
}
