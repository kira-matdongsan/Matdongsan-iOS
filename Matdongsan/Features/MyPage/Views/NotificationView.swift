//
//  NotificationView.swift
//  Matdongsan
//
//  Created by sujeong on 11/25/25.
//

import SwiftUI

struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    var discription: String?
    let date: String
    let type: Int
}

struct NotificationView: View {
    @Environment(\.dismiss) private var dismiss

    let notifications: [NotificationItem] = [
        .init(title: "내가 쓴 글을 좋아요 했어요", date: "3일 전", type: 3),
        .init(title: "이번 주 제출음식을 확인해보세요!", date: "2025.07.07", type: 2),
        .init(title: "지난 주 대표 제출요리는 ‘콘치즈’로 선정되었어요!", date: "2025.07.07", type: 2),
        .init(title: "앱 버전 업데이트 안내", discription: "프로필 변경 기능이 추가되었어요.\n‘마이페이지 > 프로필 설정’ 에서 프로필을 변경해보세요!", date: "2025.07.12", type: 1)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Navigation Header
//            HStack {
//                Button(action: {}) {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(.black)
//                }
//                Spacer()
//                Text("알림함")
//                    .font(.headline)
//                Spacer()
//                Image("setting")
//                    .resizable()
//                    .frame(width: 24, height: 24)
//            }
//            .padding()
            Divider()

            // Top info text
            Text("알림함에는 최대 30일 전의 알림만 저장됩니다.")
                .font(.system(size: 12))
                .foregroundColor(.mdCoolgray70)
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.mdCoolgray10)
                }
                .padding(24)

            
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(notifications.enumerated()), id: \.offset) { index, item in
                        HStack(alignment: .top, spacing: 12) {
                            
                            Image("noti-icon\(item.type)")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(item.title)
                                    .font(.system(size: 14))
                                    .foregroundColor(.mdGray90)
                                
                                if let disc = item.discription {
                                    Text(disc)
                                        .font(.system(size: 12, weight: .light))
                                        .foregroundColor(.mdGray60)
                                }
                                
                                Text(item.date)
                                    .font(.system(size: 11))
                                    .foregroundColor(.mdCoolgray50)
                            }
                            
                            Spacer()
                            
                            Image("arrow-circle-right")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 14)
                        
                        if index != notifications.count-1 {
                            Divider()
                        }
                    }
                }
            }
        }
        .navigationTitle("알림함")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
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
            ToolbarItem(placement: .topBarTrailing) {
                Button {
//                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("setting")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
        })
    }
}


#Preview {
    NotificationView()
}
