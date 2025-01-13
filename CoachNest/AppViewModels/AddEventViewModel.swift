//
//  AddScheduleViewModel.swift
//  CoachNest
//
//  Created by ios on 10/01/25.
//

import SwiftUI


enum RecurrenceType: String, CaseIterable {
    case once = "One time"
    case recurring = "Recurring"
}


enum Week: String, CaseIterable, Hashable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

struct ScheduleDetail: Hashable, Identifiable {
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


class AddEventViewModel: ObservableObject {
   
    @Published var eventName = ""
    @Published  var selectedEventType: String = ""
    @Published  var selectedVenueType: String = ""
    @Published  var selectedReccuringDays: [String] = []
    @Published  var selectedMemberLimit: String = ""
    @Published  var selectedRecurrenceType: RecurrenceType = .recurring
    @Published  var onetimeDate = Date.now
    @Published  var fromDate = Date.now
    @Published  var toDate = Date.now
    @Published var searchedText = ""
    let eventTypes = ["Conference", "Workshop", "Webinar", "Meetup"]
    let venueTypes = ["Kharar", "Sohana", "Shahi Majra", "Phase 5, Mohali"]
    let reccuringDays = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    let memberLimits = Array(20...300).map { String($0) }
    
    
    
    
    private func addEvent(){
        
    }
    
    
}
