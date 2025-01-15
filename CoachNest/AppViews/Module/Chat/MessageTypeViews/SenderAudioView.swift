//
//  SendAudioView.swift
//  CoachNest
//
//  Created by ios on 07/01/25.
//

import SwiftUI
import AVFoundation

struct SenderAudioView: View {
    @StateObject private var audioRecorderHelper = AudioRecorderHelper()
    @StateObject private var audioPlayerHelper = AudioPlayerHelper()
    var chat: MessageDetail
    
    var body: some View {
        VStack{
            HStack{
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
                Button {
                    print("play/pause the audio")
                    if audioPlayerHelper.isPlaying{
                        audioPlayerHelper.pauseAudio()
                    }else{
                        audioPlayerHelper.playAudio()
                    }
                    audioPlayerHelper.isPlaying.toggle()
                } label: {
                    Image( systemName: ( audioPlayerHelper.isPlaying ? "pause.fill" :"play.fill"))
                        .tint(.white)
                        .frame(width: 20, height: 20)
                }
                VStack {
                    VStack(alignment: .leading) {
                        
                        
                        // Slider for progress and seeking
                        Slider(
                            value: Binding(
                                get: { audioPlayerHelper.progress },
                                set: { newValue in
                                    audioPlayerHelper.seek(to: newValue)
                                }
                            ),
                            in: 0...1
                        )
                        .frame(height: 10)
                        .accentColor(.white) // Customize the color
                        .padding(.top, 20)
                        .padding(.bottom, 2)
                        Text(audioPlayerHelper.isPlaying ? audioPlayerHelper.currentTime : audioPlayerHelper.remainingTime)
                            .customFont(.medium, 13)
                            .foregroundStyle(.white)
                    }
                    .font(.caption)
                }
            }
            .padding(6)
            .padding(.horizontal)
            .background(.primaryTheme)
            .clipShape(.rect(cornerRadius: 12))
            .padding(.leading, 100)
            .padding(.trailing)
            .onAppear{
                if let audio = chat.recordingUrl{
                    audioPlayerHelper.prepareAudio(from: audio)
                }
                
            }
            
            VStack{
                HStack(spacing: 2){
                    Spacer()
                    Text(chat.time)
                        .customFont(.regular, 12)
                        .foregroundStyle(.primary.opacity(0.75))
                    Image(.checkRead)
                        .resizable()
                        .frame(width: 14, height: 14)
                        .padding(.trailing, 25)
                }
            }
        }
    }
}

#Preview {
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
    SenderAudioView(chat: message )
}
