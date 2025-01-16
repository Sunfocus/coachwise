//
//  EventDetailViewModel.swift
//  CoachNest
//
//  Created by ios on 14/01/25.
//

import SwiftUI

enum SegmentType: String, CaseIterable, Identifiable {
    case details = "Details"
    case attendance = "Attendance"
    case notes = "Notes"
    case actions = "Actions"
    case messages = "Messages"
    case memories = "Memories"
    var id: String { self.rawValue }
}

struct EventNote: Identifiable, Codable, Hashable{
    let id: UUID
    let name: String
    let accountType: AccountType
    let note: String
}

class EventDetailViewModel: ObservableObject {
   
    var eventId: UUID = UUID()
    @Published var selectedSegment: SegmentType = .actions
    @Published var status: StatusOption = .todo
    @Published var isMarkAllAsAttended: Bool = false
    @Published var isTextFieldFocused: Bool = false
    @Published var note: String = ""
    @Published var eventAttendees: [Attendee] = [
        Attendee(id: UUID(), name: "Max Walter", rating: 4, contactNumber: "7685756849", hasAttendedClass: false, profilePicture: .sg1),
        Attendee(id: UUID(), name: "Max Walter", rating: 4, contactNumber: "7685756849", hasAttendedClass: false, profilePicture: .sg1),
        Attendee(id: UUID(), name: "Max Walter", rating: 4, contactNumber: "7685756849", hasAttendedClass: false, profilePicture: .sg1),
        Attendee(id: UUID(), name: "Max Walter", rating: 4, contactNumber: "7685756849", hasAttendedClass: false, profilePicture: .sg1),
        Attendee(id: UUID(), name: "Max Walter", rating: 4, contactNumber: "7685756849", hasAttendedClass: false, profilePicture: .sg1)
    ]
    @Published var selectedMember = [
        MemberDetail(id: 01, name: "Rahul", profileImage: .sg1, accountType: .coach, progress: 0.0),
        MemberDetail(id: 02, name: "Rahul", profileImage: .f1, accountType: .coach, progress: 0.0),
        MemberDetail(id: 01, name: "Rahul", profileImage: .sg1, accountType: .coach, progress: 0.0),
        MemberDetail(id: 02, name: "Rahul", profileImage: .f1, accountType: .coach, progress: 0.0),
        MemberDetail(id: 01, name: "Rahul", profileImage: .sg1, accountType: .coach, progress: 0.0),
        MemberDetail(id: 02, name: "Rahul", profileImage: .f1, accountType: .coach, progress: 0.0)
    ]
    @Published var eventNotes: [EventNote] = [ EventNote(id: UUID(),
                                                         name: "Max Collins",
                                                         accountType: .coach,
                                                         note: "Cone Weaving: Set up cones in a straight line and weave through them using both feet. Focus on close control."
                                                        )]
    
    func markAttendance(id: UUID, hasAttended: Bool) {
        if let index = eventAttendees.firstIndex(where: { $0.id == id }) {
            eventAttendees[index].hasAttendedClass = hasAttended
        }
    }
    func markAllAsAttended() {
        isMarkAllAsAttended.toggle()
        for index in eventAttendees.indices {
            eventAttendees[index].hasAttendedClass = isMarkAllAsAttended
        }
    }
    func addNote(note: EventNote){
        eventNotes.append(note)
        self.note = ""
    }
}
