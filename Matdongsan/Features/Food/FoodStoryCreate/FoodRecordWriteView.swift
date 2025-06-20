//
//  FoodRecordWriteView.swift
//  Matdongsan
//
//  Created by sujeong on 6/10/25.
//

import SwiftUI
import PhotosUI
import Combine

struct FoodRecordWriteView: View {
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
    @State var date:Date = Date()
    @State var initialSelected:Bool = false
    @State var showing:Bool = false
        
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }
    
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
                    // 기록 TF? TV?
                    ZStack {
                        VStack (spacing: 24) {
                            VStack (spacing: 8) {
                                // 날짜
                                HStack {
                                    HStack {
                                        Image("menu-board")
                                            .frame(width: 18, height: 18)
                                        Text(initialSelected ? "\(dateFormatter.string(from: date))" : "언제 기록인가요? (선택)")
                                            .font(.footnote)
                                            .foregroundStyle(.mdCoolgray90)
                                    }
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 10)
                                    .background(.mdCoolgray10)
                                    .cornerRadius(16)
                                    .onTapGesture {
                                        showing.toggle()
                                    }
                                    
                                    Spacer()
                                }
                                
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
                                            Text("제철음식에 대한 기록을 남길 수 있어요.")
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
                            PhotoAddView(viewModel: viewModel, imgSelectionLimit: imgSelectionLimit)
                        }
                        .padding(24)
                    }
                }
                .background(isFocused ? Color.mdCoolgray10 : Color(uiColor: UIColor(hexCode: "F2F4F8", alpha: 0.5)))

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
                        .background(isFocused ? Color.mdCoolgray10 : Color(uiColor: UIColor(hexCode: "F2F4F8", alpha: 0.5)))
                }
                .disabled(!isCompletable)
                
            }
            .ignoresSafeArea(.keyboard)
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
            
            if showing {
                VStack (spacing: 0) {
                    HStack {
                        Spacer()
                        Button("완료") {
                            initialSelected = true
                            showing = false
                        }
                        .padding(6)
                        .background(.mdCoolgray10)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                    
                    DatePicker("",
                               selection: $date,
                               in: ...Date(),
                               displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .onChange(of: date) { oldValue, newValue in
                        initialSelected = true
                        showing = false
                    }
                    .background(Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color:.mdCoolgray20, radius: 5))
                }
                .padding(10)
                .frame(width:300)
                .offset(x:18, y:75)  // temp
                .padding(10)
            }
        }
    }
}

#Preview {
    FoodRecordWriteView()
}
