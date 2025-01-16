//
//  MessagesViewModel.swift
//  CoachNest
//
//  Created by ios on 06/01/25.
//

import SwiftUI
import PhotosUI


enum MessageType: Codable{
    case text
    case image
    case audio
    case video
    case document
}

struct MessageDetail: Codable,Hashable,Identifiable{
    let id: UUID
    let time: String
    let message: String
    let sendImageData: Data
    let recordingUrl: URL?
    let messageFrom: ChatMember
    let messageType: MessageType
    var sendImage: UIImage? {
        UIImage(data: sendImageData)
    }
    
    init(id: UUID, time: String, message: String, messageFrom: ChatMember, messageType: MessageType, recordingUrl: URL?, sendImage: UIImage) {
        self.id = id
        self.time = time
        self.message = message
        self.messageFrom = messageFrom
        self.messageType = messageType
        self.recordingUrl = recordingUrl
        self.sendImageData = sendImage.jpegData(compressionQuality: 1.0) ?? Data()
    }
}

public struct ChatMember: Codable, Hashable, Identifiable {
    public let id: Int
    let name: String
    let profileImageData: Data
    let accountType: AccountType
    var profileImage: UIImage? {
        UIImage(data: profileImageData)
    }

    init(id: Int, name: String, profileImage: UIImage, accountType: AccountType) {
        self.id = id
        self.name = name
        self.profileImageData = profileImage.jpegData(compressionQuality: 1.0) ?? Data()
        self.accountType = accountType
    }
}




class MessagesViewModel: ObservableObject{
    
    @Published var messages: [MessageDetail] = []
    @Published var newMessage: String = ""
    @Published var images: [UIImage] = []
    @Published var photosPickerItems: [PhotosPickerItem] = []
    @Published var audioRecorderHelper = AudioRecorderHelper()
    
    func sendMessage(message: MessageDetail){
        messages.append(message)
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
    }//end
}

//Use this when you will upload data and get url from the server


//enum MessageType: String, Codable {
//    case text
//    case image
//    case audio
//    case video
//    case document
//}
//
//enum MessageContent: Codable {
//    case text(String)
//    case image(URL)
//    case audio(URL)
//    case video(URL)
//    case document(URL)
//}
//
//struct MessageDetail: Codable, Hashable, Identifiable {
//    let id: UUID
//    let time: String
//    let messageType: MessageType
//    let messageFrom: ChatMember
//    let content: MessageContent // Use enum to hold different content types
//    let recordingUrl: URL? // Used specifically for audio messages
//    
//    init(id: UUID, time: String, messageType: MessageType, messageFrom: ChatMember, content: MessageContent, recordingUrl: URL? = nil) {
//        self.id = id
//        self.time = time
//        self.messageType = messageType
//        self.messageFrom = messageFrom
//        self.content = content
//        self.recordingUrl = recordingUrl
//    }
//    
//    // Convenience function to extract content if it's text
//    func getText() -> String? {
//        if case let .text(message) = content {
//            return message
//        }
//        return nil
//    }
//
//    // Convenience function to extract the URL if it's an image, audio, or video
//    func getMediaURL() -> URL? {
//        switch content {
//        case .image(let url), .audio(let url), .video(let url), .document(let url):
//            return url
//        default:
//            return nil
//        }
//    }
//}
