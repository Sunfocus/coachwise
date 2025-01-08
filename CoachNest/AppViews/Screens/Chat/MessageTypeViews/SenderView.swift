//
//  SenderView.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 10/12/24.
//

import SwiftUI

struct SenderView: View {
    var chat: MessageDetail
    var body: some View {
        
        VStack(alignment: .trailing){
            HStack(alignment: .top){
                Spacer()
                VStack(alignment: .trailing){
                    Text(chat.message)
                        .customFont(.medium, 15)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                }
                .padding(10)
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
                        .foregroundStyle(.primary.opacity(0.75))
                    Image(.checkRead)
                        .resizable()
                        .frame(width: 14, height: 14)
                        .padding(.trailing, 42)
                }
            }
        }.padding(.trailing)
            .padding(.leading, 50)
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
    SenderView(chat: message)

}
