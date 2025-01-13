//
//  AddVenueView.swift
//  CoachNest
//
//  Created by ios on 13/01/25.
//

import SwiftUI

struct AddVenueView: View {
    
    //MARK: - Variables -
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @StateObject var venueViewModel = AddVenueViewModel()
    
    var body: some View {
        ZStack{
            if colorScheme != .dark{
                Color.lightGrey
                    .ignoresSafeArea()
            }
            VStack{
                topHeaderView
                VStack(spacing: 15){
                    pickerView
                    fieldBasedOnToggle
                }.padding(.horizontal)
                Spacer()
                CustomButton(
                    title: Constants.addVenue,
                    action: {
                        dismiss()
                    }
                ).padding(.horizontal)
                    .padding(.bottom)
            }
        }
    }
    
    
    //MARK: - Subviews
    var topHeaderView: some View{
        // Heading and dismiss button section
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
                        Text(Constants.AddVenueViewTitle.addVenue)
                            .customFont(.medium, 16)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
        .padding( .bottom)
    }
    var pickerView: some View{
        VStack{
            Picker("Select Option", selection: $venueViewModel.selectedSegment) {
                Text("In-Person").tag(0)
                Text("Online").tag(1)
            }
            .pickerStyle(.segmented)
            .frame(height: 44)
        }
        .padding([.horizontal, .top])
    }
    var fieldBasedOnToggle: some View{
        VStack{
            if venueViewModel.selectedSegment == 0{
                addVenueNameView
                addAddressView
            }else{
                meetingNameView
                meetingLinkView
            }
        }
    }
    var addVenueNameView: some View{
        // Enter Goal Name Section
        VStack(spacing: 6){
            Text(Constants.AddVenueViewTitle.venueName)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(Constants.AddVenueViewTitle.venueName, text: $venueViewModel.venueName)
                .customFont(.regular, 14)
                .frame(height: 48)
                .padding(.horizontal)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
                .tint(.primary)
        }
    }
    var addAddressView: some View{
        VStack(spacing: 6){
            Text(Constants.AddVenueViewTitle.address)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(Constants.AddVenueViewTitle.address, text: $venueViewModel.address)
                .customFont(.regular, 14)
                .frame(height: 48)
                .padding(.horizontal)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
                .tint(.primary)
        }
    }
    var meetingNameView: some View{
        // Enter Goal Name Section
        VStack(spacing: 6){
            Text(Constants.AddVenueViewTitle.meetingName)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(Constants.AddVenueViewTitle.meetingName, text: $venueViewModel.meetingName)
                .customFont(.regular, 14)
                .frame(height: 48)
                .padding(.horizontal)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
                .tint(.primary)
        }
    }
    var meetingLinkView: some View{
        // Enter Goal Name Section
        VStack(spacing: 6){
            Text(Constants.AddVenueViewTitle.onlineLink)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(Constants.AddVenueViewTitle.onlineLink, text: $venueViewModel.meetingLink)
                .customFont(.regular, 14)
                .frame(height: 48)
                .padding(.horizontal)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
                .tint(.primary)
        }
    }
}

#Preview {
    AddVenueView()
}
