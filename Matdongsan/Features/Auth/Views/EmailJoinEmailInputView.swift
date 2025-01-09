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
    @State private var isvalid = true // true, false 분기 처리
    
    var body: some View {
        VStack {
            HStack{
                Text("이메일을 입력해주세요")
                    .fontWeight(.semibold)
                    .foregroundStyle(.mdGray90)
                    .font(.title2)
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
                    if isvalid {
                        RoundedRectangle(cornerRadius: 8).stroke(Color.mdCyan40)
                    } else {
                        RoundedRectangle(cornerRadius: 8).stroke(Color.mdRed)
                    }
                })
                .padding(.bottom, 10)
                
            
            HStack {
                if isvalid {
                    Text("가입 가능한 이메일입니다.")
                        .font(.footnote)
                        .foregroundColor(.mdCyan40)
                } else {
                    Text("올바른 이메일을 입력해주세요.")
                        .font(.footnote)
                        .foregroundColor(.mdRed)
                }
                Spacer()
            }
            
            Spacer()
            
            NavigationLink(destination: EmailJoinPasswdInputView()){
                Text("다음")
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .bold()
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
    EmailJoinEmailInputView()
}
