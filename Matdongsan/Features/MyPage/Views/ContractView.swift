//
//  ContractView.swift
//  Matdongsan
//
//  Created by sujeong on 10/28/25.
//

import SwiftUI

struct ContractView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                
                Text("맛동산 서비스 이용약관")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.mdGray90)
                    .padding(.bottom, 8)
                
                Group {
                    
                    // 제1장
                    sectionTitle("제1장 총칙")
                    articleTitle("제1조 (목적)")
                    bodyText("본 약관은 맛동산(이하 \"회사\")이 운영하는 온라인 플랫폼 및 커뮤니티 서비스(이하 \"서비스\")를 이용함에 있어, 회사와 이용자의 권리, 의무 및 책임 사항을 규정함을 목적으로 합니다.")
                    
                    articleTitle("제2조 (용어의 정의)")
                    bodyText("""
1. 서비스: 회사가 제공하는 제철 음식 정보 큐레이션, 레시피 및 장소 등 공유 커뮤니티 및 관련 부가 서비스를 의미합니다.
2. 이용자: 본 약관에 따라 회사가 제공하는 서비스를 이용하는 회원 및 비회원을 말합니다.
3. 회원: 회사에 개인정보를 제공하여 회원 등록을 한 자로서, 회사의 정보를 지속적으로 제공받으며 서비스를 계속적으로 이용할 수 있는 자를 말합니다.
4. 게시물: 회원이 서비스를 이용함에 있어 서비스상에 게시한 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다.
""")
                    
                    articleTitle("제3조 (약관의 명시와 개정)")
                    bodyText("""
1. 회사는 본 약관의 내용을 이용자가 쉽게 알 수 있도록 서비스 초기 화면에 게시합니다.
2. 회사는 관련 법령을 위배하지 않는 범위에서 본 약관을 개정할 수 있으며, 개정 시 적용 일자 및 개정 사유를 명시하여 현행 약관과 함께 서비스 내에 공지합니다.
""")
                    
                    // 제2장
                    sectionTitle("제2장 서비스 이용 계약")
                    
                    articleTitle("제4조 (이용계약의 성립)")
                    bodyText("이용계약은 회원이 되고자 하는 자가 약관의 내용에 대하여 동의를 하고 회원가입 신청을 한 후, 회사가 이러한 신청에 대하여 승낙함으로써 체결됩니다.")
                    
                    articleTitle("제5조 (회원가입 및 승낙)")
                    bodyText("""
1. 이용자는 회사가 정한 가입 양식에 따라 회원정보를 기입한 후 본 약관에 동의한다는 의사표시를 함으로써 회원가입을 신청합니다.
2. 회사는 다음 각 호에 해당하는 신청에 대하여는 승낙을 하지 않거나 사후에 이용계약을 해지할 수 있습니다.
- 실명이 아니거나 타인의 명의를 이용한 경우
- 허위의 정보를 기재하거나 회사가 제시하는 내용을 기재하지 않은 경우
- 사회의 안녕질서 혹은 미풍양속을 저해할 목적으로 신청한 경우
""")
                    
                    // 제3장
                    sectionTitle("제3장 서비스 이용 및 저작권")
                    
                    articleTitle("제6조 (서비스의 내용)")
                    bodyText("""
1. 주간 제철 식재료 정보 및 큐레이션 콘텐츠 제공
2. 이용자 간 제철 요리 레시피 및 팁 공유 커뮤니티 운영
3. 제철 음식 관련 이벤트 및 부가 서비스
""")
                    
                    articleTitle("제7조 (게시물의 저작권 및 관리)")
                    bodyText("""
1. 회원이 서비스 내에 게시한 게시물의 저작권은 해당 게시물의 저작자에게 귀속됩니다.
2. 회원은 회사가 서비스의 운영, 전시, 전송, 배포 및 홍보(맛동산 공식 SNS, 뉴스레터 등)를 목적으로 본인의 게시물을 무상으로 사용하는 것을 허락합니다.
3. 회원은 서비스 내 게시물이 타인의 저작권을 침해하지 않도록 주의하여야 하며, 제3자의 저작권 침해로 인한 책임은 회원 본인에게 있습니다.
""")
                    
                    articleTitle("제8조 (게시물의 삭제)")
                    bodyText("""
회사는 다음 각 호에 해당하는 게시물의 경우 사전 통지 없이 삭제하거나 이동, 등록 거부를 할 수 있습니다.
- 타인을 비방하거나 명예를 훼손하는 내용인 경우
- 공공질서 및 미풍양속에 위반되는 내용인 경우
- 상업적인 광고성 게시물인 경우
- 저작권 등 제3자의 권리를 침해하는 내용인 경우
""")
                    
                    // 제4장
                    sectionTitle("제4장 계약 당사자의 의무")
                    
                    articleTitle("제9조 (회사의 의무)")
                    bodyText("""
1. 회사는 관련 법령과 본 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 지속적이고 안정적으로 서비스를 제공하기 위하여 최선을 다합니다.
2. 회사는 회원의 개인정보 보호를 위해 보안 시스템을 구축하며, 개인정보 처리방침을 준수합니다.
""")
                    
                    articleTitle("제10조 (회원의 의무)")
                    bodyText("""
1. 신청 또는 변경 시 허위 내용의 등록
2. 타인의 정보 도용
3. 회사가 게시한 정보의 변경
4. 회사 및 기타 제3자의 명의 도용이나 저작권 등 지적재산권에 대한 침해
5. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 서비스에 공개 또는 게시하는 행위
""")
                    
                    // 제5장
                    sectionTitle("제5장 기타")
                    
                    articleTitle("제11조 (이용제한 및 해지)")
                    bodyText("""
1. 회원은 언제든지 서비스 내 마이페이지 등을 통해 이용계약 해지 신청(탈퇴)을 할 수 있습니다.
2. 회사는 회원이 본 약관의 의무를 위반하거나 서비스의 정상적인 운영을 방해하는 경우, 경고, 일시정지, 영구이용정지 등으로 서비스 이용을 단계적으로 제한할 수 있습니다.
""")
                    
                    articleTitle("제12조 (면책조항)")
                    bodyText("""
1. 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.
2. 회사는 회원의 귀책사유로 인한 서비스 이용의 장애에 대하여는 책임을 지지 않습니다.
3. 회사는 회원이 서비스와 관련하여 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임을 지지 않습니다.
""")
                    
                    articleTitle("제13조 (준거법 및 재판관할)")
                    bodyText("""
1. 회사와 회원 간 제기된 소송은 대한민국법을 준거법으로 합니다.
2. 회사와 회원간 발생한 분쟁에 관한 소송은 민사소송법 상의 관할법원에 제기합니다.
""")
                    
                    Text("부칙\n본 약관은 2026년 2월 1일부터 적용됩니다.")
                        .font(.system(size: 13))
                        .foregroundColor(.mdGray80)
                        .padding(.top, 8)
                }
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
