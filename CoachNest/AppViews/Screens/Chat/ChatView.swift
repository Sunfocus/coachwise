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
                    }.safeAreaPadding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                        .scrollIndicators(.hidden)
                }
                // User input field
                UserInputFieldView(
                    text: $newMessage,
                    placeholder: "Write a message...",
                    onSend: {
                        HapticFeedbackHelper.mediumImpact()
                        guard !newMessage.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        sendMessage()
                    }
                    )
                .padding()
                .background(.white)
            }
        }.background(
            Image(.chatBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
            .navigationBarBackButtonHidden()
    }
    
    var topHeaderView: some View{
        VStack{
            HStack{
                Image(.arrowBack)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        router.dashboardNavigateBack()
                    }
                Image(.sg1)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 0){
                    Text("James Walter")
                        .customFont(.bold, 16)
                        .lineLimit(1)
                    Text("Last seen 2 hr ago")
                        .customFont(.medium, 12)
                }
                Spacer()
                HStack(spacing: 15){
                    Image(.phone)
                        .resizable()
                        .frame(width: 22, height: 22)
                    
                    Image(.more)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            Divider()
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
