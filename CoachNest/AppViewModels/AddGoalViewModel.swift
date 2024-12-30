//
//  GoalsViewModel.swift
//  CoachNest
//
//  Created by ios on 26/12/24.
//
import SwiftUI

public class AddGoalViewModel: ObservableObject {
    // Published property to notify views of changes
    @Published var goals: [GoalDetails] = [
        GoalDetails(goalTitle: "Learn Swift", updateDate: Date(), savedMembers: [.init(id: 1, name: "Alice Anderson", profileImage: .sg1, accountType: .member, progress: 45.0),.init(id: 2, name: "Amanda", profileImage: .f1, accountType: .member, progress: 12.0), ], description: "play with swift", dueOnDate: Date(), reminder: .daily),
        
        GoalDetails(goalTitle: "Learn Piano", updateDate: Date(), savedMembers: [.init(id: 2, name: "Amanda", profileImage: .f1, accountType: .member, progress: 12.0), ], description: "play with swift", dueOnDate: Date(), reminder: .daily)
    ]
    
    
    // Add a new goal to the array
    func addGoal(_ goal: GoalDetails) {
        goals.append(goal)
        print("goal saved success")
    }
    
    
    func updateGoalMembers(goalId: UUID, members: [MemberDetail]) {
        // Find the index of the goal with the given ID
        let count = members.count
        if let index = goals.firstIndex(where: { $0.id == goalId }) {
            // Update the savedMembers of the goal at the found index
            goals[index].savedMembers = members
            goals[index].cellType = (count > 1) ? .group : .individual
            print("Goal members updated successfully")
        } else {
            print("Goal with ID \(goalId) not found")
        }
    }
    
   
    
    func checkValidGoalName(goalName: String) -> Bool{
        return !goalName.isEmpty
    }
    func checkValidGoalDescription(goalDescription: String) -> Bool{
        return !goalDescription.isEmpty
    }
    
    func getGroupProgress(byID id: UUID) -> Double {
        guard let goal = getGoal(byID: id) else {
            return 0.0 // Return 0 if the goal is nil
        }
        
        if goal.savedMembers.isEmpty{
            return 0.0
        }
        
        let progressSum = goal.savedMembers.map { $0.progress }.reduce(0, +)
        let maxProgress = Double(goal.savedMembers.count) * 100.0 // Maximum possible progress
        let groupPercentage = (progressSum / maxProgress) * 100.0 // Calculate the percentage
        return groupPercentage
    }
    

    // Retrieve a goal by ID
    func getGoal(byID id: UUID) -> GoalDetails? {
        return goals.first(where: { $0.id == id })
    }
    
    // Retrieve all goals
    func getAllGoals() -> [GoalDetails] {
        return goals
    }
    
    func getFirstMember(byID id: UUID) -> MemberDetail?{
        guard let goal = getGoal(byID: id) else {
            return nil
        }
        
        return goal.savedMembers.first
    }

    // Delete a goal by ID
    func deleteGoal(byID id: UUID) {
        goals.removeAll(where: { $0.id == id })
    }
    
    // Update a goal by ID
    func updateGoal(byID id: UUID, newGoal: GoalDetails) {
        // Find the goal by ID
        if let index = goals.firstIndex(where: { $0.id == id }) {
            // Update the goal at the found index
            goals[index] = newGoal
            print("Goal updated successfully")
        } else {
            print("Goal with the given ID not found")
        }
    }
}

public enum DurationVal: String, Equatable, Codable {
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
}

struct GoalDetails: Codable, Hashable, Identifiable {
    let id: UUID
    let goalTitle: String
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
        cellType: GoalType = .group,
        savedMembers: [MemberDetail],
        description: String,
        dueOnDate: Date,
        reminder: DurationVal
        
    ) {
        self.id = id
        self.goalTitle = goalTitle
        self.updateDate = updateDate
        self.cellType = savedMembers.count > 1 ? .group : .individual
        self.savedMembers = savedMembers
        self.description = description
        self.dueOnDate = dueOnDate
        self.reminder = reminder
    }
}






