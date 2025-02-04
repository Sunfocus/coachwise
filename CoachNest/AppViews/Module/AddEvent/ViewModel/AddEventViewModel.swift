//
//  AddScheduleViewModel.swift
//  CoachNest
//
//  Created by ios on 10/01/25.
//

import SwiftUI

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
    
    let reccuringDays = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    let memberLimits = Array(20...300).map { String($0) }
    
    private func addEvent(){
        
    }
    
}

