//
//  AddEventType.swift
//  CoachNest
//
//  Created by ios on 14/01/25.
//

import SwiftUI

struct AddEventType: View {
    
    //MARK: - Variables -
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var addEventTypeViewModel: AddEventTypeViewModel
    
    var body: some View {
        ZStack{
            VStack{
                topHeaderView
                VStack(spacing: 15){
                    addNewEventTypeNameView
                }.padding(.horizontal)
                Spacer()
                CustomButton(
                    title: Constants.AddEventTypeViewTitle.plusEventType,
                    action: {
                        addEventTypeViewModel.addEventType()
                        dismiss()
                    }
                ).padding(.horizontal)
                    .padding(.bottom)
            }
        }.background(.backgroundTheme)
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
                        Text(Constants.AddEventTypeViewTitle.addEventType)
                            .customFont(.medium, 18)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
        .padding( .bottom)
    }
    var addNewEventTypeNameView: some View{
        VStack(spacing: 6){
            Text(Constants.AddEventTypeViewTitle.addEventType)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(Constants.AddEventTypeViewTitle.eventType, text: $addEventTypeViewModel.eventType)
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
    AddEventType()
}
