//
//  RecentMessagesDataView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 27/12/24.
//

import SwiftUI

// MARK: - Recent Messages Component View
struct RecentMessagesDataView: View {
    let recentMessages: [Messages]
    var body: some View {
        VStack {
            HStack {
                ForEach(recentMessages.prefix(2), id: \.self) { recentMessage in
                    VStack(spacing: 6) {
                        Text(recentMessage.lastMessage ?? "")
                            .customFont(.regular, 14)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 4)
                            .padding(.top, 4)
                        HStack(spacing: 4) {
                            Image(recentMessage.senderImage ?? "-")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Text(recentMessage.senderName ?? "-")
                                .customFont(.medium, 12)
                                .lineLimit(2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .frame(height: 76)
                .padding(.horizontal)
                .background(.darkGreyBackground)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 2, y: 2)
            }
        }.padding(.horizontal, 8)
            .padding(.bottom, 12)
    }
}
