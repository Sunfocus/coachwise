//
//  SpeechRecognisionManager.swift
//  CoachNest
//
//  Created by ios on 25/12/24.
//

import SwiftUI
import Speech

class SpeechRecognitionManager: ObservableObject {
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en_US"))
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audioEngine = AVAudioEngine()
    
    @Published var recognizedText = ""
    
    init() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            // Handle authorization
            switch authStatus {
            case .authorized:
                print("Speech recognition authorized")
            default:
                print("Speech recognition not authorized")
            }
        }
    }
    
    func startRecording() {
        print("startRecording...")
        // Ensure we have permission and stop previous tasks if necessary
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            print("Speech recognition is not available.")
            return
        }
        
        // Setup microphone input
        let request = SFSpeechAudioBufferRecognitionRequest()
        
        do {
            let inputNode = audioEngine.inputNode
            let bus = 0
            let recordingFormat = inputNode.outputFormat(forBus: bus)
            inputNode.installTap(onBus: bus, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
                request.append(buffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            
            recognitionTask = recognizer.recognitionTask(with: request) { result, error in
                if let result = result {
                    self.recognizedText = result.bestTranscription.formattedString
                    print("Recognized text: \(self.recognizedText)")
                    // Use recognizedText to filter contacts
                }
                
                if let error = error {
                    print("Recognition error: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Audio engine error: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        print("stopRecording...")
    }
}

