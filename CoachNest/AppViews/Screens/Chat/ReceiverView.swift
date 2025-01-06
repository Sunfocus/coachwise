//
//  ReceiverView.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 10/12/24.
//

import SwiftUI

struct ReceiverView: View {
    
    var chat: ChatMessage
    
    var body: some View {
        
        HStack(alignment: .top){
            Spacer()
            VStack{
                Image(.sg1)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                
            }
            
            HStack(alignment: .bottom){
                Text(chat.message)
                    .customFont(.regular, 16)
                    .multilineTextAlignment(.leading)
                Text(chat.time)
                    .customFont(.regular, 12)
                  
            }
            .padding()
            .background(.primaryTheme.opacity(0.3))
            .clipShape(.rect(cornerRadius: 10))
        }
    }
}

#Preview {
    ReceiverView(chat: ChatMessage(
        message: "Hey! How are you doing? I was just thinking about the trip we planned last month. Let’s finalize the dates and start booking the tickets. Let me know what works for you!",
        time: "10:40 PM"
    ))

}
