//
//  MyPageEditView.swift
//  Matdongsan
//
//  Created by sujeong on 10/21/25.
//

import SwiftUI

struct ProfileSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authManager: AuthManager
    @StateObject private var viewModel: MyPageViewModel = MyPageViewModel()
    
    @State var nickname: String = ""
    var profileImage: Image? = Image(systemName: "person.fill")
    var isCompletable:Bool {
        nickname != viewModel.nickname
    }
    @FocusState var isFocused:Bool

    var body: some View {
        VStack(spacing: 24) {
            // 프로필 이미지 섹션
            VStack(spacing: 4) {
                Image("dongsan-profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .clipShape(Circle())
                
//                Image("edit_icon_2")
//                    .resizable()
//                    .frame(width: 18, height: 18)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 5, y: 2)
            .padding(.horizontal, 24)
            .padding(.top, 24)
            
            VStack (spacing: 8) {
                // 이메일 입력 (비활성화)
                let type = viewModel.loginType
                VStack(alignment: .leading, spacing: 8) {
                    Text("이메일")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.mdCoolgray90)
                    
                    if type == 0 {
                        TextField("", text: .constant(viewModel.myPage?.email ?? ""))
                            .foregroundStyle(.mdCoolgray60)
                            .font(.system(size: 13, weight: .light))
                            .disabled(true)
                            .padding()
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.mdCoolgray10))
                            )
                    } else if type == 1 {
                        HStack (spacing: 16) {
                            Image("naver-small")
                                .resizable()
                                .frame(width: 28, height: 28)
                            Text("네이버 로그인")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.mdCoolgray90)
                            Spacer()
                        }
                    } else {
                        HStack (spacing: 16) {
                            Image("kakao-small")
                                .resizable()
                                .frame(width: 28, height: 28)
                            Text("카카오 로그인")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.mdCoolgray90)
                            Spacer()
                        }
                    }
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                // 닉네임 입력
                VStack(alignment: .leading, spacing: 8) {
                    Text("닉네임")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.mdCoolgray90)
                    TextField("닉네임을 입력하세요", text: $nickname)
                        .foregroundStyle(.mdCoolgray90)
                        .font(.system(size: 13, weight: .semibold))
                        .padding()
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.mdCoolgray10))
                        )
                        .focused($isFocused)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .padding(.horizontal, 24)
            
            VStack (spacing: 16) {
                // 하단 구분선
                Rectangle()
                    .fill(.mdCoolgray10)
                    .frame(height: 1)
                    .padding(.horizontal, 24)
                
                // 로그아웃 / 회원탈퇴
                HStack(spacing: 8) {
                    Button(action: {
                        // 로그아웃 액션
                        authManager.logout()
                        dismiss()
                    }) {
                        Text("로그아웃")
                    }
//                    Text("|")
//                    Button(action: {
//                        // 회원탈퇴 액션
//                    }) {
//                        Text("회원탈퇴")
//                    }
                }
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.mdGray30)
            }
            
            Spacer()
            // 저장하기 버튼
            Button(action: {
                Task {
                    await viewModel.changeNickname(nickname: nickname)
                    dismiss()
                }
            }) {
                Text("저장하기")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isCompletable ? .mdSkyBlue50 : .mdCoolgray20)
                    .foregroundStyle(isCompletable ? .white : .mdCoolgray60)
                    .cornerRadius(8)
                    .padding(.horizontal, 15)
            }
            .disabled(!isCompletable)
            .padding(.bottom, 24)
        }
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("프로필 설정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button ("닫기") {
                    isFocused = false
                }
            }
        }
        .task {
            await viewModel.loadMyPage()
            nickname = viewModel.nickname
        }
    }
}

#Preview {
    ProfileSettingView()
}

