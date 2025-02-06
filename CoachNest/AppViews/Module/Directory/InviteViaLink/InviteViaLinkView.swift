//
//  InviteViaLinkView.swift
//  CoachNest
//
//  Created by Rahul Pathania on 05/02/25.
//

import SwiftUI

struct InviteViaLinkView: View {
    
    //MARK: - Variables -
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = InviteViaLinkViewModel()
    @StateObject private var toastManager = ToastManager()
    
   
    
    
    var body: some View {
        ZStack{
            VStack{
                topNavView
                segmentMenuView
                addContactView
                Spacer()
            }
            
        }.navigationBarBackButtonHidden()
            .background(.backgroundTheme)
    }
    
    //MARK: - Subviews -
    var topNavView: some View{
        ZStack{
            VStack{
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                            .customFont(.regular, 17)
                    }
                    
                    Spacer()
                }.padding([.horizontal, .vertical], 15)
                    .overlay {
                        HStack{
                            Text(Constants.Directory.inviteToClub)
                                .customFont(.medium, 18)
                        }
                    }
                Divider()
            }
            .background(.darkGreyBackground)
            
            if toastManager.isShowing {
                ToastView(message: toastManager.message, imageName: toastManager.imageName)
                    .transition(.move(edge: .top).animation(.smooth))
            }
        }
       // .overlay(
//            ZStack {
//                VStack{
//                    if toastManager.isShowing {
//                        ToastView(message: toastManager.message, imageName: "exclamationmark.triangle.fill")
//                            .transition(.move(edge: .top).combined(with: .opacity))
//                            .frame(maxWidth: .infinity)
//                            .alignmentGuide(.top) { _ in 0 }
//                    }
//                    Spacer()
//                }
//            })
    }
    var segmentMenuView: some View{
    VStack{
        Picker("Select Option",  selection: $viewModel.selectedSegment) {
            ForEach(AccountType.allCases){ segment in
                Text(segment.rawValue).tag(segment)
            }
        }
        .pickerStyle(.segmented)
        .frame(height: 44)
    }
    .padding([.horizontal, .vertical])
}
    var addContactView: some View{
        VStack(spacing: 15){
           
            VStack(spacing: 6){
                Text("Email address")
                    .customFont(.regular, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack{
                    
                    TextField("Enter email address", text: $viewModel.email)
                        .customFont(.regular, 14)
                        .frame(height: 48)
                        .padding(.horizontal)
                        .background(.darkGreyBackground)
                        .clipShape(.rect(cornerRadius: 8))
                        .tint(.primary)
                        .keyboardType(.emailAddress)
                    
                    if !viewModel.email.isEmpty && viewModel.filteredUsers.isEmpty{
                        Button {
                            if viewModel.isValidEmail(){
                                viewModel.addToInvitedList(accountType: viewModel.selectedSegment)
                                UIApplication.shared.dismissKeyboard()
                            }else{
                                viewModel.email = ""
                                toastManager.showToast(message: "Please enter a valid email", imageName: "exclamationmark.triangle.fill")
                            }
                        } label: {
                            Image(.plusWhite)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(12)
                                .background(.primaryTheme)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }.padding(.horizontal)
            
            if !viewModel.filteredUsers.isEmpty{
                List {
                    ForEach(viewModel.filteredUsers, id: \.self) { user in
                        HStack {
                            Image(systemName: "person.circle")
                            Text(user)
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.email = user
                            viewModel.addToInvitedList(accountType: viewModel.selectedSegment)
                            UIApplication.shared.dismissKeyboard()
                        }
                    }
                }.listStyle(.plain)
                    .frame(height: 200)
                    .edgesIgnoringSafeArea(.top)
            }
            
            if viewModel.selectedSegment == .coach{
                adminAccessView
                    .padding(.horizontal)
            }
            if viewModel.selectedSegment == .parent{
              //  parentOfView
              //      .padding(.horizontal)
            }
            
            if !viewModel.invitedPeopleEmail.isEmpty{
                selectedContactsForInvitesView
            }
        
            CustomButton(
                title: Constants.Directory.sendInvite,
                action: {
                    dismiss()
                }
            ).padding(.horizontal)
            sendInviteViaEmailNoteView
                .padding(.horizontal)
           
        }
    }
    var adminAccessView: some View{
        HStack{
            Text("Admin access")
                .customFont(.regular, 16)
            Spacer()
            
            Toggle("", isOn: $viewModel.isAdminAccessEnabled)
                .tint(.primaryTheme)
        }
            .frame(height: 50)
            .padding(.horizontal)
            .background(.darkGreyBackground)
            .clipShape(.rect(cornerRadius: 8))
    }
    var selectedContactsForInvitesView: some View{
        List {
            Section(header: Text("Invites will be send to")) {
                ForEach(viewModel.invitedPeopleEmail, id: \.self) { item in
                    HStack{
                        Image(.userCircle)
                            .resizable()
                            .frame(width: 24, height: 24)
                        VStack(spacing: 2){
                            Text(item.email)
                                .customFont(.regular, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
//                            Text(item.accountType.rawValue)
//                                .customFont(.regular, 13)
//                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer()
                            Image(.blackCross)
                                .resizable()
                                .frame(width: 22, height: 22)
                                .onTapGesture {
                                    print("List tapped remove this invited contact")
                                    viewModel.removeInvite(id: item.id )
                                }
                        
                    }.frame(height: 38)
                }
            }
        }
        .listStyle(InsetGroupedListStyle()) // Optional styling
        
    }
    var sendInviteViaEmailNoteView: some View{
        Text(Constants.Directory.sendInviteViaEmail)
            .customFont(.regular, 15)
            .multilineTextAlignment(.center)
    }
    var parentOfView: some View{
        VStack(spacing: 6){
            Text("Parent of (Optional)")
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                TextField("Search...", text: $viewModel.searchedParent)
                    .customFont(.regular, 14)
                Spacer()
                Image(.addGoalMemberButton)
                    .resizable()
                    .frame(width: 20, height: 20)
            }.frame(height: 48)
                .padding(.horizontal)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
                .tint(.primary)
            
            
            
        }
    }
}

#Preview {
    InviteViaLinkView()
}
