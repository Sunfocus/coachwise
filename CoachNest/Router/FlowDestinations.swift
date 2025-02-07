//
//  FlowDestinations.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 06/12/24.
//

import Foundation
import SwiftUI

//MARK: - Auth Flow -
public enum AuthFlow: Codable, Hashable {
    case login
    case signup
    case forgotPassword
    case joiningPopUpView
    case emailVerification
    case createNewPassword
    case enrollmentType
    case businessNameView
    case businessActivityView
    case ageGroupView
    case dateOfBirthView
    case addContacts
    case letsCompleteProfile
    case joinOrCreateClub
    case joinGroupView
}

//MARK: - DashboardFlow -
public enum DashboardFlow: Codable, Hashable {
    case tab
    case addGoalView(userType: AccountType, goalId: UUID, comingFrom: ComingFrom)
    case addMember(goalId: UUID, comingFrom: ComingFrom)
    case goalDetailedView(goalId: UUID, member: MemberDetail)
    case multipleGoalUsersListing(goalId: UUID)
    case addNewAction(member: MemberDetail, goalId: UUID)
    case actionDetailView( actionId: UUID)
    case notificationView
    case coachSendNotificationView
    case chatView
    case eventDetailsView
    //sidemenu cases
    case profileView
    case paymentView
    case directory
    case evaluations
    case documents
    case settingsView
    case subscription
    
    //settings
    case notificationPreferences
    
}

