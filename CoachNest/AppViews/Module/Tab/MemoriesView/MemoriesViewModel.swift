//
//  MemoriesViewModel.swift
//  CoachNest
//
//  Created by ios on 16/01/25.
//

import SwiftUI
import PhotosUI

enum MediaItem {
    case image
    case video
}

struct ItemType: Codable, Identifiable, Hashable{
    let id: UUID
    let isVideo: Bool
    let videoUrl: String
    let imageData: Data
    var image: UIImage? {
        UIImage(data: imageData)
    }
    
    init(imageData: UIImage, isVideo: Bool, videoUrl: String) {
        self.id = UUID()
        self.imageData = imageData.jpegData(compressionQuality: 1.0) ?? Data()
        self.isVideo = isVideo
        self.videoUrl = videoUrl
    }
}

class MemoriesViewModel: ObservableObject{
    
    @Published var images: [UIImage] = []
    @Published var videoURLs: [URL] = []
    @Published var mediaItems: [ItemType] = []
    @Published var photosPickerItems: [PhotosPickerItem] = []
    @Published var show = false
    @Namespace var namespace
    @Published var selectedImage: UIImage? = nil
    @Published var isImageSelected: Bool = false
    @Published var selectedItem: ItemType?
    
    
    func createGrid(mediaItems: [ItemType]) -> some View{
        ForEach(mediaItems, id: \.self) { item in
            GridRow{
                VStack{
                    Image(uiImage: item.image!).resizable().scaledToFit()
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(6) // Inner padding for the content
                        .background(Color.darkGreyBackground) // Ensure this is a defined color
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 2, y: 2)
                        .matchedGeometryEffect(id: item.image!, in: self.namespace)
                        .zIndex(self.selectedImage == item.image! ? 1 : 0)
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.5)) {
                                self.selectedItem = item
                                self.isImageSelected = true
                            }
                        }
                        .overlay {
                            if item.isVideo{
                                Image(.playButton)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .onTapGesture {
                                        withAnimation(.spring(duration: 0.5)) {
                                            self.selectedItem = item
                                            self.isImageSelected = true
                                        }
                                    }
                            }
                        }
                }
                .padding(.top, 20)
            }
            
        }
    }
    
 //    Function to return images at odd indices
    func imagesAtOddIndices() -> [ItemType] {
        return mediaItems.enumerated().compactMap { index, item in
            index % 2 != 0 ? item : nil
        }
    }

    func imagesAtEvenIndices() -> [ItemType] {
        return mediaItems.enumerated().compactMap { index, item in
            index % 2 == 0 ? item : nil
        }
    }
    
    
    
    @MainActor
    func processMediaItems() async {
        for item in photosPickerItems {
            do {
                if let mediaData = try await item.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: mediaData) {
                        // Add image to mediaItems
                        self.mediaItems.append(ItemType(imageData: image, isVideo: false, videoUrl: ""))
                    } else {
                        // Save video data to file and add video URL to mediaItems
                        let savedURL = try saveVideoToDocuments(videoData: mediaData)
                        generateThumbnail(from: savedURL) { thumbnail in
                            if let thumbnail = thumbnail {
                                print("Thumbnail generated successfully.")
                                let item = ItemType(imageData: thumbnail,
                                                    isVideo: true,
                                                    videoUrl: savedURL.absoluteString)
                                self.mediaItems.append(item)
                            } else {
                                print("Failed to generate thumbnail.")
                            }
                        }
                        self.videoURLs.append(savedURL)
                    }
                } else {
                    print("Failed to load transferable data.")
                }
            } catch {
                print("Error processing media item: \(error)")
            }
        }
        photosPickerItems = []
    }
    
    func generateThumbnail(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let asset = AVURLAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        let time = CMTime(seconds: 0, preferredTimescale: 60)
        
        // Asynchronously generate the CGImage
        imageGenerator.generateCGImageAsynchronously(for: time) { cgImage, requestedTime, error in
            DispatchQueue.main.async {
                if let cgImage = cgImage {
                    // Convert CGImage to UIImage and pass to the completion handler
                    completion(UIImage(cgImage: cgImage))
                } else {
                    print("Error generating thumbnail: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                }
            }
        }
    }
    
    // Helper function to save video data to documents directory
    func saveVideoToDocuments(videoData: Data) throws -> URL {
        // Get the documents directory
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // Create a unique file name for the video
        let videoFileName = UUID().uuidString + ".mp4" // Assuming MP4 format for videos
        let videoFileURL = documentsURL.appendingPathComponent(videoFileName)
        
        // Write the video data to the file
        try videoData.write(to: videoFileURL)
        return videoFileURL
    }


    private func saveVideoToDocuments(videoURL: URL) throws -> URL {
        let fileManager = FileManager.default
        
        // Create a unique filename for the video
        let fileName = UUID().uuidString + ".mp4"
        let destinationURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
        
        // Copy the video to the destination
        try fileManager.copyItem(at: videoURL, to: destinationURL)
        
        return destinationURL
    }
}
