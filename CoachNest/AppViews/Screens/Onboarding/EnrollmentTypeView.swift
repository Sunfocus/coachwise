//
//  EnrollmentTypeView.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 17/12/24.
//

import SwiftUI

// MARK: - EnrollmentData Model
struct EnrollmentData: Identifiable {
    let id: Int
    let title: String?
    let subTitle: String
    let setImage: UIImage?
}

struct EnrollmentTypeView: View {
    
    // MARK: - Variables -
    @EnvironmentObject var router: Router
    @State private var selectedEnrollmentId: Int? = 1
    @EnvironmentObject var selectionTypeViewModel: SelectionTypeViewModel
    
    private var enrollmentData: [EnrollmentData] = [
        EnrollmentData(id: 1, title: "", subTitle: Constants.EnrollmentTypeViewTitle.type1, setImage: UIImage()),
        EnrollmentData(id: 2, title: "", subTitle: Constants.EnrollmentTypeViewTitle.type2, setImage: UIImage()),
        EnrollmentData(id: 3, title: "", subTitle: Constants.EnrollmentTypeViewTitle.type3, setImage: UIImage())
    ]

    var body: some View {
        ZStack {
            VStack {
                // MARK: - Back Button Section
                VStack {
                    HStack {
                        Text(Constants.EnrollmentTypeViewTitle.getStarted)
                            .customFont(.semiBold, 24)
                        Spacer()
                    }.padding(.top, 12)
                }.padding(.horizontal, 20)
                
                // MARK: - List Stack
                ScrollView {
                    ForEach(enrollmentData) { enrollment in
                        ProfessionCell(imageName: selectedEnrollmentId == enrollment.id ? .selectedRadio : .unSelectedRadio,
                                       enrollment: enrollment,
                                       selectedEnrollmentId: selectedEnrollmentId ?? 1)
                        .listRowSeparator(.hidden)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                        .onTapGesture {
                            selectedEnrollmentId = (selectedEnrollmentId == enrollment.id) ? selectedEnrollmentId : enrollment.id
                            HapticFeedbackHelper.lightImpact()
                            switch selectedEnrollmentId{
                            case 1:
                                selectionTypeViewModel.selectedType = .coach
                            case 2:
                                selectionTypeViewModel.selectedType = .parent
                            case 3:
                                selectionTypeViewModel.selectedType = .member
                            default:
                                selectionTypeViewModel.selectedType = .coach
                            }
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
                        title: Constants.EnrollmentTypeViewTitle.next,
                        action: {
                            switch selectionTypeViewModel.selectedType {
                            case .coach:
                                router.navigate(to: .joinOrCreateClub)
                            case .parent:
                                router.navigate(to: .joinGroupView)
                            case .member:
                                router.navigate(to: .dateOfBirthView)
                            }
                            HapticFeedbackHelper.mediumImpact()
                        }
                    )
                }.padding(.horizontal, 20)
            }.padding(.top, 20)
        }
        .background(.backgroundTheme)
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
