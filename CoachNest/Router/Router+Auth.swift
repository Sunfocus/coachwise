//
//  Router+Auth.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 21/11/24.
//

import SwiftUI

extension Router{
    @ViewBuilder
    func onboardDestination(for flow: AuthFlow) -> some View {
        switch flow{
        case .login:
            LoginView()
        case .signup:
            SignUpView()
        case .forgotPassword:
            ForgotPasswordView()
        case .joiningPopUpView:
            JoiningPopUpView()
        case .emailVerification:
            EmailVerificationView()
        case .createNewPassword:
            CreateNewPassword()
        case .enrollmentType:
            EnrollmentTypeView()
        case .joiningEntry:
            JoiningEntryView()
        case .businessNameView:
            BusinessNameView()
        case .businessActivityView:
            BusinessActivityView()
        case .ageGroupView:
            AgeGroupView()
        case .addNewActivity:
            AddActivityView()
                .presentationDetents([.height(200)])
                .presentationDragIndicator(.visible)
                .presentationContentInteraction(.scrolls)
        case .addContacts:
            AddContactsView()
        case .letsCompleteProfile:
            LetsCompleteProfileView()
        }
    }
}

