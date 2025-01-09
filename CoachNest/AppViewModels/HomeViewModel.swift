//
//  HomeViewModel.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 26/12/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var schedule: [ScheduleEvent]?
    @Published var recentMessages: [Messages]?
    @Published var memories: [String]?
    @Published var goals: [Goals]?

    init(schedule: [ScheduleEvent]? = nil, recentMessages: [Messages]? = nil, memories: [String]? = nil,
        goals: [Goals]? = nil) {
        self.schedule = schedule
        self.recentMessages = recentMessages
        self.memories = memories
        self.goals = goals
    }
}

struct ScheduleEvent: Identifiable, Hashable {
    var id = UUID()
    let eventName: String?
    let startTime: String?
    let endTime: String?
    let eventDate: String?
    let images: [String] = ["placeholder", "placeholder", "placeholder"]
}

struct Messages: Identifiable, Hashable {
    var id = UUID()
    let senderName: String?
    let senderImage: String?
    let lastMessage: String?
}

struct Goals: Identifiable, Hashable {
    var id = UUID()
    let goalPercentageValue: String?
    let goalAchieverName: String?
    let goalAchieverImage: String?
    let lastUpdatedDate: String?
    let goalTitle: String?
}
