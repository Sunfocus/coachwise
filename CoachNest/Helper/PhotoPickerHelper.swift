//
//  PhotoPickerHelper.swift
//  CoachNest
//
//  Created by ios on 31/12/24.
//

import SwiftUI
import PhotosUI

class PhotoPickerHelper: ObservableObject {
    @Published var selectedImage: UIImage? = nil
    @Published var isPickerPresented: Bool = false
    @Published var selectedImages: [UIImage?] = []
        
        // Trigger the photo picker
        func openPhotoPicker() {
            isPickerPresented = true
        }
        
        // Update the selected image
        func setSelectedImage(image: UIImage) {
            selectedImage = image
        }
        
        // Append selected image to the array
        func appendSelectedImage() {
            if let image = selectedImage {
                selectedImages.append(image)
            }
        }
}

struct PhotoPickerView: View {
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                Text("Select a photo")
            }
        }
    }
}

struct PhotoPickerCoordinator: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var selectedImages: [UIImage?]
    @Binding var isPresented: Bool
    let helper: PhotoPickerHelper
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPickerCoordinator
        
        init(parent: PhotoPickerCoordinator) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let item = results.first {
                item.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                    guard let image = object as? UIImage else { return }
                    DispatchQueue.main.async {
                        self.parent.selectedImage = image
                        self.parent.selectedImages.append(image)
                        self.parent.isPresented = false
                    }
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // No updates needed
    }
}
