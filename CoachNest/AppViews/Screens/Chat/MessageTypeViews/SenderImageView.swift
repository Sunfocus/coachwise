//
//  SenderImageView.swift
//  CoachNest
//
//  Created by ios on 08/01/25.
//

import SwiftUI

struct SenderImageView: View {
    
    var chat: MessageDetail
    @State private var isImageTapped = false
    
    var body: some View {
        VStack(alignment: .trailing){
            HStack(alignment: .top){
                Spacer()
                VStack(alignment: .trailing){
                    Image(uiImage: chat.sendImage ?? .sg1)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(.rect(cornerRadius: 8))
                        .onTapGesture {
                            isImageTapped.toggle()
                        }
                }
                .padding(3)
                .background(.primaryTheme)
                .clipShape(.rect(cornerRadius: 8))
                Image(.sg1)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .padding(.top, 7)
            }
            
            VStack{
                HStack(spacing: 2){
                    Spacer()
                    Text(chat.time)
                        .customFont(.regular, 12)
                        .foregroundStyle(.primary.opacity(0.8))
                    Image(.checkRead)
                        .resizable()
                        .frame(width: 14, height: 14)
                        .padding(.trailing, 42)
                }
            }
        }.padding(.trailing)
            .padding(.leading, 50)
            .sheet(isPresented: $isImageTapped) {
                // Show enlarged image in a new sheet
                ZStack{
                    
                    Color.white.ignoresSafeArea()
                    
                    
                    VStack {
                        Image(uiImage: chat.sendImage ?? .sg1)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                            .background(Color.black.opacity(0.1))
                            .cornerRadius(12)
                    }
                }
                
            }
    }
}
  
#Preview {
    let message = MessageDetail(id: UUID(),
                                time: "10:40 PM",
                                message: "",
                                messageFrom: ChatMember(id: 123, name: "Max", profileImage: .sg1, accountType: .coach),
                                messageType: .image,
                                recordingUrl: nil,
                                sendImage: UIImage())
    SenderImageView(chat: message)
}
