//
//  FoodPlaceWriteView.swift
//  Matdongsan
//
//  Created by sujeong on 6/20/25.
//

import SwiftUI
import PhotosUI
import Combine

struct FoodPlaceWriteView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let characterLimit:Int = 500
    let imgSelectionLimit:Int = 10
    
    var foodName:String = "옥수수"
    var foodEngName:String = "corn"
    var isCompletable:Bool {
        !content.isEmpty
    }
    @FocusState var isFocused:Bool
    
    @State var content:String = ""
        
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            VStack(spacing: 0) {
                VStack {
                    Text("\(foodName) \(foodEngName)")
                        .foregroundStyle(.mdCoolgray80)
                        .font(.callout)
                        .bold()
                        .padding(8)
                        .background(.mdYellow30)
                        .cornerRadius(16)
                }
                .padding(16)
                
                ScrollView {
                    VStack (spacing: 24) {
                        // 플레이스
                        VStack (spacing: 8) {
                            HStack {
                                Text("플레이스")
                                    .foregroundStyle(.mdCoolgray90)
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Button {
                                } label: {
                                    HStack {
                                        Text("플레이스 검색하기")
                                            .foregroundStyle(.mdCoolgray60)
                                            .font(.caption)
                                        Image("add-square")
                                            .frame(width: 16, height: 16)
                                    }
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke()
                                            .foregroundStyle(.mdCoolgray20)
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background()
                        .cornerRadius(16)
                        
                        // 리뷰
                        VStack (spacing: 8) {
                            // 기록
                            TextEditor(text: $content)
                                .foregroundStyle(.mdCoolgray90)
                                .font(.footnote)
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.clear)
                                        .stroke(.mdCoolgray10)
                                )
                                .overlay(alignment: .topLeading, content: {
                                    if !isFocused && content.isEmpty {
                                        Text("플레이스를 추천하는 이유를 알려주세요.(선택)")
                                            .foregroundStyle(.mdCoolgray60)
                                            .font(.footnote)
                                            .padding(10)
                                    }
                                })
                                .frame(height: 144)
                                .scrollIndicators(.visible)
                                .focused($isFocused)
                                .onSubmit {
                                    isFocused = false
                                }
                                .onChange(of: content) { _, newContent in
                                    if newContent.count > characterLimit {
                                        content = String(newContent.prefix(characterLimit))
                                    }
                                }
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                            
                            
                            HStack (spacing: 0) {
                                Spacer()
                                Text("\(content.count)자 ")
                                    .foregroundStyle(.mdCoolgray70)
                                Text("| \(characterLimit)자")
                                    .foregroundStyle(.mdCoolgray40)
                            }
                            .font(.caption)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background()
                        .cornerRadius(16)
                        .onTapGesture {
                            isFocused = false
                        }
                        
                        // 사진
                        VStack {
                            if viewModel.selectedImages.isEmpty {
                                PhotosPicker(selection: $viewModel.imgSelection,
                                             maxSelectionCount: imgSelectionLimit,
                                             matching: .images) {
                                    VStack (spacing: 8) {
                                        Image("add-by")
                                        Text("사진 추가하기 (선택)")
                                            .foregroundStyle(.mdCoolgray90)
                                            .font(.footnote)
                                            .bold()
                                        
                                        Group {
                                            Text("\(0)/\(imgSelectionLimit)")
                                            Text("제철요리와 관계없는 이미지일 경우\n관리자 확인 후 삭제될 수 있습니다.")
                                        }
                                        .foregroundStyle(Color(uiColor: UIColor(hexCode: "A8A8A8")))
                                        .font(.caption2)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                
                            } else {
                                // 이미지 추가 후
                                VStack (spacing: 8) {
                                    HStack {
                                        Text("사진 추가하기")
                                            .font(.footnote)
                                            .foregroundStyle(.mdCoolgray90)
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                    
                                    LazyVStack (alignment: .leading) {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            LazyVGrid(columns: [GridItem(.flexible(minimum: 68, maximum: 68)), GridItem(.flexible(minimum: 68, maximum: 68)), GridItem(.flexible(minimum: 68, maximum: 68)), GridItem(.flexible(minimum: 68, maximum: 68))]) {
                                                
                                                ForEach(0..<viewModel.selectedImages.count, id: \.self) { i in
                                                    ZStack (alignment: .topTrailing) {
                                                        Image(uiImage: viewModel.selectedImages[i])
                                                            .resizable()
                                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                                        
                                                        Button {
                                                            // 이미지 삭제
                                                            viewModel.imgSelection.remove(at: i)
                                                        } label: {
                                                            Image("close-circle-black")
                                                                .frame(width: 24, height: 24)
                                                                .padding(4)
                                                        }
                                                    }
                                                    .frame(width: 68, height: 68)
                                                }
                                                
                                                if 1..<imgSelectionLimit ~= viewModel.selectedImages.count {
                                                    PhotosPicker(selection: $viewModel.imgSelection,
                                                                 maxSelectionCount: imgSelectionLimit,
                                                                 matching: .images) {
                                                        Image("add-bw")
                                                            .frame(width: 24, height: 24)
                                                            .padding(4)
                                                    }
                                                                 .frame(width: 68, height: 68)
                                                                 .background(Color.mdCoolgray20)
                                                                 .cornerRadius(8)
                                                }
                                            }
                                            .fixedSize()
                                            .frame(alignment: .leading) // temp
                                            .padding(.vertical, 8)
                                        }
                                    }
                                    
                                    Divider()
                                    Group {
                                        Text("\(viewModel.selectedImages.count)/10")
                                        Text("제철요리와 관계없는 이미지일 경우\n관리자 확인 후 삭제될 수 있습니다.")
                                    }
                                    .foregroundStyle(Color(uiColor: UIColor(hexCode: "A8A8A8")))
                                    .font(.caption2)
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background()
                        .cornerRadius(16)
                    }
                    .padding(24)
                }
                .background(Color(uiColor: UIColor(hexCode: "F2F4F8", alpha: 0.5)))
                
                // 등록하기 버튼
                Button {
                    
                } label: {
                    Text("등록하기")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(isCompletable ? .white : .mdCoolgray60)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(isCompletable ? .mdSkyBlue50 : .mdCoolgray20)
                        .cornerRadius(8)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 24)
                        .background(Color(uiColor: UIColor(hexCode: "F2F4F8", alpha: 0.5)))
                }
                .disabled(!isCompletable)
                
            }
            .ignoresSafeArea(.keyboard)
            .navigationBarBackButtonHidden()
            .navigationTitle("플레이스 작성하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("close-circle")
                            .frame(width: 24, height: 24)
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button ("닫기") {
                        isFocused = false
                    }
                }
            }
            .onTapGesture {
                isFocused = false
            }
            
        }
    }
}

#Preview {
    FoodPlaceWriteView()
}
