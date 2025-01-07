//
//  WavesAnimationView.swift
//  CoachNest
//
//  Created by ios on 07/01/25.
//

import SwiftUI

struct AudioWaveformView: View {
    @State private var barHeights: [CGFloat] = Array(repeating: 10, count: 30) // Initial bar heights
    @State private var isRecording: Bool = true
    @State private var elapsedTime: TimeInterval = 0 // Tracks elapsed time
    @State private var timer: Timer? = nil // Holds the animation timer
    
    init(){
        startElapsedTimeTimer()
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<barHeights.count, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white)
                    .frame(width: 2.5, height: barHeights[index]) // Adjust the bar height
            }
            Text(formatTime(elapsedTime))
                .customFont(.medium, 15)
                .foregroundStyle(.white)
                .padding(.horizontal, 5)
                .frame(width: 50)
        }
        .frame(height: 40) // Max height of the waveform
        .padding(.horizontal)
        .background(Color.primaryTheme.cornerRadius(12))
      
        .onAppear {
            startAnimatingBars()
            startElapsedTimeTimer()
        }
        .onDisappear {
            stopAnimatingBars()
            timer?.invalidate()
            timer = nil
        }
    }
    
    // MARK: - Animating the Bar Heights
    private func startAnimatingBars() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if !isRecording {
                timer.invalidate()
                return
            }
            // Randomize the bar heights to simulate an audio waveform
            barHeights = barHeights.map { _ in CGFloat.random(in: 4...20) }
        }
    }
    
    private func stopAnimatingBars() {
        isRecording = false
    }
    
    // MARK: - Tracking Elapsed Time
    private func startElapsedTimeTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if isRecording {
                elapsedTime += 1
            } else {
                timer.invalidate()
            }
        }
    }

       // MARK: - Formatting Time
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    
    
}

struct AudioWaveformView_Previews: PreviewProvider {
    static var previews: some View {
        AudioWaveformView()
            .frame(height: 85)
       //     .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
