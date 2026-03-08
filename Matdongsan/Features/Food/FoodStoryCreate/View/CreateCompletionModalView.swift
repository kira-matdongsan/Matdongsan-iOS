//
//  CreateCompletionModalView.swift
//  Matdongsan
//
//  Created by sujeong on 3/7/26.
//

import SwiftUI

struct CreateCompletionModalView: View {
    var storyType:String = ""
    @Binding var isPresent:Bool
    
    var body: some View {
        VStack (spacing: 0) {
            Text("\(storyType) 등록했어요!")
                .font(.system(size: 16, weight: .bold))
                .padding(.top, 24)
                .padding(.bottom, 8)
            
            Image("completion_dongsan")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 168, height: 92)
                .padding(.vertical, 16)
            
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
    CreateCompletionModalView(storyType: "제철기록을", isPresent: .constant(true))
}
