//
//  AddAction.swift
//  CoachNest
//
//  Created by Rahul Pathania on 04/02/25.
//
import SwiftUI

enum StatusOption: String, CaseIterable, Codable{
    case todo = "To do"
    case inProgress = "In progress"
    case completed = "Completed"
}

struct AddAction: Codable, Hashable, Identifiable{
    let id: UUID
    let goalId: UUID
    let actionTitle: String
    let updatedDate: Date
    var dueOnDate: Date
    var assignedBy: MemberDetail
    var assignedTo: MemberDetail
    var description: String
    var status: StatusOption
    var attachedDocs: Int
    var attachedImages: [Data]
    
    init(id: UUID, goalId: UUID, actionTitle: String, updatedDate: Date, dueOnDate: Date, assignedBy: MemberDetail,  assignedTo: MemberDetail, description: String, status: StatusOption, attachedDocs: Int, attachedImages: [Data]) {
        self.id = id
        self.goalId = goalId
        self.actionTitle = actionTitle
        self.updatedDate = updatedDate
        self.dueOnDate = dueOnDate
        self.assignedBy = assignedBy
        self.assignedTo = assignedTo
        self.description = description
        self.status = status
        self.attachedDocs = attachedDocs
        self.attachedImages = attachedImages
    }
}
