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
    private var player: AVPlayer

    init(videoURL: URL) {
        self.videoURL = videoURL
        self.player = AVPlayer(url: videoURL)
    }

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                player.play()
            }
            .onDisappear {
                player.pause()
            }
            .ignoresSafeArea()
    }
}
