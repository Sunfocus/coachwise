//
//  AddContactsView.swift
//  Coachify
//
//  Created by ios on 19/12/24.
//

import SwiftUI

struct AddContactsView: View {
    
    @EnvironmentObject var router: Router
    @State private var selectedEnrollmentId: Int? = 1
    
    var contactData: [EnrollmentData] = [
        EnrollmentData(id: 1, title: Constants.BringContactsViewTitle.addMemberCoaches, subTitle: Constants.BringContactsViewTitle.addMemberCoachesSubheading, setImage: .peopleGroup),
        EnrollmentData(id: 2, title: Constants.BringContactsViewTitle.importContactList, subTitle: Constants.BringContactsViewTitle.importContactListSubheading, setImage:.shareFile),
        EnrollmentData(id: 3, title: Constants.BringContactsViewTitle.shareLink, subTitle: Constants.BringContactsViewTitle.shareLinkSubheading, setImage: .shareNode)
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
                        
                        Text(Constants.BringContactsViewTitle.skip)
                            .customFont(.semiBold, 16)
                            .foregroundStyle(.pinkAccent)
                            .onTapGesture {
                                print("skip tapped")
                            }
                    }
                    HStack {
                        Text(Constants.BringContactsViewTitle.letsBringInContacts)
                            .customFont(.semiBold, 24)
                        Spacer()
                    }.padding(.top, 12)
                }.padding(.horizontal, 20)
                
                // MARK: - List
                ScrollView {
                    ForEach(contactData) { contact in
                        ProfessionCell(imageName: contact.setImage ?? .selectedRadio,
                                       enrollment: contact,
                                       selectedEnrollmentId: selectedEnrollmentId ?? 1)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedEnrollmentId = (selectedEnrollmentId == contact.id) ? selectedEnrollmentId : contact.id
                                HapticFeedbackHelper.lightImpact()
                            }
                    }
                }
                .scrollIndicators(.never)
                .safeAreaPadding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                .background(.backgroundTheme)
                
                Spacer()
                // MARK: - Next Button
                VStack(spacing: 10){
                    CustomButton(
                        title: Constants.BringContactsViewTitle.done,
                        action: {
                            router.navigate(to: .letsCompleteProfile)
                            HapticFeedbackHelper.mediumImpact()
                        }
                    )
                    
                    Text(Constants.BringContactsViewTitle.skipForNow)
                        .customFont(.bold, 14)
                        .frame(height: 32)
                        .onTapGesture {
                            print("skip tapped")
                        }
                }.padding(.horizontal, 20)
                Spacer()
            }
        }.background(.backgroundTheme)
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AddContactsView()
}
