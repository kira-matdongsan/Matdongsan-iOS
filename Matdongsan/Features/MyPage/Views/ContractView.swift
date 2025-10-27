//
//  ContractView.swift
//  Matdongsan
//
//  Created by sujeong on 10/28/25.
//

import SwiftUI

struct ContractView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTerm = "이용약관명"
    
    var body: some View {
        VStack(spacing: 16) {
            
//            Divider()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(selectedTerm)
                            .font(.system(size: 14, weight: .semibold))
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Spacer()
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("맛동산 이용약관")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.mdGray90)
                            .padding(.bottom, 12)
                        
                        Group {
                            Text("약관은 여러분이 맛동산을 이용할 때 지켜야 할 내용과 서비스 이용에 대한 기본적인 사항을 담고 있습니다.\n")
                            Text("제1조 (목적)")
                            Text("이 약관은 맛동산 서비스 이용과 관련하여, 여러분과 맛동산 운영자(이하 ‘운영자’)의 권리, 의무 및 책임사항 등을 규정합니다.\n")
                            
                            Text("제2조 (서비스 내용)")
                            Text("맛동산은 제철음식에 대한 정보 제공, 이야기 나눔, 투표 등의 커뮤니티 서비스를 제공합니다.\n")
                            
                            Text("제3조 (회원가입과 계정)")
                            Text("회원은 올바르고 정확한 정보를 입력해야 합니다.\n입력한 정보가 사실과 다를 경우 이용이 제한될 수 있습니다.\n회원은 언제든지 계정을 삭제할 수 있으며, 삭제 시 개인정보는 관련 법령에 따라 처리됩니다.\n")
                            
                            Text("제4조 (개인정보 보호)")
                            Text("운영자는 서비스 제공에 필요한 최소한의 개인정보를 수집합니다.\n수집한 개인정보는 법령 및 개인정보처리방침에 따라 안전하게 관리됩니다.\n")
                            
                            Text("제5조 (회원의 의무)")
                            Text("회원은 다음 행위를 해서는 안 됩니다.\n1. 타인의 정보를 도용하거나 허위 정보를 입력하는 행위\n2. 서비스 운영을 방해하는 행위\n3. 기타 관련 법령을 위반하는 행위\n")
                        }
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.mdGray80)
                    }
                    .padding()
                    .background(.mdGray10)
                    .cornerRadius(8)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 15)
            }
        }
        .background(Color.white)
        .navigationTitle("이용약관")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContractView()
}
