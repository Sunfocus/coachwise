//
//  GoalDetails.swift
//  CoachNest
//
//  Created by Rahul Pathania on 04/02/25.
//

import SwiftUI

struct GoalDetails: Codable, Hashable, Identifiable {
    let id: UUID
    let goalTitle: String
    let createdBy: MemberDetail
    let updateDate: Date
    var cellType: GoalType
    var savedMembers: [MemberDetail]
    var description: String
    var dueOnDate: Date
    var reminder: DurationVal

    init(
        id: UUID = UUID(),
        goalTitle: String,
        updateDate: Date,
        createdBy: MemberDetail,
        cellType: GoalType = .group,
        savedMembers: [MemberDetail],
        description: String,
        dueOnDate: Date,
        reminder: DurationVal
        
    ) {
        self.id = id
        self.goalTitle = goalTitle
        self.updateDate = updateDate
        self.createdBy = createdBy
        self.cellType = savedMembers.count > 1 ? .group : .individual
        self.savedMembers = savedMembers
        self.description = description
        self.dueOnDate = dueOnDate
        self.reminder = reminder
    }
}
