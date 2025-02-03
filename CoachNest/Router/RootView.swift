//
//  RootView.swift
//  CoachNest
//
//  Created by ios on 30/12/24.
//

import SwiftUI

struct RootView: View {
    
    //MARK: - App-Router and state objects
    @StateObject var router = Router()
    @StateObject private var businessActivityViewModel = BusinessActivityViewModel()
    @StateObject private var contactsViewModel = ContactsViewModel()
    @StateObject var selectionType = SelectionTypeViewModel()
    @StateObject var addGoalViewModel = AddGoalViewModel()
    @StateObject private var addActionViewModel = AddActionViewModel()
    @StateObject private var addVenueViewModel = AddVenueViewModel()
    @StateObject private var addEventViewModel = AddEventViewModel()
    @StateObject private var addEventTypeViewModel = AddEventTypeViewModel()
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .primaryTheme
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.1)
    }
    
    var body: some View {
        ZStack{
            if router.root == .onboarding {
                NavigationStack(path: $router.authNavPath) {
                    LoginView()
                        .navigationDestination(for: AuthFlow.self) { destination in
                            router.onboardDestination(for: destination)
                        }
                }
            }else if router.root == .dashboard {
                NavigationStack(path: $router.dashboardNavPath) {
                    TabBarView()
                        .navigationDestination(for: DashboardFlow.self) { destination in
                            router.dashboardDestination(for: destination)
                        }
                }
            }
        }
        .environmentObject(router)
        .environmentObject(businessActivityViewModel)
        .environmentObject(selectionType)
        .environmentObject(contactsViewModel)
        .environmentObject(addGoalViewModel)
        .environmentObject(addActionViewModel)
        .environmentObject(addVenueViewModel)
        .environmentObject(addEventViewModel)
        .environmentObject(addEventTypeViewModel)
    }
}

#Preview {
    RootView()
}

extension UISegmentedControl {
  override open func didMoveToSuperview() {
     super.didMoveToSuperview()
     self.setContentHuggingPriority(.defaultLow, for: .vertical)
   }
}
