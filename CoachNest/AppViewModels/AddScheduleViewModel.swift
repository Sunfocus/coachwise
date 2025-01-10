//
//  AddScheduleViewModel.swift
//  CoachNest
//
//  Created by ios on 10/01/25.
//

import SwiftUI


enum EventRecurrence: Hashable {
    case onetime
    case weekly([Week])
}

enum Week: String, CaseIterable, Hashable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

struct ScheduleDetail: Hashable, Identifiable {
    let id: UUID
    let eventTitle: String
    let eventType: String
    let eventRecurrence: EventRecurrence

    init(
        id: UUID = UUID(),
        eventTitle: String,
        eventType: String,
        eventRecurrence: EventRecurrence
    ) {
        self.id = id
        self.eventTitle = eventTitle
        self.eventType = eventType
        self.eventRecurrence = eventRecurrence
    }
}
