//
//  PhotoPickerViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 6/8/25.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
final class PhotoPickerViewModel: ObservableObject {
    @Published private(set) var selectedImages:[UIImage] = []
    @Published var imgSelection:[PhotosPickerItem] = [] {
        didSet {
            withAnimation(.easeInOut(duration: 0.5)) {
                selectedImages.removeAll()
                setImages(from: imgSelection)
            }
        }
    }
    
    private func setImages(from selection: [PhotosPickerItem]) {
        if selection.isEmpty { return }
        
        // convert to uiImage
        Task {
            for selectedImage in selection {
                if let data = try? await selectedImage.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        selectedImages.append(uiImage)
                    }
                }
            }
        }
    }
    
    // 이미지 순서 바꿀 수 있게 하는 것도 필요하지 않을까
    // 이걸 통해서 지우게 할지, 아님 그냥 바로 지우게 할지
    func deleteImage(_ targetIndex:Int) {
        Task {
            imgSelection.remove(at: targetIndex)
        }
    }
}
