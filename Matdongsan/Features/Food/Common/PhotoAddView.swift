//
//  PhotoAddView.swift
//  Matdongsan
//
//  Created by sujeong on 6/20/25.
//

import SwiftUI
import PhotosUI

struct PhotoAddView: View {
    @Binding var viewModel:PhotoPickerViewModel
    var imgSelectionLimit:Int = 0
    
    var body: some View {
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
        .padding(24)
    }
}

#Preview {
    PhotoAddView(viewModel: .constant(PhotoPickerViewModel()), imgSelectionLimit: 10)
}
