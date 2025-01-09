//
//  AudioVisualizerView.swift
//  CoachNest
//
//  Created by ios on 09/01/25.
//

import SwiftUI

struct AudioVisualizerView: View {
    @StateObject private var viewModel: AudioWaveformViewModel = AudioWaveformViewModel()
    @StateObject private var audioRecorderHelper = AudioRecorderHelper()
    @StateObject private var audioPlayerHelper = AudioPlayerHelper()
    var chat: MessageDetail

    var body: some View {
        HStack() {
            Image(.sg1)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(.circle)
                .padding(.trailing, 10)
                .overlay {
                    Image(.micPerson)
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .bottomTrailing)
                        .offset(x: 10, y: 10)
                }
            
            
            // Play Button
            Button(action: togglePlayPause) {
                Image(systemName: audioPlayerHelper.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }

            // Waveform
            GeometryReader { geometry in
                HStack(alignment: .center, spacing: 2) {
                    ForEach(viewModel.amplitudes.indices, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.white)
                            .frame(width: 1, height: max(10, geometry.size.height * viewModel.amplitudes[index]))
                    }
                }
            }
            .frame(height: 40)
            .padding(.horizontal)

            // Duration Label
            Text(audioPlayerHelper.isPlaying ? audioPlayerHelper.currentTime : audioPlayerHelper.remainingTime)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
        }
        .padding()
        .background(Color.primaryTheme)
        .cornerRadius(10)
        .onAppear{
            if let audio = chat.recordingUrl{
                audioPlayerHelper.prepareAudio(from: audio)
                viewModel.loadAudioFile(url: audio)
            }
            
        }
    }

    private func togglePlayPause() {
        print("play/pause the audio")
        if audioPlayerHelper.isPlaying{
            audioPlayerHelper.pauseAudio()
        }else{
            audioPlayerHelper.playAudio()
        }
        audioPlayerHelper.isPlaying.toggle()
    }
}



struct AudioVisualizerView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock ViewModel with sample data
        let mockViewModel = AudioWaveformViewModel()
        mockViewModel.amplitudes = [0.1, 0.3, 0.5, 0.4, 0.2, 0.6, 0.8, 0.7, 0.3, 0.2]
        mockViewModel.duration = "0:30"
        let message = MessageDetail(id: UUID(),
                                    time: "12:02 PM",
                                    message: "",
                                    messageFrom: ChatMember(id: 121,
                                                            name: "Max Collins",
                                                            profileImage: .f1,
                                                            accountType: .coach),
                                    messageType: .audio,
                                    recordingUrl: nil,
                                    sendImage: UIImage())

        return AudioVisualizerView(chat: message)
            .frame(height: 100) // Ensure proper height for waveform visualization
            .padding()
            .previewLayout(.sizeThatFits) // Adjust the preview size
            .background(Color.black.edgesIgnoringSafeArea(.all)) // Add background to simulate real UI
    }
}
