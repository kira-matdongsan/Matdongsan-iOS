//
//  SearchView.swift
//  Matdongsan
//
//  Created by sujeong on 7/9/25.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var input:String = ""
    @FocusState var isFocused:Bool
    
    @State var results:[String] = ["as", "asf", "3434", "323453", "a24s", "as3553f", "a21345s", "as23235f", "사과"]
//    @State var results:[String] = []
    
    @State var resultsinResult:[String] = ["과일", "사과", "복숭아", "참외", "수박", "메론", "딸기"]

    var body: some View {
        VStack {
            
            // 검색창
            HStack (spacing: 8) {
                TextField(text: $input,
                          prompt: Text("제철음식을 검색해 보세요")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.mdCoolgray50)) {
                }
                .padding(16)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(isFocused ? .mdCoolgray70 : .white)
                        .stroke(.mdCoolgray20)
                        .frame(height: 50)
                )
                .focused($isFocused)
                .onTapGesture {
                    isFocused = true
                }
                
                Image(isFocused ? "search-normal-70" : "search-normal-30")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 18)
            }
            .padding([.leading, .vertical], 16)
            .background(
                Color.white
                    .shadow(color: Color.mdCoolgray10, radius: 5, x: 0, y: 4)
            )
            
            
            // 결과화면 or 빈화면
            ScrollView {
                VStack {
                    if results.isEmpty {
                        Image("search-empty-img")
                    } else {
                        LazyVStack (spacing: 16) {
                            ForEach(results, id: \.self) { result in
                                HStack (spacing: 8) {
                                    Image("corn_bg") // asyncImage로 교체 예정
                                        .resizable()
                                        .frame(width: 76)
                                    
                                    VStack (spacing: 12) {
                                        HStack {
                                            Text(result)
                                                .foodListNameTextStyle()
                                            Spacer()
                                            Text("제철시기 | 11월~10월")
                                                .font(.system(size: 11, weight: .semibold))
                                                .foregroundStyle(.mdCoolgray80)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.mdCoolgray10.opacity(0.5))
                                                .padding(.trailing, 8)
                                        }
                                        ScrollView(.horizontal) {
                                            LazyHStack {
                                                ForEach(resultsinResult, id: \.self) { reinre in
                                                    Text(reinre)
                                                        .font(.system(size: 11, weight: .semibold))
                                                        .foregroundStyle(.mdCoolgray80)
                                                        .padding(.horizontal, 8)
                                                        .padding(.vertical, 4)
                                                        .background(Color.mdCoolgray10)
                                                        .cornerRadius(8)
                                                }
                                            }
                                        }
                                        .scrollIndicators(.hidden)
                                    }
                                        .padding(.vertical, 10)
                                }
                                .frame(height: 76)
                                .background(Color.white)
                                .cornerRadius(8)
                                    .shadow(color: Color(uiColor: UIColor(hexCode: "DDE1E6")), radius: 5, x:0, y:4)
                                
                            }
                        }
                    }
                }
            }
            .padding(24)
            .frame(maxHeight: .infinity)
            .scrollIndicators(.hidden)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack (spacing: 5) {
                    Button {
                        dismiss()
                    } label: {
                        Image("back-arrow")
                            .frame(width: 24, height: 24)
                    }
                    
                    Text("검색하기")
                        .foregroundStyle(.mdCoolgray60)
                        .font(.system(size: 18, weight: .bold))
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
