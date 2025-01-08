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
    @State private var newMessage: String = ""
    @State private var messages: [MessageDetail] = []
    @State private var images: [UIImage] = []
    @State private var photosPickerItems: [PhotosPickerItem] = []
    @StateObject private var audioRecorderHelper = AudioRecorderHelper()
    
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
                    ScrollViewReader { scrollViewProxy in
                        ScrollView{
                            ForEach(messages) { message in
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
                            .onChange(of: messages.count) {
                                if let lastMessage = messages.last {
                                    withAnimation {
                                        scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
                                    }
                                }
                            }
                    }
                }
                
                
                // User input field
                UserInputFieldView(
                    text: $newMessage,
                    images: $images,
                    photosPickerItems: $photosPickerItems,
                    audioRecorder: audioRecorderHelper,
                    placeholder: "Write a message...",
                    onSend: { messageType in
                        HapticFeedbackHelper.mediumImpact()
                        sendMessage(messageType: messageType)
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
    func sendMessage(messageType: MessageType) {
        
        if messageType == .audio{
            if let recordingURL = audioRecorderHelper.getRecordingURL() {
                print("Recording URL: \(recordingURL)")
                let currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
                let newChatMessage = MessageDetail(id: UUID(),
                                                   time: currentTime,
                                                   message: "",
                                                   messageFrom: ChatMember(id: 123, name: "Max", profileImage: .sg1, accountType: .coach),
                                                   messageType: messageType, recordingUrl: recordingURL,
                                                   sendImage: UIImage())
                messages.append(newChatMessage)
            } else {
                print("No recording URL available.")
            }
        }
        
        if messageType == .text{
            guard !newMessage.isEmpty else { return }
            let currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
            let newChatMessage = MessageDetail(id: UUID(),
                                               time: currentTime,
                                               message: newMessage,
                                               messageFrom: ChatMember(id: 123, name: "Max", profileImage: .sg1, accountType: .coach),
                                               messageType: messageType, recordingUrl: nil, sendImage: UIImage())
            messages.append(newChatMessage)
            newMessage = ""
        }
        
        if messageType == .image{
            for img in images{
                let currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
                let newChatMessage = MessageDetail(id: UUID(),
                                                   time: currentTime,
                                                   message: "",
                                                   messageFrom: ChatMember(id: 123, name: "Max", profileImage: .sg1, accountType: .coach),
                                                   messageType: messageType, recordingUrl: nil, sendImage: img)
                messages.append(newChatMessage)
            }
            images = []
            photosPickerItems = []
        }
    }
}

#Preview {
    ChatView()
}
