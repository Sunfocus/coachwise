//
//  ReceiverView.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 10/12/24.
//

import SwiftUI

struct ReceiverView: View {
    var chat: MessageDetail
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5){
            HStack(alignment: .top){
                Image(.f1)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .padding(.top, 7)
                VStack(alignment: .leading){
                    Text(chat.message)
                        .customFont(.medium, 15)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                }
                .padding(10)
                .background(.primary.opacity(0.4))
                .clipShape(.rect(cornerRadius: 8))
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
                        .padding(.trailing, 8)
                }
            }
        }.padding(.trailing, 80)
            .padding(.leading)
    }
}

#Preview {
    let message = MessageDetail(id: UUID(),
                                time: "10:40 PM",
                                message: "Hey! How are you doing? I was just thinking about the trip we planned last month. Let’s finalize the dates and start booking the tickets. Let me know what works for you!",
                                messageFrom: ChatMember(id: 123, name: "Max", profileImage: .sg1, accountType: .coach),
                                messageType: .text,
                                recordingUrl: nil,
                                sendImage: UIImage())
    
    ReceiverView(chat: message)

}
