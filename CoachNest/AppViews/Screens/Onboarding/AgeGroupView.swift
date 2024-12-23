//
//  AgeGroupView.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 18/12/24.
//

import SwiftUI

struct AgeGroupView: View {
    
    @EnvironmentObject var router: Router
    @State private var joiningEntryData: [EnrollmentData] = [
        EnrollmentData(id: 1, title: Constants.AgeGroupViewTitle.mixed, subTitle: Constants.AgeGroupViewTitle.mixedAgeMembers, setImage: UIImage()),
        EnrollmentData(id: 2, title: Constants.AgeGroupViewTitle.childrenOrYouth, subTitle: Constants.AgeGroupViewTitle.childrenAgeMembers, setImage: UIImage()),
        EnrollmentData(id: 3, title: Constants.AgeGroupViewTitle.adults, subTitle: Constants.AgeGroupViewTitle.adultsAgeMembers, setImage: UIImage())]
    
    @State private var selectedEnrollmentId: Int? = 1
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Text(Constants.AgeGroupViewTitle.whatAgeGroup)
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
                            .contentShape(Rectangle())
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
                            router.navigate(to: .addContacts)
                            HapticFeedbackHelper.mediumImpact()
                        }
                    )
                }.padding(.horizontal, 20)
            }.padding(.top, 20)
        }.background(.backgroundTheme)
            .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    AgeGroupView()
}
