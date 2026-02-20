//
//  VotingCompletionModalView.swift
//  Matdongsan
//
//  Created by sujeong on 6/8/25.
//

import SwiftUI

struct VotingCompletionModalView: View {
    var dishName:String = ""
    @Binding var isPresent:Bool
    var img:UIImage?
    
    var body: some View {
        // width 280
        VStack (spacing: 8) {
            Text("\(dishName)에 투표했어요!")
                .font(.system(size: 16, weight: .bold))
                .padding(.top, 24)
            Divider()
            
            ZStack {
                Image(uiImage: img ?? UIImage(named: "cornfirst")!) // temp
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                Color.black.opacity(0.2)
                HStack (spacing: 4) {
                    Text(dishName)
                        .foregroundStyle(.mdWarmGray80)
                        .font(.system(size: 12, weight: .bold))
                    Image("checked-icon-trans")
                        .frame(width:16, height:16)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(.mdYellow40)
                .cornerRadius(8)
            }
            .frame(width: 124, height: 124)
            .cornerRadius(8)
            
            Text("확인")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(.mdSkyBlue50)
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 16)
                .onTapGesture {
                    isPresent.toggle()
                }
        }
        .frame(width: 280)
        .background()
        .cornerRadius(16)
        .shadow(radius: 6)
    }
}

#Preview {
    VotingCompletionModalView(dishName: "군옥수수", isPresent: .constant(true), img: UIImage(named: "cornfirst")!)
}
