//
//  SpeechManager.swift
//  CoachNest
//
//  Created by ios on 06/01/25.
//

import SwiftUI
import Combine

public class SpeechManager: ObservableObject{
    var speechManager = SpeechRecognitionManager()
    private var cancellables: Set<AnyCancellable> = []
    
    
    func startVoiceSearch(completion: @escaping (String) -> Void) {
        speechManager.startRecording()
        speechManager.$recognizedText
            .receive(on: DispatchQueue.main)
            .sink { recognizedText in
                completion(recognizedText)
            }
            .store(in: &cancellables)
    }
    
    func stopVoiceSearch(){
        speechManager.stopRecording()
    }
}
