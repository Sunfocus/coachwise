//
//  ChatProtocol.swift
//  CoachNest
//
//  Created by ios on 08/01/25.
//

import SwiftUI

protocol Displayable: Identifiable{
    associatedtype Representation: View
    var chat: MessageDetail { get }
    var representation: Representation { get }
}

struct SenderTextMessage: Displayable{
    var chat: MessageDetail
    let id: Int
    var representation: some View { SenderView(chat: chat) }
}

struct ReceiverTextMessage: Displayable{
    var chat: MessageDetail
    let id: Int
    var representation: some View { ReceiverView(chat: chat) }
}
