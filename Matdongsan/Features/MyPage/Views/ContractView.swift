//
//  ContractView.swift
//  Matdongsan
//
//  Created by sujeong on 10/28/25.
//

import SwiftUI

struct ContractView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("이용약관")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.mdGray90)
                    .padding(.bottom, 8)
                
                bodyText("""
약관은 여러분이 맛동산을 이용할 때 지켜야 할 내용과 서비스 이용에 대한 기본적인 사항을 담고 있습니다.
""")
                
                // 제1조
                articleTitle("제1조 (목적)")
                bodyText("""
이 약관은 맛동산 서비스 이용과 관련하여, 맛동산 사용자(이하 ‘회원')과 맛동산 운영자(이하 ‘운영자’)의 권리, 의무 및 책임사항 등을 규정합니다.
""")
                
                // 제2조
                articleTitle("제2조 (서비스 내용)")
                bodyText("""
맛동산은 제철음식에 대한 정보 제공, 이야기 나눔, 투표 등의 커뮤니티 서비스를 제공합니다.
""")
                
                // 제3조
                articleTitle("제3조 (회원가입과 계정)")
                bodyText("""
회원가입 시 정확한 정보를 입력해야 합니다. 다른 사람의 명의로 가입할 수 없습니다.

회원은 언제든지 탈퇴할 수 있으며, 탈퇴 시 개인정보는 관련 법에 따라 처리됩니다.
""")
                
                // 제4조
                articleTitle("제4조 (개인정보 보호)")
                bodyText("""
운영자는 서비스 제공을 위해 필요한 최소한의 개인정보를 수집하며, 개인정보는 별도의 ‘개인정보처리방침’에 따라 안전하게 보호됩니다.
""")
                
                // 제5조
                articleTitle("제5조 (회원의 의무)")
                bodyText("""
회원은 다음과 같은 행동을 해서는 안 됩니다.

1. 타인을 비방하거나 욕설을 하는 행위
2. 타인에게 불쾌감을 주는 혐오 표현, 차별적 발언, 괴롭힘을 포함한 콘텐츠 게시
3. 불법 정보 또는 음란물 게시
4. 스팸성 게시물 작성
5. 타인의 권리를 침해하는 행위

운영자는 위반 게시물을 삭제하거나 서비스 이용을 제한할 수 있습니다. 맛동산은 부적절한 콘텐츠나 악성 사용자에 대해 무관용 원칙을 적용합니다.
""")
                
                // 제6조
                articleTitle("제6조 (콘텐츠의 저작권)")
                bodyText("""
회원이 작성한 글, 사진 등의 콘텐츠는 회원 본인에게 저작권이 있습니다.

다만, 운영자는 서비스 운영 및 홍보 등을 위해 콘텐츠를 사용할 수 있습니다.

게시글이 타인의 저작권을 침해할 경우, 그 책임은 작성한 회원에게 있습니다.
""")
                
                // 제7조
                articleTitle("제7조 (서비스 이용의 제한 및 중단)")
                bodyText("""
운영자는 아래의 경우 서비스 제공을 일시적으로 제한하거나 중단할 수 있습니다.

1. 서버 점검이나 장애 발생
2. 천재지변 등 불가항력 사유
3. 기타 운영자가 필요하다고 판단하는 경우

운영자는 신고된 부적절한 콘텐츠를 접수 후 24시간 이내에 검토 및 삭제 조치합니다.

가이드라인을 위반하여 부적절한 콘텐츠를 반복적으로 게시하는 사용자는 즉시 서비스 이용이 중단되거나 계정이 영구적으로 삭제될 수 있습니다.
""")
                
                // 제8조
                articleTitle("제8조 (책임의 한계)")
                bodyText("""
운영자는 서비스 내 콘텐츠의 정확성이나 신뢰성을 보장하지 않습니다.

회원 간의 분쟁이나 거래는 당사자끼리 해결해야 합니다.
""")
                
                // 제9조
                articleTitle("제9조 (사용자 생성 콘텐츠 관리 및 사용자 보호)")
                bodyText("""
회원은 부적절한 콘텐츠나 회원을 발견할 경우, 앱 내 제공되는 '게시물 신고' 및 '사용자 차단' 기능을 통해 즉시 대응할 수 있습니다.

차단된 사용자의 콘텐츠는 차단한 사용자의 피드에서 즉시 제거됩니다.
""")
                
                // 제10조
                articleTitle("제10조 (약관 변경)")
                bodyText("""
운영자는 필요한 경우 약관을 변경할 수 있으며, 변경 시 서비스 내 공지를 통해 안내합니다.

변경된 약관에 동의하지 않을 경우, 회원은 서비스 이용을 중단하고 탈퇴할 수 있습니다.
""")
                
                // 제11조
                articleTitle("제11조 (준거법 및 분쟁 해결)")
                bodyText("""
이 약관은 대한민국 법에 따라 해석되며, 서비스 이용과 관련된 분쟁은 운영자의 소재지를 관할하는 법원을 통해 해결합니다.
""")
                
                articleTitle("부칙")
                bodyText("""
이 약관은 2026년 3월 3일부터 시행됩니다.
""")
            }
            .padding()
            .background(.mdGray10)
            .cornerRadius(8)
            .padding(.horizontal, 15)
            .padding(.vertical, 15)
        }
        .background(Color.white)
        .navigationTitle("이용약관")
        .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - Components

func articleTitle(_ text: String) -> some View {
    Text(text)
        .font(.system(size: 15, weight: .bold))
        .foregroundColor(.mdGray90)
        .padding(.top, 8)
}

func bodyText(_ text: String) -> some View {
    Text(text)
        .font(.system(size: 14))
        .foregroundColor(.mdGray70)
        .lineSpacing(4)
}
