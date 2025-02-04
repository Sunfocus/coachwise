//
//  NotificationRowCell.swift
//  CoachNest
//
//  Created by ios on 03/01/25.
//

import SwiftUI

struct NotificationsRowCell: View {
    var notification: NotificationInfo
    var time: String
    
    var body: some View {
        ZStack {
            HStack {
                Image(uiImage: .notification)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .scaledToFill()
                    
                VStack {
                    HStack {
                        Text(notification.notificationText)
                            .customFont(.regular, 16)
                            .lineLimit(2)
                        Spacer()
                        Text(time)
                            .customFont(.medium, 14)
                            .foregroundStyle(.gray)
                            
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding()
            .background(.darkGreyBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            .padding(.bottom, 2)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            
        }
    }
}

#Preview {
    let notify = NotificationInfo(id: UUID(), notificationText: "ffdsf fdsfdsf  fdsfdsff f dsfdsf fdsfdsf fdsfds", notificationDate: "Feb 03, 2025")
    NotificationsRowCell(notification: notify, time: "04:00 PM")
}
