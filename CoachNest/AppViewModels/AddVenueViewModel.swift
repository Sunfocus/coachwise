//
//  AddVenueViewModel.swift
//  CoachNest
//
//  Created by ios on 13/01/25.
//

import Foundation

class AddVenueViewModel: ObservableObject {
   
    @Published var venueName = ""
    @Published  var address: String = ""
    @Published  var meetingName: String = ""
    @Published  var meetingLink: String = ""
    @Published var selectedSegment = 0

    private func addVenue(){
        
    }
}
