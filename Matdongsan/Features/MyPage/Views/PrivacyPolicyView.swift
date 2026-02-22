//
//  PrivacyPolicyView.swift
//  Matdongsan
//
//  Created by sujeong on 2/22/26.
//


import SwiftUI

struct PrivacyPolicyView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                
                Text("개인정보처리방침")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.mdGray90)
                    .padding(.bottom, 8)
                
                bodyText("""
맛동산(이하 "회사")은 정보 주체의 자유와 권리 보호를 위해 「개인정보보호법」 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. 이에 「개인정보보호법」 제30조에 따라 정보주체의 개인정보 처리와 보호에 관한 절차 및 기준을 안내하고, 관련 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보처리 방침을 수립·공개합니다.
""")
                
                // 제1조
                articleTitle("제1조 개인정보의 수집 및 이용 목적")
                bodyText("""
회사는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.

• 회원 가입 및 관리 : 회원 식별, 가입 의사 확인, 불량 회원 부정 이용 방지, 각종 고지·통지  
• 서비스 제공 : 제철 음식 정보 제공(큐레이션), 커뮤니티 게시판 이용  
• 마케팅 및 광고(선택) : 신규 서비스 안내, 제철 음식 관련 이벤트 정보 및 참여 기회 제공
""")
                
                // 제2조
                articleTitle("제2조 수집하는 개인정보 항목 및 수집방법")
                bodyText("""
회사는 서비스 제공을 위해 필요한 최소한의 개인정보를 수집합니다.

[필수 항목]  
- 수집 목적 : 회원 식별 및 서비스 이용  
- 수집 항목 : 이메일 주소(아이디), 비밀번호, 닉네임  
- 수집 방법 : 회원가입  

[선택 항목]  
- 수집 목적 : 프로필 설정 및 콘텐츠 게시  
- 수집 항목 : 프로필 사진, 지역정보  
- 수집 방법 : 프로필 설정 및 커뮤니티 이용  

[자동 수집]  
- 수집 목적 : 서비스 최적화 및 부정 이용 방지  
- 수집 항목 : IP 주소, 쿠키, 서비스 이용 기록, 기기 정보  
- 수집 방법 : 서비스 이용
""")
                
                // 제3조
                articleTitle("제3조 개인정보의 보유 및 이용 기간")
                bodyText("""
1. 회사는 이용자로부터 개인정보를 수집 시에 동의받은 보유·이용 기간 내에서 개인정보를 처리합니다.
2. 원칙적으로 회원 탈퇴 시 즉시 파기합니다. 단, 관련 법령 및 내부 방침에 따라 일정 기간 보관이 필요한 경우는 다음과 같습니다.

◦ 서비스 부정 이용 기록 : 탈퇴 후 6개월간 보관  
◦ 전자상거래 등에서의 소비자 보호에 관한 법률  
- 계약 또는 청약철회 등에 관한 기록 : 5년  
- 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
""")
                
                // 제4조
                articleTitle("제4조 개인정보의 파기 절차 및 방법")
                bodyText("""
회사는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체 없이 해당 개인정보를 파기합니다. 전자적 파일 형태는 복구 및 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.
""")
                
                // 제5조
                articleTitle("제5조 이용자의 권리·의무 및 그 행사방법")
                bodyText("""
1. 이용자는 언제든지 등록되어 있는 자신의 개인정보를 조회하거나 수정할 수 있으며, 가입 해지(동의 철회)를 요청할 수 있습니다.
2. 이용자가 개인정보의 오류에 대한 정정을 요청한 경우에는 정정을 완료하기 전까지 해당 개인정보를 이용 또는 제공하지 않습니다.
""")
                
                // 제6조
                articleTitle("제6조 개인정보의 안전성 확보 조치")
                bodyText("""
회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.

• 해킹 등에 대비한 기술적 대책 : 비밀번호 암호화 저장, 백신 프로그램 이용  
• 개인정보 취급 직원의 최소화 및 교육 : 개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 관리
""")
                
                // 제7조
                articleTitle("제7조 개인정보 보호책임자 및 상담 신고")
                bodyText("""
회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 이용자의 불만 처리 및 피해 구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.

• 개인정보 보호책임자 : 송예나  
• 문의처 : matdongsan.official@gmail.com
""")
                
                // 제8조
                articleTitle("제8조 권익침해 구제방법")
                bodyText("""
정보주체는 개인정보침해로 인한 구제를 받기 위하여 아래 기관에 분쟁 해결이나 상담 등을 신청할 수 있습니다.

- 개인정보분쟁조정위원회 : (국번없이) 1833-6972  
- 개인정보침해신고센터 : (국번없이) 118  
- 대검찰청 사이버수사과 : (국번없이) 1301  
- 경찰청 사이버수사국
""")
                
                bodyText("""
본 개인정보처리방침은 정부 정책 또는 보안 기술의 변경 등에 따라 내용의 추가, 삭제 및 수정이 있을 경우 지체 없이 서비스에 고지합니다.
""")
            }
            .padding()
            .background(.mdGray10)
            .cornerRadius(8)
            .padding(.horizontal, 15)
            .padding(.vertical, 15)
        }
        .background(Color.white)
        .navigationTitle("개인정보처리방침")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Styling Helpers

private func sectionTitle(_ text: String) -> some View {
    Text(text)
        .font(.system(size: 15, weight: .bold))
        .foregroundColor(.mdGray90)
        .padding(.top, 10)
}

private func articleTitle(_ text: String) -> some View {
    Text(text)
        .font(.system(size: 14, weight: .semibold))
        .foregroundColor(.mdGray90)
        .padding(.top, 6)
}

private func bodyText(_ text: String) -> some View {
    Text(text)
        .font(.system(size: 13))
        .foregroundColor(.mdGray80)
}
