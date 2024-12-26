//
//  GoalsViewModel.swift
//  CoachNest
//
//  Created by ios on 26/12/24.
//
import SwiftUI

public class AddGoalViewModel: ObservableObject {
    // Published property to notify views of changes
    @Published var goals: [GoalDetails] = []
    

    // Add a new goal to the array
    func addGoal(_ goal: GoalDetails) {
        goals.append(goal)
        print("goal saved success")
    }
    
    func checkValidGoalName(goalName: String) -> Bool{
        return !goalName.isEmpty
    }
    

    // Retrieve a goal by ID
    func getGoal(byID id: UUID) -> GoalDetails? {
        return goals.first(where: { $0.id == id })
    }
    
    // Retrieve all goals
    func getAllGoals() -> [GoalDetails] {
        return goals
    }

    // Delete a goal by ID
    func deleteGoal(byID id: UUID) {
        goals.removeAll(where: { $0.id == id })
    }
}

public enum DurationVal: String, Equatable, Codable {
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
}

struct GoalDetails: Codable, Hashable, Identifiable {
    let id: UUID
    let progress: Double
    let goalTitle: String
    let updateDate: Date
    var cellType: GoalType
    var savedMembers: [MemberDetail]
    var description: String
    var dueOnDate: Date
    var reminder: DurationVal

    init(
        id: UUID = UUID(),
        progress: Double,
        goalTitle: String,
        updateDate: Date,
        cellType: GoalType = .group,
        savedMembers: [MemberDetail],
        description: String,
        dueOnDate: Date,
        reminder: DurationVal
        
    ) {
        self.id = id
        self.progress = progress
        self.goalTitle = goalTitle
        self.updateDate = updateDate
        self.cellType = savedMembers.count > 1 ? .group : .individual
        self.savedMembers = savedMembers
        self.description = description
        self.dueOnDate = dueOnDate
        self.reminder = reminder
    }
}






