//
//  CoachSendNotifivationView.swift
//  CoachNest
//
//  Created by ios on 06/01/25.
//

import SwiftUI

struct CoachSendNotifivationView: View {
    
    @EnvironmentObject var router: Router
    @Environment(\.colorScheme) var colorScheme
    @StateObject var sendNotificationViewModel: SendNotifictionViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    var savedMembers: [MemberDetail]{
        return contactsViewModel.savedMembers
    }
    
    var body: some View {
        ZStack{
          
            VStack{
                notificationTopView
                VStack(spacing: 20){
                    messageView
                    receipentView
                }.padding()
                Spacer()
                CustomButton(
                    title: "Send",
                    action: {
                        router.navigate(to: .coachSendNotificationView)
                    }
                ).padding(.horizontal)
            }
        }.navigationBarBackButtonHidden()
            .background(.backgroundTheme)
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
                Button {
                    print("save Button Tapped")
                } label: {
                    Text(Constants.save)
                        .customFont(.regular, 16)
                }

            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    VStack{
                        Text(Constants.coachNotification)
                            .customFont(.medium, 16)
                    }
                }
            Divider()
           
        }.background(colorScheme == .dark ? .black : .white)
    }
    var messageView: some View {
        //Description Section
        VStack(spacing: 6){
            Text(Constants.TextField.Title.message)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack{
                TextField(Constants.TextField.Placeholder.writeMessage, text: $sendNotificationViewModel.taskDescription, axis: .vertical)
                    .customFont(.regular, 14)
                    .tint(.primaryTheme)
                    .lineLimit(4, reservesSpace: true)
                    .textFieldStyle(.plain)
            }
            .padding()
            .background(.darkGreyBackground)
            .cornerRadius(8)
            
        }
    }
    var receipentView: some View{
        //Who is this goal for Section
        VStack(spacing: 6){
            Text(Constants.TextField.Title.recipients)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                if !savedMembers.isEmpty{
                    SelectedMemberView(selectedMembers: contactsViewModel.savedMembers)
                        .padding(.leading)
                    }
                Spacer()
                Text("Add Members")
                    .customFont(.medium, 15)
                    .padding(8)
                    .foregroundStyle(.primaryTheme)
                    .background(.primaryTheme.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.trailing, 12)
                    .onTapGesture {
                        router.navigate(to: .addMember(goalId:  UUID(), comingFrom: .addNewGoal))
                    }
                    
            }.frame(height: 48)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
            Text(Constants.TextField.Title.selectedRecipients)
                .customFont(.regular, 11)
                .frame(maxWidth: .infinity, alignment: .center)
                
        }
    }
    
}

#Preview {
    CoachSendNotifivationView(sendNotificationViewModel: SendNotifictionViewModel())
        .environmentObject(Router())
}
