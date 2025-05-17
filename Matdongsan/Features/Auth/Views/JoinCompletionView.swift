//
//  JoinCompletionView.swift
//  Matdongsan
//
//  Created by sujeong on 1/9/25.
//

import SwiftUI

struct JoinCompletionView: View {
    @State private var nickname: String = "nickname"
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.2)
            VStack{
                VStack{
                    Image("joinCompletion")
                    Text("회원가입이\n완료되었습니다.")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .lineLimit(2, reservesSpace: true)
                        .padding(.bottom,10)
                        
                    HStack{
                        Text("이메일가입")
                            .padding(5)
                            .background(.mdCoolgray20)
                            .cornerRadius(4)
                        Text("abc123@gmail.com")
                            .tint(.mdCoolgray80)
                    }
                    .font(.footnote)
                    .padding(5)
                    .background(.mdCoolgray10)
                    .cornerRadius(8)
                    .padding(.bottom,25)
                    
                    VStack{
                        ZStack{
                            ZStack{
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 105, height: 105)
                                Image("human_img")
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
                            .padding(.bottom, 90)
                            .padding(.leading, 80)
                        }
                        HStack{
                            Text(nickname)
                                .fontWeight(.semibold)
                            Button {
                                // TODO
                            } label: {
                                Image("edit_icon")
                            }
                        }
                    }
                    .padding(.horizontal, 90)
                    .padding(.vertical, 15)
                    .background(.mdCoolgray10)
                    .cornerRadius(16)

                }
                .padding(16)
                .background(.white)
                .cornerRadius(18)
                .padding(.vertical, 160) // temp
                
                
                HStack{
                    Button {
                        // TODO
                    } label: {
                        Text("나중에 하기")
                            .frame(maxWidth: .infinity, maxHeight: 52)
                    }
                    .foregroundColor(.white)
                    .bold()
                    .background(.mdCoolgray30)
                    .cornerRadius(12)
                    
                    Button {
                        // TODO
                    } label: {
                        Text("수정하기")
                            .frame(maxWidth: .infinity, maxHeight: 52)
                    }
                    .foregroundColor(.white)
                    .bold()
                    .background(.mdCoolgray90)
                    .cornerRadius(12)
                }
                .padding(.horizontal, 20)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    JoinCompletionView()
}
