//
//  AddManually.swift
//  CoachNest
//
//  Created by Rahul Pathania on 05/02/25.
//

import SwiftUI

struct AddContactsManually: View {
    
    //MARK: - Variables -
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AddContactManuallyViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                topNavView
                segmentMenuView
                addContactView
                sendInviteView
                Spacer()
            }
        }.navigationBarBackButtonHidden()
            .background(.backgroundTheme)
    }
    
    //MARK: - Subviews -
    var topNavView: some View{
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
                        Text(Constants.Directory.addManually)
                            .customFont(.medium, 18)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
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
            LabelTextFieldView(title: "First name", value: $viewModel.firstName, placeholder: "Enter First name")
            LabelTextFieldView(title: "Last name", value: $viewModel.lastName, placeholder: "Enter Last name")
            LabelTextFieldView(title: "Email address", value: $viewModel.emailAddress, placeholder: "Enter email address", keyboardType: .emailAddress)
            if viewModel.selectedSegment == .coach{
                adminAccessView
            }
            if viewModel.selectedSegment == .parent{
                parentOfView
            }
        }.padding(.horizontal)
    }
    var sendInviteView: some View{
        VStack{
            HStack{
                Button {
                    viewModel.isSendInviteEnabled.toggle()
                } label: {
                    Image(viewModel.isSendInviteEnabled ? .checkboxFill : .checkboxEmpty)
                        .resizable()
                        .frame(width: 20 ,height: 20)
                }
                Text("Send Invite to CoachNest")
                    .customFont(.regular, 14)
                    .frame(maxWidth: .infinity ,alignment: .leading)
            }.padding([.horizontal, .top])
            CustomButton(
                title: Constants.addUsersToDirectory,
                action: {
                    dismiss()
                }
            ).padding(.horizontal)
        }
    }
    var adminAccessView: some View{
        HStack{
            Text("Admin access")
                .customFont(.regular, 15)
            Spacer()
            
            Toggle("", isOn: $viewModel.isAdminAccessEnabled)
                .tint(.primaryTheme)
        }
            .frame(height: 52)
            .padding(.horizontal)
            .background(.darkGreyBackground)
            .clipShape(.rect(cornerRadius: 8))
    }
    var parentOfView: some View{
        VStack(spacing: 6){
            Text("Parent of")
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                TextField("Search...", text: $viewModel.searchedParent)
                    .customFont(.regular, 14)
                Spacer()
                Image(.search)
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
    AddContactsManually()
}
