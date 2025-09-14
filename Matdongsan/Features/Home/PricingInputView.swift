//
//  PricingInputView.swift
//  Matdongsan
//
//  Created by sujeong on 9/14/25.
//

import SwiftUI

struct PricingInputView: View {
    @EnvironmentObject var navigationManager: NavigationManager

    @State private var place: String = ""
    @FocusState var isPlaceFocused:Bool
    
    @State private var price: String = ""
    @FocusState var isPriceFocused:Bool

    @State private var quantity: String = ""
    @FocusState var isQuantityFocused:Bool
    
    var isCompletable:Bool {
        !place.isEmpty && !price.isEmpty && !quantity.isEmpty
    }

    private var priceFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 0
        return formatter
    }
    
    var body: some View {
        VStack (spacing: 24) {
            // 타이틀
            VStack (alignment: .leading, spacing: 4) {
                Text("맛동산 제철시세")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.mdCoolgray90)
                Text("실제 구매한 제철음식의 가격을 공유해보세요")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(.mdCoolgray60)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // 제철 음식 카드
            VStack {
                Image("corn02")
                    .padding(20)
                    .background(in: Circle())
                    .frame(height: 108)
                    .padding(.top, 8)
                Text("옥수수 corn")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.mdCoolgray80)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background()
                    .cornerRadius(16)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 12)
            .background(isCompletable ? Color.mdYellow20 :  Color.mdGray10)
            .cornerRadius(16)
            // 인풋
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    TextField("", text: $place, prompt: Text("어디")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(.mdCoolgray60)
                    )
                    .font(.system(size: 14, weight: .bold))
                    .padding(.horizontal, 8)
                    .frame(height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isPlaceFocused || !place.isEmpty ? Color.mdSkyBlue40 : Color.mdCoolgray20)
                    )
                    .focused($isPlaceFocused)
                    Text("에서")
                        .font(.system(size: 14))
                        .foregroundStyle(.mdGray90)
                }
                // price number로 저장할건지 string으로 저장할 건지
                HStack {
                    TextField("", text: $price, prompt: Text("얼마") // formatter
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(.mdCoolgray60)
                    )
                    .keyboardType(.numberPad)
                    .onChange(of: price, { oldValue, newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        if let number = Int(filtered) {
                            let formatter = NumberFormatter()
                            formatter.numberStyle = .decimal
                            price = formatter.string(from: NSNumber(value: number)) ?? filtered
                        }
                    })
                    .font(.system(size: 14, weight: .bold))
                    .padding(.horizontal, 8)
                    .frame(height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isPriceFocused || !price.isEmpty ? Color.mdSkyBlue40 : Color.mdCoolgray20)
                    )
                    .focused($isPriceFocused)
                    
                    Text("원에")
                        .font(.system(size: 14))
                        .foregroundStyle(.mdGray90)
                    
                    TextField("", text: $quantity, prompt: Text("몇")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(.mdCoolgray60)
                    )
                    .keyboardType(.numberPad)
                    .font(.system(size: 14, weight: .bold))
                    .padding(.horizontal, 8)
                    .frame(width: 72, height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isQuantityFocused || !quantity.isEmpty ? Color.mdSkyBlue40 : Color.mdCoolgray20)
                    )
                    .focused($isQuantityFocused)
                    
                    Text("개 구매했어요!")
                        .font(.system(size: 14))
                        .foregroundStyle(.mdGray90)
                }
                HStack(spacing: 4) {
                    Image("info-circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("등록한 제철시세는 수정할 수 없어요.")
                        .font(.system(size: 13))
                        .foregroundColor(.mdGray60)
                }
                .padding(.top, 8)
            }
            Spacer()
            
            // 버튼
            Button {
                
            } label: {
                Text("공유하기")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(isCompletable ? .white : .mdCoolgray60)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(isCompletable ? .mdSkyBlue50 : .mdCoolgray20)
                    .cornerRadius(8)
//                    .padding(.horizontal, 15)
//                    .padding(.vertical, 24)
            }
            .disabled(!isCompletable)
        }
        .padding(24)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
        .navigationTitle("맛동산 제철시세")
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
                    isPlaceFocused = false
                    isPriceFocused = false
                    isQuantityFocused = false
                }
            }
        }
        .onTapGesture {
            isPlaceFocused = false
            isPriceFocused = false
            isQuantityFocused = false
        }
    }
}

#Preview {
    PricingInputView()
}
