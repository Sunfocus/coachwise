//
//  AddContactsView.swift
//  Coachify
//
//  Created by ios on 19/12/24.
//

import SwiftUI

struct AddContactData{
    var heading: String
    var subheading: String
    var imageName: String
}

struct AddContactsView: View {
    
    @EnvironmentObject var router: Router
    
    var contactData: [AddContactData] = [
        AddContactData(heading: "", subheading: "", imageName: ""),
        AddContactData(heading: "", subheading: "", imageName: ""),
        AddContactData(heading: "", subheading: "", imageName: "")
    ]
    
    
    var body: some View {
        ZStack {
            VStack {
                // MARK: - Back Button Section
                VStack {
                    HStack {
                        Image(.arrowBack)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                router.authNavigateBack()
                            }
                        Spacer()
                    }
                    HStack {
                        Text(Constants.BringContactsViewTitle.letsBringInContacts)
                            .customFont(.semiBold, 24)
                        Spacer()
                    }.padding(.top, 12)
                }.padding(.horizontal, 20)
                
                // MARK: - List
                
                Spacer()
                // MARK: - Next Button
                VStack{
                    CustomButton(
                        title: Constants.JoiningEntryViewTitle.next,
                        action: {
                            router.navigate(to: .businessNameView)
                        }
                    )
                }.padding(.horizontal, 20)
                Spacer()
            }
        }
    }
}

#Preview {
    AddContactsView()
}
