//
//  BusinessActivityViewModel.swift
//  Coachify
//
//  Created by ios on 19/12/24.
//

import Foundation

// MARK: - BusinessActivityViewModel
public class BusinessActivityViewModel: ObservableObject{
    // Published array to observe changes
    
    @Published private(set) var businessActivities: [BusinessActivityData] = [
        BusinessActivityData(id: 1, title: Constants.BusinessActivityViewTitle.ActivityType.athletics),
        BusinessActivityData(id: 2, title: Constants.BusinessActivityViewTitle.ActivityType.afl),
        BusinessActivityData(id: 3, title: Constants.BusinessActivityViewTitle.ActivityType.badminton),
        BusinessActivityData(id: 4, title: Constants.BusinessActivityViewTitle.ActivityType.baseball),
        BusinessActivityData(id: 5, title: Constants.BusinessActivityViewTitle.ActivityType.basketball),
        BusinessActivityData(id: 6, title: Constants.BusinessActivityViewTitle.ActivityType.cricket),
        BusinessActivityData(id: 7, title: Constants.BusinessActivityViewTitle.ActivityType.cycling),
        BusinessActivityData(id: 8, title: Constants.BusinessActivityViewTitle.ActivityType.dancing),
        BusinessActivityData(id: 9, title: Constants.BusinessActivityViewTitle.ActivityType.esports),
        BusinessActivityData(id: 10, title: Constants.BusinessActivityViewTitle.ActivityType.football),
        BusinessActivityData(id: 11, title: Constants.BusinessActivityViewTitle.ActivityType.golf),
        BusinessActivityData(id: 12, title: Constants.BusinessActivityViewTitle.ActivityType.gymnastics),
        BusinessActivityData(id: 13, title: Constants.BusinessActivityViewTitle.ActivityType.hockey),
        BusinessActivityData(id: 14, title: Constants.BusinessActivityViewTitle.ActivityType.martialArts),
        BusinessActivityData(id: 15, title: Constants.BusinessActivityViewTitle.ActivityType.netball),
        BusinessActivityData(id: 16, title: Constants.BusinessActivityViewTitle.ActivityType.rugby),
        BusinessActivityData(id: 17, title: Constants.BusinessActivityViewTitle.ActivityType.singing),
        BusinessActivityData(id: 18, title: Constants.BusinessActivityViewTitle.ActivityType.swimming),
        BusinessActivityData(id: 19, title: Constants.BusinessActivityViewTitle.ActivityType.tennis),
        BusinessActivityData(id: 20, title: Constants.BusinessActivityViewTitle.ActivityType.volleyball),
        BusinessActivityData(id: 21, title: Constants.BusinessActivityViewTitle.ActivityType.volunteering)
    ]
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    // Method to fetch all activities
    func getAllActivities() -> [BusinessActivityData] {
        return businessActivities.sorted { $0.title < $1.title }
    }
    
    // Method to add a new activity
       func addActivity(title: String) {
           let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
           let isValid = !trimmedTitle.isEmpty && trimmedTitle.range(of: "^[A-Za-z ]+$", options: .regularExpression) != nil
           
           guard isValid else {
               alertMessage = "Invalid activity title. It must be non-empty and contain only alphabets."
               showAlert = true
               return
           }
           
           // Generate new ID and add activity
           let newId = (businessActivities.last?.id ?? 0) + 1
           let newActivity = BusinessActivityData(id: newId, title: trimmedTitle)
           businessActivities.append(newActivity)
           print("new activity added successfully")
       }
}

