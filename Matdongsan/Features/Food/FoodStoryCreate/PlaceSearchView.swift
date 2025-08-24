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
//    @EnvironmentObject var selectedPlace:Place?

    var isCompletable:Bool {
        selectedId != -1 // TODO
    }
    
    @State var results:[Place] = [Place](repeating: .init(placeName: "토오베", placeCategory: "차 전문점", address: "서울특별시 종로구 인사동길 62-4 3층"), count: 10)
    
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
                    isFocused = false
                    // 검색 API 호출
                })
                .focused($isFocused)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                
                Spacer()
                Image(isFocused || !searchKeyword.isEmpty ? "search-normal-10" : "search-normal")
                    .resizable()
                    .frame(width: 18, height: 18)
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
            
            
            // 검색 결과
            ScrollView {
                LazyVStack {
                    ForEach(Array(results.enumerated()), id: \.offset) { (idx,result) in
                        HStack (spacing: 8) {
                            Image(idx == selectedId ? "location-sk" : "location-gray")
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                            VStack (alignment: .leading, spacing: 4) {
                                HStack (alignment: .bottom, spacing: 8){
                                    Text(result.placeName)
                                        .font(.system(size: 14, weight: .semibold))
                                    Text(result.placeCategory)
                                        .font(.system(size: 13, weight: .regular))
                                    Spacer()
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
            
            
            
            // 추가하기
            Button {
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
