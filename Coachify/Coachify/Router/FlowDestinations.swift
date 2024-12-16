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
   
}

//MARK: - DashboardFlow -
public enum DashboardFlow: Codable, Hashable {
    case tab
}

