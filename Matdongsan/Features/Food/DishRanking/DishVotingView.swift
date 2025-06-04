//
//  DishVotingView.swift
//  Matdongsan
//
//  Created by sujeong on 6/2/25.
//

import SwiftUI
import PhotosUI

struct DishVotingView: View {
    
    // 둘의 차이점 궁금
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var dishName:String = "찐옥수수"
    @State var votingEnabled:Bool = false
    var addedImgs:[String] = [] // ["corn", "corn"]
    @State var items:[PhotosPickerItem] = []

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
            
                    VStack {
                        if addedImgs.isEmpty {
                            PhotosPicker(selection: $items,
                                         matching: .images) {
                                VStack (spacing: 8) {
                                    Image("add")
                                    Text("사진 추가하기 (선택)")
                                        .foregroundStyle(.mdCoolgray90)
                                        .font(.footnote)
                                    
                                    Group {
                                        Text("\(0)/5")
                                        Text("제철요리와 관계없는 이미지일 경우\n관리자 확인 후 삭제될 수 있습니다.")
                                    }
                                    .foregroundStyle(Color(uiColor: UIColor(hexCode: "A8A8A8")))
                                    .font(.caption2)
                                }
                                .frame(width: proxy.size.width-90)
                            }
                        } else {
                            // 이미지 추가 후
                            VStack (spacing: 8) {
                                Text("사진 추가하기")
                                    .frame(width: proxy.size.width-48-32, alignment: .leading)
                                    .font(.footnote)
                                    .foregroundStyle(.mdCoolgray90)
                                
                                LazyVStack (alignment: .leading) {
                                    LazyVGrid(columns: [GridItem(.flexible(minimum: 68, maximum: 68)), GridItem(.flexible(minimum: 68, maximum: 68)), GridItem(.flexible(minimum: 68, maximum: 68)), GridItem(.flexible(minimum: 68, maximum: 68))]) {
                                        ForEach(0..<3) { i in
                                            ZStack (alignment: .topTrailing) {
                                                Image(i != 10 ? "cornfirst" : "corn")
                                                    .resizable()
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                                
                                                Button {
                                                    // 이미지 삭제
                                                } label: {
                                                    Image("close-circle-black")
                                                        .frame(width: 24, height: 24)
                                                        .padding(4)
                                                }
                                            }
                                            .frame(width: 68, height: 68)
                                        }
                                        
                                        if 1..<5 ~= addedImgs.count {
                                            Button {
                                                // 이미지 추가
                                            } label: {
                                                Image("add-bw")
                                                    .frame(width: 24, height: 24)
                                                    .padding(4)
                                            }
                                            .frame(width: 68, height: 68)
                                            .background(Color.mdCoolgray20)
                                            .cornerRadius(8)
                                        }
                                    }
                                    .fixedSize()
                                    .frame(alignment: .leading) // temp
                                    .padding(.vertical, 12)
                                }

                                Group {
                                    Text("투표에 사용한 사진은 ‘마이페이지 > 내활동'에서 삭제할 수 있어요.")
                                    Divider()
                                    Text("제철요리와 관계없는 이미지일 경우\n관리자 확인 후 삭제될 수 있습니다.")
                                }
                                .font(.caption2)
                                .foregroundStyle(.mdCoolgray70)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
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
