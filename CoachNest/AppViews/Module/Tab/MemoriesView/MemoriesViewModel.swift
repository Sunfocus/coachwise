//
//  MemoriesViewModel.swift
//  CoachNest
//
//  Created by ios on 16/01/25.
//

import SwiftUI
import PhotosUI

class MemoriesViewModel: ObservableObject{
    
    @Published var images: [UIImage] = []
    @Published var photosPickerItems: [PhotosPickerItem] = []
    @Published var show = false
    @Namespace var namespace
    @State var selectedImage: UIImage? = nil
    
    
    func createGrid(images: [UIImage]) -> some View{
        ForEach(images, id: \.self) { image in
            GridRow{
                Image(uiImage: image).resizable().scaledToFit()
                    .clipShape(.rect(cornerRadius: 12))
                    .matchedGeometryEffect(id: image, in: self.namespace)
                    .zIndex(self.selectedImage == image ? 1 : 0)
                    .onTapGesture {
                        withAnimation(.spring(duration: 0.5)) {
                            self.selectedImage = image
                            self.show.toggle()
                            
                        }
                    }
            }
            
        }
    }
    // Function to return images at odd indices
        func imagesAtOddIndices() -> [UIImage] {
            return images.enumerated().compactMap { index, image in
                index % 2 != 0 ? image : nil
            }
        }

        // Function to return images at even indices
        func imagesAtEvenIndices() -> [UIImage] {
            return images.enumerated().compactMap { index, image in
                index % 2 == 0 ? image : nil
            }
        }
}
