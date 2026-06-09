//
//  PlaceSearchView.swift
//  Matdongsan
//
//  Created by sujeong on 6/20/25.
//

import SwiftUI

struct PlaceSearchView: View {
    @EnvironmentObject var navigationManager:NavigationManager
    
    @FocusState var isFocused:Bool
    
    @State var searchKeyword:String = ""
    @State var selectedId:Int = -1

    var isCompletable:Bool {
        selectedId != -1
    }
    
    @State var results:[PlaceInfo] = []
    @State private var hasSearched = false
    
    @EnvironmentObject var viewModel: FoodPlaceViewModel
    
    var body: some View {
        VStack (spacing: 24) {
            
            // 검색창
            HStack {
                TextField(text: $searchKeyword) {
                    Text("플레이스를 입력해주세요.")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.mdCoolgray50)
                }
                .foregroundStyle(.white)
                .font(.system(size: 13, weight: .semibold))
                .onSubmit({
                    hasSearched = true
                    isFocused = false
                    Task {
                        try await results = viewModel.searchPlace(keyword: searchKeyword)
                    }
                })
                .focused($isFocused)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                
                Spacer()
                Image(isFocused || !searchKeyword.isEmpty ? "search-normal-10" : "search-normal")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .onTapGesture {
                        hasSearched = true
                        isFocused = false
                        Task {
                            try await results = viewModel.searchPlace(keyword: searchKeyword)
                        }
                    }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isFocused || !searchKeyword.isEmpty ? .mdCoolgray80 : .clear)
                    .stroke(.mdCoolgray20)
            )
            .padding([.top, .horizontal], 24)
            
            
            Divider()
                .padding(.horizontal, 24)
            
            Group {
                if results.isEmpty {
                    VStack(spacing: 12) {
                        if hasSearched {
                            Image("empty-search")
                                .resizable()
                                .frame(width: 110, height: 110)

                            Text("검색한 플레이스가 없어요\n다른 플레이스를 검색해주세요")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.mdCoolgray70)
                        } else {
                            Image("search-guide")
                                .resizable()
                                .frame(width: 110, height: 110)

                            Text("플레이스를 검색해주세요")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.mdCoolgray70)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // 검색 결과
                    ScrollView {
                        LazyVStack {
                            ForEach(Array(results.enumerated()), id: \.offset) { (idx,result) in
                                HStack (spacing: 8) {
                                    Image(idx == selectedId ? "location-sk" : "location-gray")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                    
                                    VStack (alignment: .leading, spacing: 4) {
                                        HStack (alignment: .center, spacing: 8){
                                            Text(result.displayTitle)
                                                .font(.system(size: 14, weight: .semibold))
                                            Text(result.category)
                                                .font(.system(size: 13, weight: .regular))
                                                .lineLimit(1)
                                            Spacer(minLength: 6)
                                        }
                                        Text(result.address)
                                            .font(.system(size: 12, weight: .regular))
                                    }
                                    .foregroundStyle(.mdCoolgray90)
                                    
                                    Image(idx == selectedId ? "check-sk" : "check-gray")
                                        .resizable()
                                        .frame(width: 18, height:18)
                                }
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                        .stroke(selectedId == idx ? .mdSkyBlue20 : .clear)
                                        .shadow(color: .init(uiColor: UIColor(hexCode: "C1C7CD", alpha: 0.2)), radius: 8, x: 0, y: 2)
                                )
                                .padding(.horizontal, 24)
                                .padding(.vertical, 4)
                                .onTapGesture {
                                    selectedId = idx
                                }
                            }
                        }
                    }
                }
            }
            
            // 추가하기
            Button {
                if selectedId > -1, !results.isEmpty {
                    viewModel.selectedPlace = results[selectedId]
                }
                navigationManager.pop()
            } label: {
                Text("추가하기")
                    .font(.system(size: 14, weight: .semibold))
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
        .navigationBarBackButtonHidden()
        .navigationTitle("플레이스 검색")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    navigationManager.pop()
                } label: {
                    Image("back-arrow")
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
    }
}

#Preview {
    PlaceSearchView()
}
