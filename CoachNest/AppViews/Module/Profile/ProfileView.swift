//
//  ProfileView.swift
//  CoachNest
//
//  Created by ios on 20/01/25.
//

import SwiftUI

struct ProfileView: View {
    
    //MARK: - Variables -
    @State private var selectedSegment = 0
    
    var body: some View {
        ZStack{
            VStack{
                topNavView
                profileCardView
                pickerSegmentView
                detailViewBasedOnSegment
                Spacer()
            }
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
                    }
                Spacer()
                Image(.editProfile)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        //edit profile button tapped
                    }
                
            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    HStack{
                        Text(Constants.ProfileViewTitle.profile)
                            .customFont(.medium, 16)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
    }
     var profileCardView: some View{
        VStack{
            Image(.sg1)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            HStack{
                Image(.linkPink)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 16, height: 16)
                
                Text("Member")
                    .customFont(.medium, 12)
                    .foregroundStyle(.pinkAccent)
            }.padding(5)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.pinkAccent, lineWidth: 1)
                }
            Text("Bessie Cooper")
                .customFont(.medium, 18)
                .foregroundStyle(.primary)
            
            Text("bill.sanders@example.com")
                .customFont(.medium, 16)
            
            
        }.frame(maxWidth: .infinity)
            .padding()
            .background(.darkGreyBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            .padding()
    }
     var pickerSegmentView: some View{
        VStack{
            Picker("Select Option", selection: $selectedSegment) {
                Text("Details").tag(0)
                Text("Events").tag(1)
                Text("Evaluations").tag(2)
            }
            .pickerStyle(.segmented)
            .frame(height: 35)
        }
        .padding([.horizontal, .top])
    }
     var detailViewBasedOnSegment: some View{
        switch selectedSegment{
        case 0:
            profileDetailView
        case 1:
            profileDetailView
        case 2:
            profileDetailView
        default:
            profileDetailView
        }
    }
    
    var profileDetailView: some View{
        VStack(alignment: .leading){
            Text("Personal Details")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 5){
                VStack{
                    Text("Date of birth")
                        .customFont(.regular, 14)
                        .foregroundStyle(.gray)
                    HStack(spacing: 5){
                        Text("01/08/2003")
                            .customFont(.regular, 12)
                        Text("(19 years)")
                            .foregroundStyle(.gray)
                            .customFont(.regular, 11)
                        Spacer()
                    }
                }
                
            }
            .padding()
            .background(.darkGreyBackground)
            
        }.padding()
       
    }
   
}

#Preview {
    ProfileView()
}
