//
//  JoiningEntryView.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 17/12/24.
//

import SwiftUI

struct JoinOrCreateClubView: View {
    
    @EnvironmentObject var router: Router
    @State private var joiningEntryData: [EnrollmentData] = [
        EnrollmentData(id: 1, title: Constants.JoiningEntryViewTitle.joinExistingClub, subTitle: Constants.JoiningEntryViewTitle.inviteCode, setImage: UIImage()),
        EnrollmentData(id: 2, title: Constants.JoiningEntryViewTitle.createNewClub, subTitle: Constants.JoiningEntryViewTitle.headCoachOfClub, setImage: UIImage())]
    
    @State private var selectedEnrollmentId: Int? = 1
    var body: some View {
        ZStack {
            VStack {
                // MARK: - Back Button Section
                VStack {
                    HStack {
                        Text(Constants.JoiningEntryViewTitle.joiningAsClubOrSchool)
                            .customFont(.semiBold, 24)
                        Spacer()
                    }.padding(.top, 12)
                }.padding(.horizontal, 20)
                
                // MARK: - List
                ScrollView {
                    ForEach(joiningEntryData) { joinEntry in
                        ProfessionCell(imageName: selectedEnrollmentId == joinEntry.id ? .selectedRadio : .unSelectedRadio,
                                       enrollment: joinEntry,
                                       selectedEnrollmentId: selectedEnrollmentId ?? 1)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                            .onTapGesture {
                                selectedEnrollmentId = (selectedEnrollmentId == joinEntry.id) ? selectedEnrollmentId : joinEntry.id
                                HapticFeedbackHelper.lightImpact()
                            }
                    }
                }
                .scrollIndicators(.never)
                .safeAreaPadding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                .background(.backgroundTheme)
                Spacer()
                // MARK: - Next Button
                VStack{
                    CustomButton(
                        title: Constants.JoiningEntryViewTitle.next,
                        action: {
//                            router.navigate(to: .joiningGroupView)
                            if selectedEnrollmentId == 1{
                                router.navigate(to: .joinGroupView)
                            }else{
                                router.navigate(to: .businessNameView)
                            }
                            HapticFeedbackHelper.mediumImpact()
                        }
                    )
                }.padding(.horizontal, 20)
            }.padding(.top, 20)
        }.background(.backgroundTheme)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: {
                        router.authNavigateBack()
                    })
                }
            }
    }
}

#Preview {
    JoinOrCreateClubView()
}
