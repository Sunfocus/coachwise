//
//  AudioPlayerHelper.swift
//  CoachNest
//
//  Created by ios on 08/01/25.
//

import AVFoundation
import SwiftUI

class AudioPlayerHelper: NSObject, ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    @Published var finishPlaying: Bool = false
    @Published var isPlaying: Bool = false
    @Published var remainingTime: String = ""
    @Published var currentTime: String = ""
    private var timer: Timer?
    @Published var progress: Float = 0.0 // Progress for the progress bar
    
    func prepareAudio(from fileURL: URL) {
        do {
           
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.delegate = self
            if let player = audioPlayer {
                remainingTime = formatTime(seconds: player.duration)
            }
            print("Audio prepared from \(fileURL)")
        } catch {
            print("Error while preparing audio: \(error.localizedDescription)")
        }
    }

    func playAudio() {
        guard let audioPlayer = audioPlayer else {
            print("AudioPlayer is not initialized. Call `prepareAudio` first.")
            return
        }
        audioPlayer.play()
        startTimer()
        print("Audio started playing")
    }
    
    func pauseAudio(){
        guard let player = audioPlayer else { return }
        let targetTime = Double(progress) * player.duration
        player.currentTime = targetTime
        updateRemainingTime() // Update UI
        audioPlayer?.pause()
    }
    
    private func startTimer() {
        stopTimer() // Ensure no duplicate timers
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateRemainingTime()
        }
    }
       
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func seek(to progress: Float) {
        guard let player = audioPlayer else { return }
        let targetTime = Double(progress) * player.duration
        player.currentTime = targetTime
        updateRemainingTime() // Update UI
    }
       
       private func updateRemainingTime() {
           guard let player = audioPlayer else { return }
           
           let remainingSeconds = player.duration - player.currentTime
           if remainingSeconds <= 0 {
               finishPlaying = true
               remainingTime = formatTime(seconds: remainingSeconds)
               stopTimer()
               progress = 1.0
           } else {
               remainingTime = formatTime(seconds: remainingSeconds)
               currentTime = formatTime(seconds: player.currentTime)
               progress = Float(player.currentTime / player.duration) // Calculate progress
           }
       }
       
       private func formatTime(seconds: TimeInterval) -> String {
           let minutes = Int(seconds) / 60
           let seconds = Int(seconds) % 60
           return String(format: "%d:%02d", minutes, seconds)
       }
}

extension AudioPlayerHelper: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("Audio finished playing successfully")
            isPlaying = false
            
        } else {
            print("Audio failed to play")
            isPlaying = false
        }
    }
}
