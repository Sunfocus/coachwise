//
//  NotificationsListView.swift
//  CoachNest
//
//  Created by ios on 03/01/25.
//

import SwiftUI

struct NotificationsListView: View {
    
    //MARK: - Variables -
    @StateObject var notificationViewModel: NotificationsViewModel
    @EnvironmentObject var router: Router
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            
            VStack{
                notificationTopView
                
                //Fetch notifications based on different time
                let todayNotification = notificationViewModel.getTodayNotifications()
                let yesterdayNotification = notificationViewModel.getYesterdayNotifications()
                let pastNotification = notificationViewModel.getPastNotificationsExcludingTodayAndYesterday()
                
                List {
                    // Today Section
                    if !todayNotification.isEmpty {
                        NotificationListView(headerType: .today, notifications: todayNotification, notificationsViewModel: notificationViewModel)
                    }
                    // Yesterday Section
                    if !yesterdayNotification.isEmpty {
                        NotificationListView(headerType: .yesterday, notifications: yesterdayNotification, notificationsViewModel: notificationViewModel)
                        
                    }
                    // Past Section
                    if !pastNotification.isEmpty {
                        NotificationListView(headerType: .previous, notifications: pastNotification, notificationsViewModel: notificationViewModel)
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                
                Spacer()
                
                CustomButton(
                    title: "Send notification",
                    action: {
                        router.navigate(to: .coachSendNotificationView)
                    }
                ).padding(.horizontal)
            }
        }.background(.backgroundTheme)
        .navigationBarBackButtonHidden()
    }
    
    //MARK: - Subviews -
    var notificationTopView: some View{
        VStack{
            // Heading and dismiss button section
            HStack {
                Image(.arrowBack)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        router.dashboardNavigateBack()
                    }
                Spacer()
                Image(.more)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                     
                      
                    }
            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    VStack{
                        Text(Constants.notifications)
                            .customFont(.medium, 16)
                    }
                }
            Divider()
           
        }.background(.darkGreyBackground)
    }
}
//MARK: - Reusable Views -
//Notification header view (Previous, today, yesterday)
struct NotificationHeader: View {
    let headerTitle: String
    var body: some View {
            Text(headerTitle)
            .customFont(.medium, 12)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 6)
                .background(.primaryTheme)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
}
//Header type enum
enum HeaderType: String{
    case today = "Today"
    case yesterday = "Yesterday"
    case previous = "Previous"
}
//Notification List View Header Title and listing
struct NotificationListView: View {
    
    let headerType: HeaderType
    let notifications:  [NotificationInfo]
    @ObservedObject var notificationsViewModel: NotificationsViewModel
    
    var body: some View {
        NotificationHeader(headerTitle: headerType.rawValue)
            .listRowBackground(Color.clear)
            .padding(.top)
        
        ForEach(notifications, id: \.self) { item in
            let time = item.notificationDate.getFormattedStringByTimeStamp(format: (headerType == .previous ? .date : .time))
            NotificationsRowCell(notification: item, time: time ?? "dummy")
                .listRowInsets(EdgeInsets())
                .padding(.vertical, 0.4)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .padding(.bottom, 5)
            
                .swipeActions {
                    // Delete Button
                    Button(action: {
                        withAnimation {
                            notificationsViewModel.deleteNotificationById(id: item.id)
                        }
                    }) {
                        Label("Delete", image: .deleteGoal)
                    }
                    .tint(.red)
                }
        }//loop ends
//        .onDelete { indexSet in
//            notificationsViewModel.deleteNotifications(at: indexSet)
//        }
    }
}


    
#Preview {
    NotificationsListView(notificationViewModel: NotificationsViewModel())
        .environmentObject(NotificationsViewModel())
}
    
    
    
    
    
