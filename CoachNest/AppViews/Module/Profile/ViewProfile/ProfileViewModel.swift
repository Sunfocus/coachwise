//
//  ProfileViewModel.swift
//  CoachNest
//
//  Created by Rahul Pathania on 31/01/25.
//

import Foundation


enum ProfileDetailsSegmentType: String, CaseIterable, Identifiable {
    case details = "Details"
    case events = "Events"
    case evaluations = "Evaluations"
    case payments = "Payments"
    case notes = "Notes"
    var id: String { self.rawValue }
    
}

class ProfileViewModel: ObservableObject {
    @Published var selectedSegment: ProfileDetailsSegmentType = .details
    @Published var enterNotes: String = ""
    @Published var enterBio: String = ""
}
