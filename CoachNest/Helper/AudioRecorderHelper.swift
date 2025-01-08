//
//  AudioRecorderHelper.swift
//  CoachNest
//
//  Created by ios on 08/01/25.
//

import Foundation
import AVFoundation

class AudioRecorderHelper: NSObject, ObservableObject {
    private var audioRecorder: AVAudioRecorder?
    private var audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    private var recordingURL: URL?
    
    @Published var isRecording: Bool = false

    // Start recording
    func startRecording() {
        do {
            // Request microphone permission
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            // Request microphone permission
            AVAudioApplication.requestRecordPermission { [weak self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self?.beginRecording()
                    } else {
                        print("Microphone permission not granted")
                    }
                }
            }
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }

    private func beginRecording() {
        let fileName = UUID().uuidString + ".caf"
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsPath.appendingPathComponent(fileName)
        recordingURL = filePath

        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: filePath, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            isRecording = true
            print("Started recording at \(filePath)")
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }

    // Stop recording
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
    }
    
    // Delete the recorded file
    func deleteRecording() {
        guard let url = recordingURL else {
            print("No recording to delete")
            return
        }
        
        do {
            try FileManager.default.removeItem(at: url)
            print("Recording deleted at \(url.path)")
            recordingURL = nil // Clear the URL after deletion
        } catch {
            print("Failed to delete recording: \(error.localizedDescription)")
        }
    }
    
    func deleteRecordingUrlString(){
        guard let url = recordingURL else {
            print("No recording to delete")
            return
        }
        recordingURL = nil
    }

    // Get the recorded audio URL
    func getRecordingURL() -> URL? {
        return recordingURL
    }
}

// MARK: - AVAudioRecorderDelegate
extension AudioRecorderHelper: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Recording finished successfully at \(recorder.url)")
        } else {
            print("Recording failed")
        }
    }
}
