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
    case joiningEntry
    case businessNameView
    case businessActivityView
    case ageGroupView
    case addNewActivity
    case joiningGroupView
    case dobView
}

//MARK: - DashboardFlow -
public enum DashboardFlow: Codable, Hashable {
    case tab
}

