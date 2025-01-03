//
//  NotificationsListView.swift
//  CoachNest
//
//  Created by ios on 03/01/25.
//

import SwiftUI

struct NotificationsListView: View {
    
    //MARK: - Variables -
    @StateObject var notificationsViewModel: NotificationsViewModel
    @EnvironmentObject var router: Router
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        ZStack{
            if colorScheme != .dark{
                Color.lightGrey .ignoresSafeArea()
            }
            VStack{
                notificationTopView
                
                
                let todayNotification = notificationsViewModel.getTodayNotifications()
                let yesterdayNotification = notificationsViewModel.getYesterdayNotifications()
                let pastNotification = notificationsViewModel.getPastNotificationsExcludingTodayAndYesterday()
                
                List {
                    // Today Section
                    if !todayNotification.isEmpty {
                        NotificationHeader(headerTitle: "Today")
                            .listRowBackground(Color.clear)
                            .padding(.top)
                        
                        ForEach(todayNotification, id: \.self) { item in
                            let time = item.notificationDate.getFormattedStringByTimeStamp(format: .time)
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
                        }
                    }
                    // Yesterday Section
                    if !yesterdayNotification.isEmpty {
                        NotificationHeader(headerTitle: "Yesterday")
                            .listRowBackground(Color.clear)
                            .padding(.top)
                        
                        ForEach(yesterdayNotification, id: \.self) { item in
                            let time = item.notificationDate.getFormattedStringByTimeStamp(format: .time)
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
                        }
                       
                    }
                    // Past Section
                    if !pastNotification.isEmpty {
                        NotificationHeader(headerTitle: "Previous")
                            .listRowBackground(Color.clear)
                            .padding(.top)
                        
                        ForEach(pastNotification, id: \.self) { item in
                            let time = item.notificationDate.getFormattedStringByTimeStamp(format: .date)
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
                        }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                
                Spacer()
                
                CustomButton(
                    title: "Send notification",
                    action: {
                        
                        
                    }
                ).padding(.horizontal)
            }
            
        }.navigationBarBackButtonHidden()
        
    }
    
    
    //MARK: - Subviews -
    var notificationTopView: some View{
        HStack{
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
           
        }.background(colorScheme == .dark ? .black : .white)
    }
    
}
//MARK: - Reusable Views -
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


    
#Preview {
    NotificationsListView(notificationsViewModel: NotificationsViewModel())
}
    
    
    
    
    
