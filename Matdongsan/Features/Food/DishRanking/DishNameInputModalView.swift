//
//  DishNameInputModalView.swift
//  Matdongsan
//
//  Created by sujeong on 6/8/25.
//

import SwiftUI

struct DishNameInputModalView: View {
    @Binding var isPresent:Bool
    @Binding var dishName:String
    @State var input:String = ""
    @FocusState var isFocused:Bool
    var enableAdding:Bool {
        !input.isEmpty
    }
    let characterLimit:Int = 22
    
    var body: some View {
        
        ZStack {
            Color.mdGray50
                .opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    isFocused = false
                }
            
            VStack (spacing: 16) {
                Button {
                    isPresent = false
                } label: {
                    Image("close-circle")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, -16)
                
                
                Text("제철요리 등록하기")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.mdCoolgray90)
                
                VStack (alignment: .leading, spacing: 8) {
                    Text("제철요리 이름")
                        .font(.footnote)
                        .foregroundStyle(.mdCoolgray90)
                    
                    TextField("제철요리 이름을 입력해 주세요. (최대 22자)", text: $input)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke()
                                .foregroundStyle(.mdCoolgray20)
                        )
                        .font(.caption)
                        .onChange(of: input) { _, newValue in
                            if newValue.count > characterLimit {
                                input = String(newValue.prefix(characterLimit))
                            }
                        }
                        .focused($isFocused)
                    // paste 경우는 처리하지 않겠습니다. (당당)
                    
                    VStack (alignment: .leading, spacing: 2) {
                        Text("- 제철음식과 관련된 요리가 아닐 경우 등록되지 않을 수 있습니다.")
                            .font(.caption2)
                            .foregroundStyle(.mdCoolgray50)
                        
                        Text("- 제철요리 이름을 정확히 입력해주세요")
                            .font(.caption2)
                            .foregroundStyle(.mdRed)
                    }
                }
                
                Button {
                    dishName = input
                    isPresent.toggle()
                } label: {
                    Text("추가하기")
                        .frame(width: UIScreen.main.bounds.width - 90) //temp
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(enableAdding ? .white : .mdCoolgray60)
                }
                .frame(maxWidth: .infinity)
                .padding(14)
                .background(enableAdding ? .mdSkyBlue50 : .mdCoolgray20)
                .cornerRadius(8)
                .disabled(!enableAdding)
            }
            .padding(16)
            .background()
            .cornerRadius(16)
            .padding(.horizontal, 12)
            .onAppear {
                isFocused = true
            }
        }

    }
}

#Preview {
    DishNameInputModalView(isPresent: .constant(false), dishName: .constant(""))
}
