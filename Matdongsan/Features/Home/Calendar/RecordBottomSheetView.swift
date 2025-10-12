//
//  RecordBottomSheetView.swift
//  Matdongsan
//
//  Created by sujeong on 9/28/25.
//

import SwiftUI

struct RecordBottomSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @FocusState var isFocused:Bool
    @State private var selectedSticker: String? = nil
    @State private var content: String = ""
    let characterLimit:Int = 40
    var isCompletable:Bool {
        !content.isEmpty
    }
    let imgs = ["ds-face-yellow", "ds-face-blue", "ds-face-green"]
    let stickers = ["😊","🤔","😮","👍","👏",
                    "🙏","🍎","🌽","🍀","🍑","🍋"]

    var body: some View {
        VStack(spacing: 16) {
            // 드래그 인디케이터
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
            
            // 제목 + 닫기 버튼
            HStack {
                Text("제철음식 기록")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image("close-circle")
                        .frame(width: 24, height: 24)
                }
            }
            .padding(.horizontal)
            
            // 스티커 선택
            VStack(alignment: .leading, spacing: 8) {
                Text("스티커")
                    .font(.system(size: 16, weight: .semibold))
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 14), count: 7), spacing: 18) {
                    ForEach(imgs, id: \.self) { img in
                        Image(img)
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(Color.mdYellow10)
                                    .stroke(selectedSticker == img ? Color.mdYellow50 : .clear, lineWidth: 5)
                            )
                            .onTapGesture {
                                selectedSticker = img
                            }
                    }
                    ForEach(stickers, id: \.self) { sticker in
                        Text(sticker)
                            .font(.system(size: 16))
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(Color.mdYellow10)
                                    .stroke(selectedSticker == sticker ? Color.mdYellow50 : .clear, lineWidth: 5)
                            )
                            .onTapGesture {
                                selectedSticker = sticker
                            }
                    }
                }
            }
            .padding(.horizontal, 18)

            
            // 내용 입력
            VStack(alignment: .leading, spacing: 4) {
                Text("내용")
                    .font(.system(size: 16, weight: .semibold))
                
                TextField("내용을 입력해주세요. (최대 40자)", text: $content)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isFocused || !content.isEmpty ? Color.mdSkyBlue40 : Color.mdCoolgray20)
                    )
                    .font(.system(size: 13, weight: .light))
                    .foregroundStyle(.mdGray90)
                    .onChange(of: content) { _, newValue in
                        if newValue.count > characterLimit {
                            content = String(newValue.prefix(characterLimit))
                        }
                    }
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(.top, 8)
            }
            .padding(.horizontal, 18)
            
            Text("나만의 제철음식을 간단하게 기록할 수 있습니다. 캘린더에 등록된 내용은 나만 볼 수 있어요.")
                .font(.system(size: 13, weight: .light))
                .foregroundColor(.mdGray40)
                .padding(.horizontal, 16)
                .fixedSize(horizontal: false, vertical: true)
            
            // 기록하기 버튼
            Button {
                dismiss()
            } label: {
                Text("기록하기")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(isCompletable ? .white : .mdCoolgray60)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(isCompletable ? .mdSkyBlue50 : .mdCoolgray20)
                    .cornerRadius(8)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 24)
            }
            .disabled(isCompletable)
        }
    }
}


#Preview {
    RecordBottomSheetView()
        .presentationDetents([.fraction(0.7), .large])
        .presentationDragIndicator(.hidden)
}
