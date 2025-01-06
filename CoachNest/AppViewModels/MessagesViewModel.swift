//
//  MessagesViewModel.swift
//  CoachNest
//
//  Created by ios on 06/01/25.
//

import SwiftUI


enum MessageType: Codable{
    case text
    case audio
    case video
    case image
}

struct MessageDetail: Codable{
    let id: UUID
    let time: String
    let message: String
    let messageFrom: MemberDetail
    let messageTo: MemberDetail
    let messageType: MessageType
    
    init(id: UUID, time: String, message: String, messageFrom: MemberDetail, messageTo: MemberDetail, messageType: MessageType) {
        self.id = id
        self.time = time
        self.message = message
        self.messageFrom = messageFrom
        self.messageTo = messageTo
        self.messageType = messageType
    }
}




class MessagesViewModel: ObservableObject{
    
    @Published var messages: [MessageDetail] = []
    
    func sendMessage(message: MessageDetail){
        messages.append(message)
    }
}
