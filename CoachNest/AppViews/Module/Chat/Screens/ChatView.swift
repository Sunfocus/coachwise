//
//  ChatView.swift
//  CoachNest
//
//  Created by ios on 06/01/25.
//

import SwiftUI
import PhotosUI

struct ChatView: View {
    
    @EnvironmentObject var router: Router
    @StateObject private var chatViewModel = MessagesViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            VStack{
                topHeaderView
                    .padding()
                    .background(.darkGreyBackground)
                if chatViewModel.messages.isEmpty{
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
                    ScrollViewReader { scrollViewProxy in
                        ScrollView{
                            ForEach(chatViewModel.messages) { message in
                                switch message.messageType{
                                case .audio:
                                    SenderAudioView(chat: message)
                                case .image:
                                    SenderImageView(chat: message)
                                case .document:
                                    SenderView(chat: message)
                                case .text:
                                    SenderView(chat: message)
                                case .video:
                                    SenderView(chat: message)
                                }
                            }
                        }.safeAreaPadding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                            .scrollIndicators(.hidden)
                            .onChange(of: chatViewModel.messages.count) {
                                if let lastMessage = chatViewModel.messages.last {
                                    withAnimation {
                                        scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
                                    }
                                }
                            }
                    }
                }
                
                // User input field
                UserInputFieldView(
                    text: $chatViewModel.newMessage,
                    images: $chatViewModel.images,
                    photosPickerItems: $chatViewModel.photosPickerItems,
                    audioRecorder: chatViewModel.audioRecorderHelper,
                    placeholder: "Write a message...",
                    onSend: { messageType in
                        HapticFeedbackHelper.mediumImpact()
                        chatViewModel.sendMessage(messageType: messageType)
                        
                    }
                    )
                .padding()
                .background(.darkGreyBackground)
            }//end
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
            if colorScheme == .light{
                Divider()
            }
           
        }
    }
    
}

#Preview {
    ChatView()
}
