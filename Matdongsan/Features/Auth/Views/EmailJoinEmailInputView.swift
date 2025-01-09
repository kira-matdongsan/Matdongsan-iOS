//
//  EmailJoinEmailInputView.swift
//  Matdongsan
//
//  Created by sujeong on 12/26/24.
//

import SwiftUI

struct EmailJoinEmailInputView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var isfailed = true // true, false 분기 처리
    
    var body: some View {
        VStack {
            HStack{
                Text("이메일을 입력해주세요")
                    .fontWeight(.semibold)
                    .foregroundStyle(.mdGray90)
                    .font(.title2)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .frame(alignment: .leading)
                Spacer()
            }
            
            TextField("이메일", text: $email)
                .frame(height: 48)
                .padding(.leading, 24.0)
                .background(.mdCoolgray10)
                .cornerRadius(8)
                .overlay(content: {
                    if isfailed {
                        RoundedRectangle(cornerRadius: 8).stroke(Color.mdRed)
                    } else {
                        RoundedRectangle(cornerRadius: 8).stroke(Color.mdCyan40)
                    }
                })
                .padding(.horizontal,20)
                .padding(.bottom, 10)
                
            
            HStack {
                if isfailed {
                    Text("올바른 이메일을 입력해주세요.")
                        .font(.footnote)
                        .foregroundColor(.mdRed)
                } else {
                    Text("가입 가능한 이메일입니다.")
                        .font(.footnote)
                        .foregroundColor(.mdCyan40)
                }
                Spacer()
            }
            .padding(.leading, 20)
            
            Spacer()
            
            Button {
                // action
            } label: {
                Text("다음")
            }
            .bold()
            .frame(width: 360, height: 50)
            .background(.mdCoolgray80)
            .cornerRadius(15)
            .foregroundColor(.white)
            .padding(.bottom, 18)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem (placement: .topBarLeading) {
                Button {
                    // TODO
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .tint(.mdCoolgray80)
                .padding(10)

            }
        })
    }
}

#Preview {
    EmailJoinEmailInputView()
}
