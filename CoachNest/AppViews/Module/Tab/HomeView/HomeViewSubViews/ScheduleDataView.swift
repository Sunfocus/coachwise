//
//  ScheduleDataView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 27/12/24.
//

import SwiftUI

// MARK: - Schedule View
struct ScheduleDataView: View {
    
    let schedule: ScheduleEvent
    var body: some View {
        VStack {
            ScheduleRow(scheduleEvent: schedule)
                
        }
        .frame(height: 86)
        .padding(10)
        .background(.darkGreyBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Schedule Row
struct ScheduleRow: View {
    let scheduleEvent: ScheduleEvent
    
    var body: some View {
        VStack(spacing: 5) {
            // Time row
            HStack(spacing: 5) {
                Image(.clock)
                    .resizable()
                    .frame(width: 13, height: 13)
                Text("\(scheduleEvent.startTime ?? "-") - \(scheduleEvent.endTime ?? "-")")
                    .customFont(.regular, 13)
                Spacer()
            }
            
            // Event name
            Text(scheduleEvent.eventName ?? "-")
                .customFont(.medium, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Members and date row
            HStack(spacing: 5) {
                ScheduleMemberView(memberImages: scheduleEvent.images)
                Spacer()
                Image(.addSchedule)
                    .resizable()
                    .frame(width: 12, height: 12)
                Text(scheduleEvent.eventDate ?? "-")
                    .customFont(.regular, 14)
            }
        }.padding(.horizontal, 7)
    }
}

// MARK: - Schedule Member Horizontal Stack View
struct ScheduleMemberView: View {
    let memberImages: [String]?
    var body: some View {
        HStack(spacing: -8) {
            // Dynamically generate image views
            ForEach(memberImages!, id: \.self) { image in
                Image(image)
                    .resizable()
                    .frame(width: 22, height: 22)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 1)
                    )
            }
            // Add the last text element
            Text("\(20)+")
                .customFont(.regular, 10)
                .frame(width: 22, height: 22)
                .background(.darkGreyBackground)
                
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 1)
                )
        }
    }
}
