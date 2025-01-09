//
//  AudioWaveFormViewModel.swift
//  CoachNest
//
//  Created by ios on 09/01/25.
//

import AVFoundation
import SwiftUI

class AudioWaveformViewModel: ObservableObject {
    @Published var amplitudes: [CGFloat] = []
    @Published var duration: String = "0:00"

    func loadAudioFile(url: URL) {
        do {
            // Load the audio file
            let audioFile = try AVAudioFile(forReading: url)
            let audioFormat = audioFile.processingFormat
            let frameCount = AVAudioFrameCount(audioFile.length)
            let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: frameCount)!

            try audioFile.read(into: buffer)

            // Safely access channel data
            guard let channelData = buffer.floatChannelData else { return }
            let channelDataPointer = UnsafeBufferPointer(start: channelData[0], count: Int(buffer.frameLength))
            
            // Process audio samples
            let samples = stride(from: 0, to: Int(buffer.frameLength), by: 1024).map { index in
                let frame = min(1024, Int(buffer.frameLength) - index)
                let rms = sqrt(channelDataPointer[index..<index+frame].map { $0 * $0 }.reduce(0, +) / Float(frame))
                return CGFloat(rms)
            }

            // Calculate duration
            let audioDuration = audioFile.length / Int64(audioFormat.sampleRate)
            let minutes = audioDuration / 60
            let seconds = audioDuration % 60

            // Update UI on the main thread
            DispatchQueue.main.async {
                self.amplitudes = samples
                self.duration = String(format: "%d:%02d", minutes, seconds)
            }
        } catch {
            print("Error loading audio file: \(error.localizedDescription)")
        }
    }
}
