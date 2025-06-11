//
//  FoodRecordWriteView.swift
//  Matdongsan
//
//  Created by sujeong on 6/10/25.
//

import SwiftUI
import PhotosUI

struct FoodRecordWriteView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var foodName:String = "옥수수"
    var foodEngName:String = "corn"
    var isCompletable:Bool {
        !content.isEmpty // temp 날짜는 선택?
    }
    @FocusState var isFocused:Bool

    @State var content:String = "제철음식에 대한 기록을 남길 수 있어요."
    @State var date:Date = Date(timeIntervalSinceNow: 60)
    
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }

    
    var body: some View {
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
        
        ZStack {
            ScrollView {
                // 기록 TF? TV?
                VStack (spacing: 8) {
                    // 날짜
                    HStack {
                        HStack {
                            Image("menu-board")
                                .frame(width: 18, height: 18)
                            Text(date > Date() ? "언제 기록인가요? (선택)" : "\(dateFormatter.string(from: date))")
                                .font(.caption)
                                .foregroundStyle(.mdCoolgray90)
                                .overlay {
                                    DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                                        .datePickerStyle(.compact)
                                        .labelsHidden()
                                        .opacity(0.02)
                                        .contentShape(Rectangle())
                                }
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .background(.mdCoolgray10)
                        .cornerRadius(16)
                        Spacer()
                    }
                    
                    // 기록
                    TextEditor(text: $content)
                        .foregroundStyle(.mdCoolgray90)
                        .font(.caption)
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.clear)
                                .stroke(.mdCoolgray10)
                        )
                        .frame(height: 144)
                        .scrollIndicators(.visible)
                        .focused($isFocused)
                        .onSubmit {
                            isFocused = false
                        }
                    
                    
                    HStack {
                        Spacer()
                        Text("\(0)자 | 500자")
                            .font(.caption)
                            .foregroundStyle(.mdCoolgray70)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .background()
                .cornerRadius(16)
                .padding([.horizontal, .top], 24)
                
                // 사진
                VStack {
                    if viewModel.selectedImages.isEmpty {
                        PhotosPicker(selection: $viewModel.imgSelection,
                                     maxSelectionCount: 5,
                                     matching: .images) {
                            VStack (spacing: 8) {
                                Image("add-by")
                                Text("사진 추가하기 (선택)")
                                    .foregroundStyle(.mdCoolgray90)
                                    .font(.footnote)
                                    .bold()
                                
                                Group {
                                    Text("\(0)/10")
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
                            Text("사진 추가하기")
                            //                            .frame(width: proxy.size.width-48-32, alignment: .leading)
                                .font(.footnote)
                                .foregroundStyle(.mdCoolgray90)
                            
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
                                        
                                        if 1..<5 ~= viewModel.selectedImages.count {
                                            PhotosPicker(selection: $viewModel.imgSelection,
                                                         maxSelectionCount: 5,
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
                                    .padding(.vertical, 12)
                                }
                            }
                            
                            Divider()
                            Text("제철요리와 관계없는 이미지일 경우\n관리자 확인 후 삭제될 수 있습니다.")
                                .font(.caption2)
                                .foregroundStyle(.mdCoolgray70)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .background()
                .cornerRadius(16)
                .padding(24)
                
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
                        .padding(.bottom, 24)
                }
                .disabled(!isCompletable)
            }
            .background(Color(uiColor: UIColor(hexCode: "F2F4F8", alpha: 0.5)))
            .navigationBarBackButtonHidden()
            .navigationTitle("제철기록 작성하기")
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
            }
            
            if isFocused {
                Color.white
                    .opacity(0.01)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isFocused.toggle()
                    }
            }
        }
    }
}

#Preview {
    FoodRecordWriteView()
}
