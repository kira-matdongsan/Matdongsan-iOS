//
//  FoodRecordWriteView.swift
//  Matdongsan
//
//  Created by sujeong on 6/10/25.
//

import SwiftUI
import PhotosUI
import Combine

struct FoodRecipeWriteView: View {
    let titleCharLimit:Int = 22
    let ingredientLimit:Int = 20
    let recipeCharLimit:Int = 2000
    let imgSelectionLimit:Int = 10
    
    var foodName:String = "옥수수"
    var foodEngName:String = "corn"
    var isCompletable:Bool {
        !title.isEmpty && !content.isEmpty
    }
    @FocusState var isRecipeFocused:Bool
    @FocusState var isIngreFocused:Bool
    @FocusState var isTitleFocused:Bool
    
    var enableAdding:Bool {
        !ingreInput.isEmpty && ingredients.count < ingredientLimit
    }
    
    @State var title:String = ""
    @State var ingreInput:String = ""
    @State var ingredients:[String] = []
    @State var content:String = ""
    
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    @EnvironmentObject var navigationManager:NavigationManager
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text("\(foodName) \(foodEngName)")
                    .foregroundStyle(.mdCoolgray80)
                    .font(.system(size: 16, weight: .bold))
                    .padding(8)
                    .background(.mdYellow30)
                    .cornerRadius(16)
            }
            .padding(16)
            
            ScrollView {
                VStack (spacing: 24) {
                    // 제목
                    VStack (alignment: .leading, spacing: 8) {
                        Text("레시피 이름")
                            .foregroundStyle(.mdCoolgray90)
                            .font(.system(size: 13, weight: .semibold))
                        
                        TextField(text: $title) {
                            Text("레시피 이름을 입력해주세요.")
                                .font(.system(size: 12, weight: .light))
                                .foregroundStyle(.mdCoolgray60)
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isTitleFocused ? .mdCoolgray30 : .mdCoolgray10)
                        )
                        .font(.system(size: 13, weight: .semibold))
                        .onChange(of: title) { _, newValue in
                            if newValue.count > titleCharLimit {
                                title = String(newValue.prefix(titleCharLimit))
                            }
                        }
                        .onSubmit({
                            isTitleFocused = false
                        })
                        .focused($isTitleFocused)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background()
                    .cornerRadius(16)
                    .onTapGesture {
                        isRecipeFocused = false
                        isTitleFocused = false
                        isIngreFocused = false
                    }
                    
                    // 재료
                    VStack (alignment: .leading, spacing: 8) {
                        Text("재료")
                            .foregroundStyle(.mdCoolgray90)
                            .font(.system(size: 13, weight: .semibold))
                        Text("재료는 20개까지 추가할 수 있어요.")
                            .foregroundStyle(.mdCoolgray50)
                            .font(.system(size: 12, weight: .light))

                        HStack {
                            TextField(text: $ingreInput) {
                                Text("재료 입력 후 추가해주세요.")
                                    .font(.system(size: 12, weight: .light))
                                    .foregroundStyle(.mdCoolgray60)
                            }
                            .focused($isIngreFocused)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.mdCoolgray90)
                            .autocorrectionDisabled()
                            .onSubmit {
                                isIngreFocused = false
                            }
                            
                            Spacer()
                            
                            Button {
                                ingredients.append(ingreInput)
                                ingreInput = ""
                            } label: {
                                HStack {
                                    Text("추가")
                                        .font(.system(size: 12, weight: .semibold))
                                    Image(enableAdding ? "add-square-tinted" : "add-square")
                                        .frame(width: 16, height: 16)
                                }
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(enableAdding ? .mdSkyBlue40 : .mdCoolgray20)
                                )
                                .foregroundStyle(enableAdding ? .mdSkyBlue40 : .mdCoolgray60)
                            }
                            .disabled(!enableAdding)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isIngreFocused ? .mdCoolgray30 : .mdCoolgray10)
                        )
                        
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 8) {
                            ForEach(Array(ingredients.enumerated()), id: \.offset) { (idx,ingrednt) in
                                HStack {
                                    Text(ingrednt)
                                        .font(.caption)
                                        .foregroundStyle(.mdSkyBlue50)
                                    Button {
                                        ingredients.remove(at: idx)
                                    } label: {
                                        Image("close-circle-sk")
                                            .resizable()
                                            .frame(width: 14, height: 14)
                                    }
                                }
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 6, style: .circular)
                                        .stroke(Color.mdSkyBlue30)
                                        .fill(Color(uiColor: UIColor(hexCode: "E5F5FC", alpha: 0.2)))
                                        
                                )
                            }
                        }
                        .padding(.vertical, ingredients.isEmpty ? 0 : 8)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background()
                    .cornerRadius(16)
                    
                    // 조리방법
                    VStack (spacing: 8) {
                        HStack {
                            Text("조리방법")
                                .foregroundStyle(.mdCoolgray90)
                                .font(.system(size: 13, weight: .semibold))
                            Spacer()
                        }
                        
                        TextEditor(text: $content)
                            .foregroundStyle(.mdCoolgray90)
                            .font(.system(size: 12, weight: .light))
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.clear)
                                    .stroke(isRecipeFocused ? .mdCoolgray30 : .mdCoolgray10)
                            )
                            .overlay(alignment: .topLeading, content: {
                                if !isRecipeFocused && content.isEmpty {
                                    Text("조리방법을 자세히 알려주세요.")
                                        .foregroundStyle(.mdCoolgray60)
                                        .font(.system(size: 12, weight: .light))
                                        .padding(10)
                                }
                            })
                            .frame(height: 238)
                            .scrollIndicators(.visible)
                            .focused($isRecipeFocused)
                            .onSubmit {
                                isRecipeFocused = false
                            }
                            .onChange(of: content) { _, newContent in
                                if newContent.count > recipeCharLimit {
                                    content = String(newContent.prefix(recipeCharLimit))
                                }
                            }
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                        
                        
                        HStack (spacing: 0) {
                            Spacer()
                            Text("\(content.count)자 ")
                                .foregroundStyle(.mdCoolgray70)
                            Text("| \(recipeCharLimit)자")
                                .foregroundStyle(.mdCoolgray40)
                        }
                        .font(.system(size: 12, weight: .light))
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background()
                    .cornerRadius(16)
                    .onTapGesture {
                        isRecipeFocused = false
                        isIngreFocused = false
                        isTitleFocused = false
                    }
                    
                    // 사진
                    PhotoAddView(viewModel: viewModel, imgSelectionLimit: imgSelectionLimit)
                }
                .padding(24)
            }
            .background(isRecipeFocused || isTitleFocused || isIngreFocused ? Color.mdCoolgray10 : Color.mdCoolgray10.opacity(0.5))
            
            // 등록하기 버튼
            Button {
                
            } label: {
                Text("등록하기")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(isCompletable ? .white : .mdCoolgray60)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(isCompletable ? .mdSkyBlue50 : .mdCoolgray20)
                    .cornerRadius(8)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 24)
                    .background(isRecipeFocused || isTitleFocused || isIngreFocused ? Color.mdCoolgray10 : Color.mdCoolgray10.opacity(0.5))
            }
            .disabled(!isCompletable)
            
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
        .navigationTitle("레시피 작성하기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navigationManager.pop()
                } label: {
                    Image("close-circle")
                        .frame(width: 24, height: 24)
                }
            }
            
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button ("닫기") {
                    isRecipeFocused = false
                    isTitleFocused = false
                    isIngreFocused = false
                }
            }
        }
        .onTapGesture {
            isRecipeFocused = false
            isTitleFocused = false
            isIngreFocused = false
        }
        
    }
}

#Preview {
    FoodRecipeWriteView()
}
