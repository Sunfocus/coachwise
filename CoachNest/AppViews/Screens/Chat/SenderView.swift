//
//  SenderView.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 10/12/24.
//

import SwiftUI

struct SenderView: View {
    var chat: ChatMessage
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
                HStack(spacing: 5){
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
        }.padding(.trailing, 10)
            .padding(.leading, 50)
    }
}

#Preview {
    SenderView(chat: ChatMessage(
        message: "Hey! How are you doing? I was just thinking about the trip we planned last month. Let’s finalize the dates and start booking the tickets. Let me know what works for you!",
        time: "10:40 PM"
    ))

}
