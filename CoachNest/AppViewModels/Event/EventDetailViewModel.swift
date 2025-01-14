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
    case other = "Other" // Example additional option

    var id: String { self.rawValue }
}

class EventDetailViewModel: ObservableObject {
   
    @Published var selectedSegment: SegmentType = .attendance
    @Published var status: StatusOption = .todo
    @Published var attendance: [String] = []
    
}
