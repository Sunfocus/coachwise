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
                        .customFont(.regular, 14)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .background(.backgroundTheme)
                .clipShape(.rect(cornerRadius: 10))
                Image(.sg1)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
               
            }
            
            VStack{
                Text(chat.time)
                    .customFont(.regular, 12)
                    .padding(.trailing, 45)
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
