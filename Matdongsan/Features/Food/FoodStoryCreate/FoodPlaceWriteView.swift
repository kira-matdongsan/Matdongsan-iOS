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
    @EnvironmentObject var navigationManager:NavigationManager
    
    let characterLimit:Int = 500
    let imgSelectionLimit:Int = 10
    
    var foodName:String = "옥수수" // parameter
    var foodEngName:String = "corn" // parameter
    var isCompletable:Bool {
        !content.isEmpty // TODO
    }
    
    @FocusState var isFocused:Bool
    
    @State var content:String = ""
    @State var showCompletionAlert: Bool = false
    
    @EnvironmentObject var viewModel: FoodPlaceViewModel
    @StateObject private var photoPickerViewModel = PhotoPickerViewModel()
    
    var body: some View {
        ZStack {
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
                        // 플레이스
                        VStack (spacing: 8) {
                            HStack {
                                Text("플레이스")
                                    .foregroundStyle(.mdCoolgray90)
                                    .font(.system(size: 13, weight: .semibold))
                                
                                Spacer()
                                
                                if viewModel.selectedPlace == nil {
                                    Button {
                                        navigationManager.navigate(to: AppRoute.placeSearch)
                                    } label: {
                                        HStack {
                                            Text("플레이스 검색하기")
                                                .foregroundStyle(.mdCoolgray60)
                                                .font(.system(size: 12, weight: .semibold))
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
                            
                            if let place = viewModel.selectedPlace {
                                HStack (spacing: 8) {
                                    Image("location-sk")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                    
                                    VStack (alignment: .leading, spacing: 4) {
                                        HStack (alignment: .bottom, spacing: 8){
                                            Text(place.displayTitle)
                                                .font(.system(size: 14, weight: .semibold))
                                            Text(place.category)
                                                .font(.system(size: 13, weight: .regular))
                                            Spacer()
                                        }
                                        Text(place.address)
                                            .font(.system(size: 12, weight: .regular))
                                    }
                                    .foregroundStyle(.mdCoolgray90)
                                    
                                    Button {
                                        viewModel.selectedPlace = nil
                                    } label: {
                                        Image("close")
                                            .resizable()
                                            .frame(width: 24, height:24)
                                    }
                                }
                                .padding(10)
                                .background()
                                .cornerRadius(16)
                                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                        .frame(maxWidth: .infinity)
                        .background()
                        .cornerRadius(8)
                        
                        // 리뷰
                        VStack (spacing: 8) {
                            TextEditor(text: $content)
                                .foregroundStyle(.mdCoolgray90)
                                .font(.system(size: 12, weight: .regular))
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
                                            .font(.system(size: 12, weight: .light))
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
                            .font(.system(size: 12, weight: .regular))
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background()
                        .cornerRadius(16)
                        .onTapGesture {
                            isFocused = false
                        }
                        
                        // 사진
                        PhotoAddView(viewModel: photoPickerViewModel, imgSelectionLimit: imgSelectionLimit)
                    }
                    .padding(24)
                }
                .background(isFocused ? Color.mdCoolgray10 : Color.mdCoolgray10.opacity(0.5))
                
                // 등록하기 버튼
                Button {
                    Task {
                        if let place = viewModel.selectedPlace {
                            try await viewModel.postPlace(foodId: foodId ?? 0,
                                                          name: place.displayTitle,
                                                          category: place.category,
                                                          address: place.address,
                                                          link: place.link,
                                                          content: content,
                                                          selectedImages: photoPickerViewModel.selectedImages)
                            if viewModel.isSuccess {
                                showCompletionAlert = true
                            }
                        }
                    }
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
                        .background(isFocused ? Color.mdCoolgray10 : Color.mdCoolgray10.opacity(0.5))
                }
                .disabled(!isCompletable)
                
            }
            
            if showCompletionAlert {
                Color.mdGray50
                    .opacity(0.1)
                    .ignoresSafeArea()
                
                CreateCompletionModalView(storyType: "플레이스를", isPresent: $showCompletionAlert)
                    .padding(24)
                    .onDisappear {
                        viewModel.reset()
                        navigationManager.pop()
                    }
            }
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
        .navigationTitle("플레이스 작성하기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.reset()
                    navigationManager.pop()
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

#Preview {
    FoodPlaceWriteView()
}
