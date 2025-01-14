//
//  ManageVenues.swift
//  CoachNest
//
//  Created by ios on 13/01/25.
//

import SwiftUI

struct ManageVenues: View {
    
    //MARK: - Variables -
    
    var body: some View {
        
        ZStack{
            VStack{
                VStack(spacing: 15){
                    topHeaderView
                }
                Spacer()
            }
        }
        .background(.backgroundTheme)
            .overlay(
                addVenueButtonView
                .padding(.trailing, 30)
                .padding(.bottom, 40),
               alignment: .bottomTrailing
            )
    }
    
    //MARK: - Subviews
    var topHeaderView: some View{
        // Heading and dismiss button section
        VStack{
            HStack {
                Image(.arrowBack)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        
                    }
                Spacer()
            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    HStack{
                        Text(Constants.AddVenueViewTitle.manageVenues)
                            .customFont(.medium, 16)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
        .padding( .bottom)
    }
    var addVenueButtonView: some View {
        Button(action: {
            print("Add new tapped")
            
           // router.navigate(to: .addGoalView(userType: .coach, goalId: UUID(), comingFrom: .addNewGoal))
        }) {
            Circle()
                .foregroundStyle(.primaryTheme)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(.white)
                }
        }
    }
}

#Preview {
    ManageVenues()
}
