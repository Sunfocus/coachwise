//
//  AddActionViewModel.swift
//  CoachNest
//
//  Created by ios on 31/12/24.
//

import Foundation
import SwiftUI




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
        resetTitle()
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
    
    // Get an action by its Parent ID
    func getActionsByParentId(byId id: UUID) -> [AddAction]{
        return actions.filter { $0.goalId == id }
    }
    
    func sortActionByStatus(status: StatusOption, parentId: UUID) -> [AddAction]{
        let sortedActions =  actions.filter { $0.status == status }
        return sortedActions.filter { $0.goalId == parentId}
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
    
    func resetTitle(){
        actionName = ""
        taskDescription = ""
    }
}
