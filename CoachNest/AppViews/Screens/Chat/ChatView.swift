//
//  ChatView.swift
//  CoachNest
//
//  Created by ios on 06/01/25.
//

import SwiftUI

struct ChatMessage: Identifiable, Hashable{
    var id: UUID = UUID()
    var message: String
    var time: String
}

struct ChatView: View {
    
    @EnvironmentObject var router: Router
    @State private var newMessage: String = ""
    @State private var messages: [ChatMessage] = []
    
    
    var body: some View {
        ZStack{
            VStack{
                topHeaderView
                    .padding()
                    .background(.white)
                
                if messages.isEmpty{
                    VStack(spacing: 15){
                        Spacer()
                        Image(.noMessage)
                            .resizable()
                            .frame(width: 50, height: 50)
                           
                         Text("No Chats available, Send a message to start a chat")
                            .customFont(.regular, 15)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .foregroundStyle(.cursorTint)
                        Spacer()
                    }
                }else{
                    ScrollView{
                        ForEach(messages) { message in
                            SenderView(chat: message)
                        }
                    }.safeAreaPadding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                        .scrollIndicators(.hidden)
                }
                // User input field
                UserInputFieldView(
                    text: $newMessage,
                    placeholder: "Write a message...",
                    actionButtonImage: Image(systemName: "paperplane.fill"),
                    onSend: {
                        guard !newMessage.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        sendMessage()
                        HapticFeedbackHelper.mediumImpact()
                    }
                    )
            }
        }.background(.primaryTheme.opacity(0.05))
            .navigationBarBackButtonHidden()
    }
    
    var topHeaderView: some View{
        HStack{
            Image(.arrowBack)
                .resizable()
                .frame(width: 25, height: 25)
                .onTapGesture {
                    router.dashboardNavigateBack()
                }
            Image(.sg1)
                .resizable()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 0){
                Text("James Walter")
                    .customFont(.semiBold, 16)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                Text("Last seen 2 hr ago")
                    .customFont(.regular, 13)
                    .foregroundStyle(.white)
            }
            Spacer()
            HStack(spacing: 20){
                Image(.phone)
                    .resizable()
                    .frame(width: 25, height: 25)

                Image(.more)
                    .resizable()
                    .frame(width: 22, height: 22)
            }
        }
    }
    
    
    func sendMessage() {
           guard !newMessage.isEmpty else { return }
           let currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
           let newChatMessage = ChatMessage(message: newMessage, time: currentTime)
           messages.append(newChatMessage)
           newMessage = ""
       }
}

#Preview {
    ChatView()
}
