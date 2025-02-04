//
//  MessageDetail.swift
//  CoachNest
//
//  Created by Rahul Pathania on 04/02/25.
//

import Foundation
import SwiftUI


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
