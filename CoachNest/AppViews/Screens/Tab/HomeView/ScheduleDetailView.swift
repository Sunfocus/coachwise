//
//  ScheduleDetailView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 27/12/24.
//

import SwiftUI

struct ScheduleDetailView: View {
 let schedule = [ScheduleEvent(eventName: "Yoga Class", startTime: "10:00 AM", endTime: "11:00 AM", eventDate: "28 Nov 2024"), ScheduleEvent(eventName: "History Class", startTime: "10:00 AM", endTime: "11:00 AM", eventDate: "28 Nov 2024"), ScheduleEvent(eventName: "Science Class", startTime: "10:00 AM", endTime: "11:00 AM", eventDate: "28 Nov 2024"), ScheduleEvent(eventName: "Yoga Class", startTime: "10:00 AM", endTime: "11:00 AM", eventDate: "28 Nov 2024"), ScheduleEvent(eventName: "History Class", startTime: "10:00 AM", endTime: "11:00 AM", eventDate: "28 Nov 2024"), ScheduleEvent(eventName: "Science Class", startTime: "10:00 AM", endTime: "11:00 AM", eventDate: "28 Nov 2024"), ScheduleEvent(eventName: "Yoga Class", startTime: "10:00 AM", endTime: "11:00 AM", eventDate: "28 Nov 2024"), ScheduleEvent(eventName: "History Class", startTime: "10:00 AM", endTime: "11:00 AM", eventDate: "28 Nov 2024"), ScheduleEvent(eventName: "Science Class", startTime: "10:00 AM", endTime: "11:00 AM", eventDate: "28 Nov 2024")]
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(schedule, id: \.self) { scheduleEvent in
                        ScheduleDataView(schedule: scheduleEvent)
                    }
                }.background(.white)
            }
        }
    }
}

#Preview {
    ScheduleDetailView()
}
