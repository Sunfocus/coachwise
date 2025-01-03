//
//  NotificationsViewModel.swift
//  CoachNest
//
//  Created by ios on 03/01/25.
//

import SwiftUI

enum TimeFormat {
    case date
    case time
}

extension String {
    
    func getFormattedStringByTimeStamp(format: TimeFormat) -> String? {
           let dateFormatter = DateFormatter()  // Create a new instance of DateFormatter
           
           // Ensure the input format is set correctly before parsing
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"  // This is the format of the input string
           
           if let date = dateFormatter.date(from: self) {  // 'self' refers to the String (timestamp)
               // Now format the date based on the required format
               switch format {
               case .date:
                   dateFormatter.dateFormat = "MMM d, yyyy"  // Format for the date
                   return dateFormatter.string(from: date)
               case .time:
                   dateFormatter.dateFormat = "h:mm a"  // Format for the time
                   return dateFormatter.string(from: date)
               }
           }
           
           return nil
       }
}

struct NotificationInfo: Codable, Hashable, Identifiable{
    let id: UUID
    let notificationText: String
    let notificationDate: String
    
    init(id: UUID, notificationText: String, notificationDate: String) {
        self.id = id
        self.notificationText = notificationText
        self.notificationDate = notificationDate
    }
}

public class NotificationsViewModel: ObservableObject{
    @Published var notifications: [NotificationInfo] = [
           // Notifications for Today
           NotificationInfo(id: UUID(), notificationText: "Team workout session at 6:30 AM", notificationDate: "2025-01-03T06:30:00.000Z"), // Today
           NotificationInfo(id: UUID(), notificationText: "Strategy meeting with coaching staff at 3:00 PM", notificationDate: "2025-01-03T15:00:00.000Z"), // Today
           NotificationInfo(id: UUID(), notificationText: "Review performance stats with the team at 8:00 PM", notificationDate: "2025-01-03T20:00:00.000Z"), // Today
           NotificationInfo(id: UUID(), notificationText: "Team workout session at 6:30 AM", notificationDate: "2025-01-03T06:30:00.000Z"), // Today
           NotificationInfo(id: UUID(), notificationText: "Strategy meeting with coaching staff at 3:00 PM", notificationDate: "2025-01-03T15:00:00.000Z"), // Today
           NotificationInfo(id: UUID(), notificationText: "Review performance stats with the team at 8:00 PM", notificationDate: "2025-01-03T20:00:00.000Z"), // Today
           NotificationInfo(id: UUID(), notificationText: "Review performance stats with the team at 8:00 PM", notificationDate: "2025-01-03T20:00:00.000Z"), // Today
           NotificationInfo(id: UUID(), notificationText: "Team workout session at 6:30 AM", notificationDate: "2025-01-03T06:30:00.000Z"), // Today
           NotificationInfo(id: UUID(), notificationText: "Strategy meeting with coaching staff at 3:00 PM", notificationDate: "2025-01-03T15:00:00.000Z"), // Today
           NotificationInfo(id: UUID(), notificationText: "Review performance stats with the team at 8:00 PM", notificationDate: "2025-01-03T20:00:00.000Z"), // Today


           // Notifications for Yesterday
           NotificationInfo(id: UUID(), notificationText: "One-on-one session with John Doe at 10:00 AM", notificationDate: "2025-01-02T10:00:00.000Z"), // Yesterday
           NotificationInfo(id: UUID(), notificationText: "Team bonding dinner at 7:00 PM", notificationDate: "2025-01-02T10:00:00.000Z"), // Yesterday
           NotificationInfo(id: UUID(), notificationText: "One-on-one session with John Doe at 10:00 AM", notificationDate: "2025-01-02T10:00:00.000Z"), // Yesterday
           NotificationInfo(id: UUID(), notificationText: "Team bonding dinner at 7:00 PM", notificationDate: "2025-01-02T10:00:00.000Z"), // Yesterday
           NotificationInfo(id: UUID(), notificationText: "One-on-one session with John Doe at 10:00 AM", notificationDate: "2025-01-02T10:00:00.000Z"), // Yesterday
           NotificationInfo(id: UUID(), notificationText: "Team bonding dinner at 7:00 PM", notificationDate: "2025-01-02T10:00:00.000Z"), // Yesterday

           // Notifications for Past Days
           NotificationInfo(id: UUID(), notificationText: "Leadership workshop for coaches", notificationDate: "2024-12-15T10:00:00.000Z"), // December 15, 2024
           NotificationInfo(id: UUID(), notificationText: "Weekly fitness progress review", notificationDate: "2024-11-20T14:00:00.000Z"), // November 20, 2024
           NotificationInfo(id: UUID(), notificationText: "Client onboarding session", notificationDate: "2024-10-10T09:30:00.000Z"), // October 10, 2024
           NotificationInfo(id: UUID(), notificationText: "Feedback session with team captains", notificationDate: "2024-09-05T16:00:00.000Z"), // September 5, 2024
           NotificationInfo(id: UUID(), notificationText: "End-of-season awards ceremony", notificationDate: "2024-06-25T18:00:00.000Z"), // June 25, 2024
           NotificationInfo(id: UUID(), notificationText: "Workshop on mental health and coaching", notificationDate: "2024-05-05T11:30:00.000Z") // May 5, 2024
       ]
    
    func getNotifications() -> [NotificationInfo]{
        return notifications
    }
    
    func deleteNotificationById(id: UUID){
        notifications.removeAll(where: { $0.id == id })
      
    }
    
    func getTodayNotifications() -> [NotificationInfo] {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())  // Start of today (midnight)
        let todayEnd = calendar.date(byAdding: .day, value: 1, to: todayStart)!  // End of today (midnight of next day)
        
        return notifications.filter {
            guard let notificationDate = dateFormatter.date(from: $0.notificationDate) else { return false }
            return notificationDate >= todayStart && notificationDate < todayEnd
        }
    }

    func getYesterdayNotifications() -> [NotificationInfo] {
        let calendar = Calendar.current
        let yesterdayStart = calendar.date(byAdding: .day, value: -1, to: calendar.startOfDay(for: Date()))!
        let yesterdayEnd = calendar.startOfDay(for: Date())  // Midnight of today
        return notifications.filter {
            guard let notificationDate = dateFormatter.date(from: $0.notificationDate) else { return false }
            return notificationDate >= yesterdayStart && notificationDate < yesterdayEnd
        }
    }

    func getPastNotificationsExcludingTodayAndYesterday() -> [NotificationInfo] {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        let yesterdayStart = calendar.date(byAdding: .day, value: -1, to: todayStart)!
        
        return notifications.filter {
            guard let notificationDate = dateFormatter.date(from: $0.notificationDate) else { return false }
            return notificationDate < yesterdayStart
        }
    }

    // DateFormatter used to parse notification date string
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"  // ISO 8601 format
        return formatter
    }()
}
    
