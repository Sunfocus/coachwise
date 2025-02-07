//
//  Settings.swift
//  CoachNest
//
//  Created by Rahul Pathania on 07/02/25.
//

import SwiftUI

struct SettingsView: View {
    
    //MARK: - Variables -
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            VStack{
                topNavView
                settingsListView
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
                        Text(Constants.SettingsViewTitle.settings)
                            .customFont(.medium, 18)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
    }
    var settingsListView: some View{
        List {
            Section(header: Text("Notification and Calendar")
                .customFont(.regular, 14)
            ) {
                SettingsRow(icon: .notification, title: "Notification Preferences", onTap: {
                    router.navigate(to: .notificationPreferences)
                })
                ToggleRow(icon: .calendar, title: "Calendar Sync") { value in
                    print("calendar sync toggle is \(value)")
                }
            }
            
            Section(header: Text("Company")
                .customFont(.regular, 14)) {
                SettingsRow(icon: .club, title: "Manage Club Details", onTap: {
                    
                })
                SettingsRow(icon: .venue, title: "Manage Venues", onTap: {
                    
                })
            }
            
            Section(header: Text("Account and Users")
                .customFont(.regular, 14)) {
                SettingsRow(icon: .verifyAccount, title: "Verify Account", onTap: {
                    
                })
                SettingsRow(icon: .privacySetting, title: "Privacy Settings", onTap: {
                    
                })
                SettingsRow(icon: .userPermission, title: "User Permissions", onTap: {
                    
                })
            }
            
            Section(header: Text("Payment")
                .customFont(.regular, 14)) {
                SettingsRow(icon: .paymentMethod, title: "Manage Payment Method", onTap: {
                    
                })
            }
            
            Section(header: Text("General")
                .customFont(.regular, 14)) {
                SettingsRow(icon: .privacyPolicy, title: "Privacy Policy", onTap: {
                    
                })
                SettingsRow(icon: .terms, title: "Terms & Conditions", onTap: {
                    
                })
                SettingsRow(icon: .contactUs, title: "Contact Us", onTap: {
                    
                })
                SettingsRow(icon: .shareApp, title: "Share App", onTap: {
                    
                })
                SettingsRow(icon: .rateUs, title: "Rate Us", onTap: {
                    
                })
            }
            
            Section(header: Text("Administration")
                .customFont(.regular, 14)) {
                SettingsRow(icon: .leaveClub, title: "Leave Club", onTap: {
                    
                })
                SettingsRow(icon: .deleteClub, title: "Delete Club", onTap: {
                    
                })
                SettingsRow(icon: .deleteAccount, title: "Delete Account", onTap: {
                    
                })
            }
        }
        .listStyle(.insetGrouped)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SettingsView()
}

struct SettingsRow: View {
    var icon: UIImage
    var title: String
    var onTap: () -> Void  // Closure to handle tap action
    
    var body: some View {
        HStack {
            Image(uiImage: icon)
                .resizable()
                .frame(width: 26, height: 26)
                .scaledToFill()
            
            Text(title)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Image(.rightArrow)
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(.gray)
                
        }
        .contentShape(.rect)
        .frame(height: 36)
        .onTapGesture {
            onTap()
        }
    }
}
struct ToggleRow: View {
    var icon: UIImage
    var title: String
    @State private var isOn = false
    var onToggleChange: (Bool) -> Void
       
    
    var body: some View {
        HStack {
            Image(uiImage: icon)
                .resizable()
                .frame(width: 26, height: 26)
                .scaledToFill()
            
            Text(title)
                .customFont(.regular, 16)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.primaryTheme)
                .onChange(of: isOn) { old, newValue in
                    onToggleChange(newValue)
                }
        }
        .frame(height: 36)
    }
}
