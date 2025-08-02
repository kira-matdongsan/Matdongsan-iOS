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
    
    var foodName:String = "옥수수"
    var foodEngName:String = "corn"
    var isCompletable:Bool {
        !content.isEmpty // TODO
    }
    
    var tempPlace:Place = Place(placeName: "토오베", placeCategory: "차 전문점", address: "서울특별시 종로구 인사동길 62-4 3층")
    @State var place:Place?
    
    @FocusState var isFocused:Bool
    
    @State var content:String = ""
    
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    var body: some View {
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
                            
                            if place == nil {
                                Button {
                                    navigationManager.navigate(to: AppRoute.placeSearch)
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
                        
                        if place != nil {
                            HStack (spacing: 8) {
                                Image("location")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                
                                VStack (alignment: .leading, spacing: 4) {
                                    HStack (alignment: .bottom, spacing: 8){
                                        Text(place?.placeName ?? "")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text(place?.placeCategory ?? "")
                                            .font(.footnote)
                                        Spacer()
                                    }
                                    Text(place?.address ?? "")
                                        .font(.caption)
                                }
                                .foregroundStyle(.mdCoolgray90)
                                
                                Button {
                                    
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
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background()
                    .cornerRadius(8)
                    
                    // 리뷰
                    VStack (spacing: 8) {
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
                    .padding(16)
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
            .background(isFocused ? Color.mdCoolgray10 : Color.mdCoolgray10.opacity(0.5))
            
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
                    .background(isFocused ? Color.mdCoolgray10 : Color.mdCoolgray10.opacity(0.5))
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
//        .environmentObject($place)
    }
}

#Preview {
    FoodPlaceWriteView()
}
