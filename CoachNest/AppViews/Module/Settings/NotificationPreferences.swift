//
//  NotificationPreferences.swift
//  CoachNest
//
//  Created by Rahul Pathania on 07/02/25.
//

import SwiftUI

struct NotificationPreferences: View {
    
    //MARK: - Variables -
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            VStack{
                topNavView
                notificationSettingsListView
                descriptionView
                Spacer()
            }
            .navigationBarBackButtonHidden()
        }.background(.backgroundTheme)
    }
    
    //MARK: - Subviews -
    var topNavView: some View{
        VStack{
            HStack {
                Image(.arrowBack)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        //back button tapped
                        router.dashboardNavigateBack()
                    }
                Spacer()
                
            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    HStack{
                        Text(Constants.SettingsViewTitle.notificationPreferences)
                            .customFont(.medium, 18)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
    }
    var notificationSettingsListView: some View{
        List {
            Section(header: Text("Notification Preferences")
                .customFont(.regular, 14)
                    
            ) {
                ToggleRow(icon: .notification, title: "Coach Notifications") { value in
                    print("calendar sync toggle is \(value)")
                }
                ToggleRow(icon: .notification, title: "Schedule") { value in
                    print("calendar sync toggle is \(value)")
                }
                ToggleRow(icon: .notification, title: "New Messages") { value in
                    print("calendar sync toggle is \(value)")
                }
                ToggleRow(icon: .notification, title: "Payments & Invoices") { value in
                    print("calendar sync toggle is \(value)")
                }
                ToggleRow(icon: .notification, title: "Goals") { value in
                    print("calendar sync toggle is \(value)")
                }
                ToggleRow(icon: .notification, title: "New Memories") { value in
                    print("calendar sync toggle is \(value)")
                }
                ToggleRow(icon: .notification, title: "Comments") { value in
                    print("calendar sync toggle is \(value)")
                }
            }
        } .listStyle(.insetGrouped)
            .scrollIndicators(.hidden)
            .frame(height: 360)
    }
    var descriptionView: some View{
        Text("We recommend that you keep invoices and coach notifications on so that you don’t miss out on important communication!")
            .customFont(.regular, 14)
            .padding(.horizontal)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    NotificationPreferences()
        .environmentObject(Router())
}
