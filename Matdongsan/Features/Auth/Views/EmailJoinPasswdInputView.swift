//
//  EmailJoinEmailInputView.swift
//  Matdongsan
//
//  Created by sujeong on 12/26/24.
//

import SwiftUI

struct EmailJoinPasswdInputView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var passwd = ""
    @State private var isvalid = true // true, false 분기 처리
    
    var body: some View {
        VStack {
            HStack{
                Text("비밀번호를 입력해주세요")
                    .fontWeight(.semibold)
                    .foregroundStyle(.mdGray90)
                    .font(.title2)
                    .padding(.vertical, 20)
                    .frame(alignment: .leading)
                Spacer()
            }
            
            TextField("비밀번호 (영문+숫자+특수문자 8자 이상)", text: $passwd)
                .frame(height: 48)
                .padding(.leading, 24.0)
                .background(.mdCoolgray10)
                .cornerRadius(8)
                .overlay(content: {
                    if isvalid {
                        RoundedRectangle(cornerRadius: 8).stroke(Color.mdCyan40)
                    } else {
                        RoundedRectangle(cornerRadius: 8).stroke(Color.mdRed)
                    }
                })
                .padding(.bottom, 10)
                
            
            HStack {
                if isvalid {
                    Text("가입 가능한 비밀번호입니다.")
                        .font(.footnote)
                        .foregroundColor(.mdCyan40)
                } else {
                    Text("영문, 숫자, 특수문자를 조합한 8자 이상, 20자 이하의 비밀번호 를 입력해주세요.")
                        .font(.footnote)
                        .foregroundColor(.mdRed)
                }
                Spacer()
            }
            
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
        .padding(.horizontal, 30)
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
    EmailJoinPasswdInputView()
}
