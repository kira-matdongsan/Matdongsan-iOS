//
//  DishVotingView.swift
//  Matdongsan
//
//  Created by sujeong on 6/2/25.
//

import SwiftUI
import PhotosUI

struct NewDishVotingView: View {
    
    // 둘의 차이점 궁금
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var foodName:String = "옥수수"
    var foodEngName:String = "corn"
    @State var dishName:String = ""
    @State var isPresentAlert:Bool = false
    
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    var votingEnabled:Bool {
        !viewModel.selectedImages.isEmpty && !dishName.isEmpty // temp
    }
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { proxy in
                    VStack (spacing: 24) {
                        VStack (spacing: 8) {
                            Text("\(foodName) \(foodEngName)")
                                .foregroundStyle(.mdCoolgray80)
                                .font(.title3)
                                .bold()
                                .padding(8)
                                .background(.mdYellow20)
                                .cornerRadius(16)
                            
                            Text("좋아하는 제철요리의 사진을 추가하고 투표해주세요.")
                                .foregroundStyle(.mdWarmGray90)
                                .font(.caption)
                        }
                        .padding(16)
                        .frame(maxWidth: proxy.size.width)
                        .background(.mdYellow40)
                        .cornerRadius(16)
                        .padding([.horizontal, .top], 24)
                        
                        // 제철요리 이름
                        VStack (spacing: 16) {
                            if dishName.isEmpty {
                                // 제철요리 이름 입력 전
                                VStack (spacing: 2) {
                                    Text("제철요리 등록하기")
                                        .bold()
                                        .foregroundStyle(.mdCoolgray90)
                                        .font(.footnote)
                                    
                                    Text("어떤 요리의 사진인가요? 🤔")
                                        .foregroundStyle(.mdCoolgray90)
                                        .font(.footnote)
                                }
                                
                                Button {
                                    isPresentAlert.toggle()
                                } label: {
                                    HStack {
                                        Text("제철요리 추가하기")
                                            .foregroundStyle(.mdCoolgray60)
                                            .font(.caption)
                                        Image("add-square")
                                            .frame(width: 16, height: 16)
                                    }
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke()
                                            .foregroundStyle(.mdCoolgray20)
                                    )
                                }
                            } else {
                                // 제철요리 이름 입력 후
                                HStack {
                                    Text("제철요리 등록하기")
                                        .bold()
                                        .foregroundStyle(.mdCoolgray90)
                                        .font(.footnote)
                                    
                                    Spacer()
                                    
                                    HStack (spacing: 4) {
                                        Text(dishName)
                                            .foregroundStyle(.mdYellow40)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                        Image("close-circle-gray")
                                            .frame(width:16, height:16)
                                            .onTapGesture {
                                                dishName = ""
                                            }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(.mdWarmGray80)
                                    .cornerRadius(8)
                                }
                            }
                            
                        }
                        .padding(16)
                        .frame(maxWidth: proxy.size.width)
                        .background()
                        .cornerRadius(16)
                        .shadow(color: Color(uiColor: UIColor(hexCode: "DDE1E6", alpha: 0.6)), radius: 6, x: 1, y: 2)
                        .padding(.horizontal, 24)
                        
                        VStack {
                            if viewModel.selectedImages.isEmpty {
                                PhotosPicker(selection: $viewModel.imgSelection,
                                             maxSelectionCount: 5,
                                             matching: .images) {
                                    VStack (spacing: 8) {
                                        Image("add-by")
                                        Text("사진 추가하기 (선택)")
                                            .foregroundStyle(.mdCoolgray90)
                                            .font(.footnote)
                                            .bold()
                                        
                                        Group {
                                            Text("\(0)/5")
                                            Text("제철요리와 관계없는 이미지일 경우\n관리자 확인 후 삭제될 수 있습니다.")
                                        }
                                        .foregroundStyle(Color(uiColor: UIColor(hexCode: "A8A8A8")))
                                        .font(.caption2)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                
                            } else {
                                // 이미지 추가 후
                                VStack (spacing: 8) {
                                    Text("사진 추가하기")
                                        .frame(width: proxy.size.width-48-32, alignment: .leading)
                                        .font(.footnote)
                                        .foregroundStyle(.mdCoolgray90)
                                    
                                    LazyVStack (alignment: .leading) {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            LazyVGrid(columns: [GridItem(.flexible(minimum: 68, maximum: 68)), GridItem(.flexible(minimum: 68, maximum: 68)), GridItem(.flexible(minimum: 68, maximum: 68)), GridItem(.flexible(minimum: 68, maximum: 68))]) {
                                                
                                                ForEach(0..<viewModel.selectedImages.count, id: \.self) { i in
                                                    ZStack (alignment: .topTrailing) {
                                                        Image(uiImage: viewModel.selectedImages[i])
                                                            .resizable()
                                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                                        
                                                        Button {
                                                            // 이미지 삭제
                                                            viewModel.imgSelection.remove(at: i)
                                                        } label: {
                                                            Image("close-circle-black")
                                                                .frame(width: 24, height: 24)
                                                                .padding(4)
                                                        }
                                                    }
                                                    .frame(width: 68, height: 68)
                                                }
                                                
                                                if 1..<5 ~= viewModel.selectedImages.count {
                                                    PhotosPicker(selection: $viewModel.imgSelection,
                                                                 maxSelectionCount: 5,
                                                                 matching: .images) {
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
                            // 이미지 업로드
                            // 1. presigned urls 받기
                            let requestDto = PresignedUrlsRequestDto(fileType: FileType.DISH.rawValue, fileNames: (0..<viewModel.selectedImages.count).map { "\($0).png" })
                            Task {
                                do {
                                    try APIService().getImgPresignedUrls(requestDto) { response in
                                        let imgUrls:[ImageUrlResponse] = response.contents
                                        for (i, imgUrl) in imgUrls.enumerated() {
                                            // 2. S3에 이미지 업로드
                                            guard let imageData = viewModel.selectedImages[i].pngData() else { continue }
                                            do {
                                                try APIService().uploadImgtoS3(imgUrl.presignedUrl, imageData) {
                                                    // s3에 이미지 업로드 완료
                                                    // TODO : access url로 post하기
                                                    print(imgUrl.accessUrl)
                                                    print("success")
                                                }
                                            } catch {
                                                print(error.localizedDescription)
                                            }
                                        }
                                    }
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                            self.presentationMode.wrappedValue.dismiss()
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
                        .disabled(!votingEnabled)
                    }
                }
            }
            .blur(radius: isPresentAlert ? 4 : 0)
            
            if isPresentAlert {
                Color.mdGray50
                    .opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresentAlert.toggle()
                    }
                
                DishNameInputModalView(isPresent: $isPresentAlert, dishName: $dishName)
                    .padding(24)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("제철요리 투표하기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("close-circle")
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}

#Preview {
    NewDishVotingView()
}
