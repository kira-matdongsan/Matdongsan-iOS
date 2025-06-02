//
//  DishVotingView.swift
//  Matdongsan
//
//  Created by sujeong on 6/2/25.
//

import SwiftUI

struct NewDishVotingView: View {
    
    // 둘의 차이점 궁금
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            
            
            
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
        .border(.mdCoolgray20)
    }
}

#Preview {
    NewDishVotingView()
}
