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
        case .addGoalView(let userType, let goalId, let comingGrom):
            AddGoalView(comingFrom: comingGrom, goalId: goalId, userType: userType)
        case .addMember(let goalid, let comingFrom):
            AddMemberView( speechManager: SpeechManager(), goalId: goalid, isComingFrom: comingFrom)
        case .goalDetailedView(let goalId, let member):
            GoalDetailView(goalId: goalId, member: member)
        case .multipleGoalUsersListing(goalId: let goalId):
            MultipleGoalUsersListing(goalId: goalId)
        case .addNewAction(let member, let goalId):
            AddNewAction(member: member, goalId: goalId)
        case .actionDetailView(let actionId):
            ActionDetailView(actionId: actionId)
        case .notificationView:
            NotificationsListView(notificationViewModel: NotificationsViewModel())
        case .coachSendNotificationView:
            CoachSendNotifivationView(sendNotificationViewModel: SendNotifictionViewModel())
        case .chatView:
            ChatView()
        case .eventDetailsView:
            EventDetailView()
        case .profileView:
            ProfileView()
        case .paymentView:
            PaymentsView( speechManager: SpeechManager())
        }
    }
}




