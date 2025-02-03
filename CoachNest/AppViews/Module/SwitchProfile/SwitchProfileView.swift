//
//  SwitchProfileView.swift
//  CoachNest
//
//  Created by Rahul Pathania on 03/02/25.
//

import SwiftUI

struct SwitchProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = SwitchProfileViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                topHeaderView
                subheading
                ScrollView{
                    ForEach(viewModel.userProfiles){ profile in
                        SwitchProfileTypeView(profile: profile, viewModel: viewModel)
                    }
                } .safeAreaPadding(EdgeInsets(top: 10, leading: 0, bottom: 40, trailing: 0))
                    .scrollIndicators(.hidden)
            }
        }
    }
    
    //MARK: - Subviews
    var topHeaderView: some View{
        VStack{
            HStack {
                Image(.greyCloseButton)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    HStack{
                        Text(Constants.SwitchProfileViewTitle.switchProfile)
                            .customFont(.medium, 16)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
        .padding( .bottom)
    }
    var subheading: some View{
        Text(Constants.SwitchProfileViewTitle.switchBetweenClubMember)
            .customFont(.regular, 16)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    SwitchProfileView()
}



//Reusable Views
struct SwitchProfileTypeView: View {
    
    var profile: SwitchProfileModel
    @ObservedObject var viewModel: SwitchProfileViewModel
    
    var body: some View {
        ZStack{
            HStack{
                VStack{
                    Text(profile.clubName)
                        .customFont(.medium, 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Club ID: \(profile.clubId)")
                        .customFont(.regular, 15)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                AcceptInviteSwitchView(profile: profile,
                                       viewModel: viewModel
                )
                if profile.inviteAccepted{
                    Button(action:{
                       //more button tapped
                    }) {
                        Image(.more)
                            .resizable()
                            .tint(.primary)
                            .frame(width: 20, height: 20)
                    }
                }
            }.padding(10)
                .padding(.horizontal,5)
                .padding(.vertical, 10)
                .background(.darkGreyBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .padding(.horizontal)
               
            
        }
    }
}
struct AcceptInviteSwitchView: View {
    
    var profile: SwitchProfileModel
    @ObservedObject var viewModel: SwitchProfileViewModel
    var isClubSelected: Bool{
        return profile.clubId == viewModel.selectedProfile.clubId
    }
    
    var body: some View {
        VStack(spacing: 5){
            if profile.inviteAccepted{
                Text(profile.profileType.rawValue)
                    .customFont(.regular, 14)
                HStack(spacing: 5){
                    if isClubSelected{
                        Image(.greenTick)
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text("Current")
                            .customFont(.medium, 12)
                    }else{
                        Button(action:{
                            viewModel.selectedProfile = profile
                        }) {
                            Text("Switch")
                                .customFont(.medium, 12)
                                .padding(.horizontal, 10)
                        }
                    }
                }.padding(.horizontal)
                    .padding(.vertical,8)
                    .background(isClubSelected ? .lightGreen : .pastelRed)
                    .foregroundStyle(isClubSelected ? .darkGreen : .red)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
            }else{
                Text(profile.profileType.rawValue)
                    .customFont(.regular, 14)
                Button(action:{
                    viewModel.acceptInvite(id: profile.id)
                }) {
                    Text("Accept Invite")
                        .customFont(.medium, 12)
                        .padding(.horizontal)
                        .padding(.vertical, 7)
                        .background(.primaryTheme)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
        }
    }
}

