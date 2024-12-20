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
                        Image(.arrowBack)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                router.authNavigateBack()
                            }
                        Spacer()
                    }
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
                            router.navigate(to: .joiningEntry)
                            HapticFeedbackHelper.mediumImpact()
                        }
                    )
                }.padding(.horizontal, 20)
            }
        }
        .background(.backgroundTheme)
        .navigationBarBackButtonHidden(true)
    }
}
