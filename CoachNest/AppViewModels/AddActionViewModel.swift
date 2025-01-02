//
//  AddActionViewModel.swift
//  CoachNest
//
//  Created by ios on 31/12/24.
//

import Foundation
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


class AddActionViewModel: ObservableObject {
    
    enum AddActionViewModelValidationErrors: LocalizedError {
        case emptyActionTitle
        case emptyDescription
        
        var errorDescription: String? {
            switch self {
            case .emptyActionTitle:
                return "Action title is required."
            case .emptyDescription:
                return "Description is required."
            }
        }
    }
    @Published var actionName: String = ""
    @Published var taskDescription: String = ""
    
    @Published var actions: [AddAction] = []
    
    // Add a new action
    func addAction(action: AddAction) {
        actions.append(action)
    }
    // Delete an action by its ID
    func deleteAction(byId id: UUID) {
        actions.removeAll { $0.id == id }
    }
    
    func updateActionStatus(byId id: UUID, status: StatusOption ){
        if let index = actions.firstIndex(where: { $0.id == id }) {
            actions[index].status = status
        }
    }
    
    
    // Edit an action by its ID
    func editAction(byId id: UUID, updatedAction: AddAction) {
        if let index = actions.firstIndex(where: { $0.id == id }) {
            actions[index] = updatedAction
        }
    }
    // Get an action by its ID
    func getAction(byId id: UUID) -> AddAction? {
        return actions.first(where: { $0.id == id })
    }
    
    // Get an action by its status
    func getActions(by status: StatusOption) -> [AddAction] {
           return actions.filter { $0.status == status }
       }
    
    func isValidateForm() -> Bool {
        if actionName.isEmpty {
            return false
        }
        if taskDescription.isEmpty {
            return false
        }
        return true
    }
    
    func getValidationErrors() -> [AddActionViewModelValidationErrors] {
        var errors: [AddActionViewModelValidationErrors] = []
        if actionName.isEmpty {
            errors.append(.emptyActionTitle)
        }
        if taskDescription.isEmpty {
            errors.append(.emptyDescription)
        }
        return errors
    }
}
