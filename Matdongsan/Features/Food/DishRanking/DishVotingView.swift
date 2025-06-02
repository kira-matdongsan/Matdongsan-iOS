//
//  DishVotingView.swift
//  Matdongsan
//
//  Created by sujeong on 6/2/25.
//

import SwiftUI

struct DishVotingView: View {
    
    // 둘의 차이점 궁금
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var dishName:String = "찐옥수수"
    @State var votingEnabled:Bool = false

    var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack {
                    VStack (spacing: 6) {
                        Text(dishName)
                            .foregroundStyle(.mdYellow)
                            .font(.title3)
                            .bold()
                        
                        Text("좋아하는 제철요리의 사진을 추가하고 투표해주세요.")
                            .foregroundStyle(.mdCoolgray20)
                            .font(.caption)
                    }
                    .padding(16)
                    .frame(maxWidth: proxy.size.width)
                    .background(.mdGray80)
                    .cornerRadius(16)
                    .padding(24)
                    
                    VStack (spacing: 8) {
                        Image("add")
                        Text("사진 추가하기 (선택)")
                            .foregroundStyle(.mdCoolgray90)
                            .font(.footnote)
                        
                        Group {
                            Text("\(0)/\(5)")
                            Text("제철요리와 관계없는 이미지일 경우\n관리자 확인 후 삭제될 수 있습니다.")
                        }
                        .foregroundStyle(Color(uiColor: UIColor(hexCode: "A8A8A8")))
                        .font(.caption2)
                            
                    }
                    .padding(.vertical, 15)
                    .frame(maxWidth: proxy.size.width)
                    .background()
                    .cornerRadius(16)
                    .shadow(color: Color(uiColor: UIColor(hexCode: "DDE1E6", alpha: 0.6)), radius: 6, x: 1, y: 2)
                    .padding(.horizontal, 24)
                    
                    Spacer()
 
                    Button {
                        //
                        votingEnabled.toggle()
                    } label: {
                        Text("투표하기")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(votingEnabled ? .white : .mdCoolgray60)
                            .padding(.vertical, 14)
                            .frame(maxWidth: proxy.size.width)
                            .background(votingEnabled ? .mdSkyBlue50 : .mdCoolgray20)
                            .cornerRadius(8)
                            .padding(.horizontal, 15)
                            .padding(.bottom, 24)
                    }

                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem {
                VStack (spacing: 10) {
                    Spacer()
                    HStack {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("back-arrow")
                                .frame(width: 18, height: 24)
                        }
                        
                        Spacer()

                        Text("제철요리 투표하기")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("close-circle")
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Rectangle()
                        .fill(Color.mdCoolgray10)
                        .frame(width: UIScreen.main.bounds.width ,height: 1)
                }
                .frame(width: UIScreen.main.bounds.width)
            }
        }
    }
}

#Preview {
    DishVotingView()
}
