//
//  VideoPlayerView.swift
//  CoachNest
//
//  Created by ios on 17/01/25.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoURL: URL
    
    var body: some View {
        VideoPlayer(player: AVPlayer(url: videoURL))
            .onAppear {
                // Auto-play the video when the view appears
                let player = AVPlayer(url: videoURL)
                player.play()
            }
            .ignoresSafeArea() // Optionally make it full screen
    }
}
