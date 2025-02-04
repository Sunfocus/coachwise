//
//  EventDetails.swift
//  CoachNest
//
//  Created by Rahul Pathania on 04/02/25.
//

import SwiftUI

enum RecurrenceType: String, CaseIterable {
    case once = "One time"
    case recurring = "Recurring"
}

struct EventDetail: Hashable, Identifiable {
    let id: UUID
    let eventTitle: String
    let eventType: String
    let eventRecurrence: RecurrenceType

    init(
        id: UUID = UUID(),
        eventTitle: String,
        eventType: String,
        eventRecurrence: RecurrenceType
    ) {
        self.id = id
        self.eventTitle = eventTitle
        self.eventType = eventType
        self.eventRecurrence = eventRecurrence
    }
}

