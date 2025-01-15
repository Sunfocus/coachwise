//
//  AddEventTypeViewModel.swift
//  CoachNest
//
//  Created by ios on 14/01/25.
//
import SwiftUI

class AddEventTypeViewModel: ObservableObject {
    
    @Published var eventType = ""
    @Published var eventTypes = ["Conference", "Workshop", "Webinar", "Meetup"]
    
    
    func addEventType(){
        if !eventType.isEmpty{
            eventTypes.append(eventType)
        }else{
            print("event type is required")
        }
    }
}
