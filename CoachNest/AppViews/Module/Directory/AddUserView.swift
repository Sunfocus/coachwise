//
//  ImportContact.swift
//  CoachNest
//
//  Created by Rahul Pathania on 05/02/25.
//

import SwiftUI

struct AddUserView: View {
    
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        topNavView
        addTeamMemberView
        orView
        inviteWithLinkView
        orView
        uploadContactListView
        Spacer()
    }
    
    var topNavView: some View{
        VStack{
            HStack {
                Image(.greyCloseButton)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        router.dashboardNavigateBack()
                    }
                Spacer()
            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    HStack{
                        Text(Constants.Directory.addUsers)
                            .customFont(.medium, 18)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
    }
    var addTeamMemberView: some View{
        VStack(spacing: 8){
            Image(.contact)
                .resizable()
                .frame(width: 40, height: 50)
            Text(Constants.Directory.addTeamMembers)
                .customFont(.regular, 16)
                .foregroundStyle(.primaryTheme)
            
            Text(Constants.Directory.addCoachStudent)
                .customFont(.regular, 14)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button {
                
            } label: {
                Text(Constants.Directory.addManually)
                    .customFont(.regular, 15)
                    .tint(.primaryTheme)
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primaryTheme, lineWidth: 0.8)
                    }
                    .padding(.horizontal)
            }
        }.padding(.top, 40)
    }
    var inviteWithLinkView: some View{
        VStack{
            Text(Constants.Directory.inviteStudentCoach)
                .customFont(.regular, 14)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button {
                
            } label: {
                Text(Constants.Directory.inviteWithLink)
                    .customFont(.regular, 15)
                    .tint(.primaryTheme)
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primaryTheme, lineWidth: 0.8)
                    }
                    .padding(.horizontal)
            }
        }
    }
    var orView: some View{
        VStack{
            Text("- Or -")
                .customFont(.medium, 15)
        }.padding(10)
    }
    var uploadContactListView: some View{
        VStack{
            Text(Constants.Directory.uploadContactList)
                .customFont(.regular, 14)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button {
                
            } label: {
                Text(Constants.Directory.importContactList)
                    .customFont(.regular, 15)
                    .tint(.primaryTheme)
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primaryTheme, lineWidth: 0.8)
                    }
                    .padding(.horizontal)
            }
            
            Text(Constants.Directory.contactWillBeUpdated)
                .customFont(.regular, 14)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    AddUserView()
}
