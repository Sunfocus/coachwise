//
//  Router+Dashboard.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 04/12/24.
//

import Foundation
import SwiftUI

extension Router {
    @ViewBuilder
    func dashboardDestination(for flow: DashboardFlow) -> some View {
        switch flow {
        case .tab:
            TabBarView()
        case .addGoalView(let userType):
            AddGoalView(userType: userType)
                .presentationDetents([.large])
        case .addMember:
            AddMemberView()
                .presentationDetents([.large])
        }
    }
}




