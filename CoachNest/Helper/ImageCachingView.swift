//
//  ImageCachingView.swift
//  CoachNest
//
//  Created by ios on 10/01/25.
//

import SwiftUI

struct AsyncImageView: View {
    let imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable().scaledToFill()
            case .failure:
                Text("Failed to load image")
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 100, height: 100)
    }
}
