//
//  SendAudioView.swift
//  CoachNest
//
//  Created by ios on 07/01/25.
//

import SwiftUI

struct SendAudioView: View {
    
    @State private var isPlaying: Bool = false
    
    
    var body: some View {
        HStack{
            
            Image(.f1)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(.circle)
                .padding(.trailing, 10)
             
            Button {
                print("play/pause the audio")
                isPlaying.toggle()
            } label: {
                Image( systemName: ( isPlaying ? "pause.fill" :"play.fill"))
                    .tint(.white)
            }
            
            
            
            
            
            Spacer()

        }
        .padding()
        .background(.primaryTheme)
        .clipShape(.rect(cornerRadius: 12))
        .padding(.horizontal)
        
    }
}

#Preview {
    SendAudioView()
}
