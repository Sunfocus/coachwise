//
//  Directory.swift
//  CoachNest
//
//  Created by Rahul Pathania on 05/02/25.
//

import SwiftUI

struct DirectoryView: View {
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dismiss
    @State var isFilterContactPresented: Bool = false
    @State var isAddManuallyPresented: Bool = false
    @State var isInviteViaLinkPresented: Bool = false
    @State var isImportContactListPresented: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                topNavView
                addTeamMemberView
                orView
                inviteWithLinkView
                orView
                uploadContactListView
                Spacer()
            }
            .sheet(isPresented: $isFilterContactPresented) {
                FilterView(filterOptions: Constants.chatContactFilterOptions)
                    .presentationDetents([.height(450)])
                    .presentationDragIndicator(.visible)
                    .presentationContentInteraction(.scrolls)
            }
            .navigationBarBackButtonHidden()
        }.background(.backgroundTheme)
            .fullScreenCover(isPresented: $isAddManuallyPresented) {
                AddContactsManually()
            }
            .fullScreenCover(isPresented: $isInviteViaLinkPresented) {
                InviteViaLinkView()
            }
            .fullScreenCover(isPresented: $isImportContactListPresented) {
                ImportContactListView()
            }
    }
    
    //MARK: - Subviews - 
    var topNavView: some View{
        VStack{
            HStack {
                Image(.arrowBack)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        router.dashboardNavigateBack()
                    }
                Spacer()
                Image(.filterList)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        isFilterContactPresented = true
                    }
                
            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    HStack{
                        Text(Constants.Directory.directory)
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
                .customFont(.medium, 16)
                .foregroundStyle(.primaryTheme)
            
            Text(Constants.Directory.addCoachStudent)
                .customFont(.regular, 15)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button {
                isAddManuallyPresented = true
            } label: {
                Text(Constants.Directory.addManually)
                    .customFont(.medium, 17)
                    .tint(.primaryTheme)
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primaryTheme, lineWidth: 1)
                    }
                    .padding(.horizontal)
            }
        }.padding(.top, 40)
    }
    var inviteWithLinkView: some View{
        VStack{
            Text(Constants.Directory.inviteStudentCoach)
                .customFont(.regular, 15)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button {
                isInviteViaLinkPresented = true
            } label: {
                Text(Constants.Directory.inviteWithLink)
                    .customFont(.medium, 17)
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
                .customFont(.regular, 15)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Button {
                isImportContactListPresented = true
            } label: {
                Text(Constants.Directory.importContactList)
                    .customFont(.medium, 17)
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
    DirectoryView()
}
