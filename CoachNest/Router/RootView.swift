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
    @StateObject private var whoIsThisGoalFor = ContactsViewModel()
    @StateObject var selectionType = SelectionTypeViewModel()
    @StateObject var addGoalViewModel = AddGoalViewModel()
    
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
                        .sheet(isPresented: $router.isModalPresented) {
                            if let modalDestination = router.currentModalDestination as? AuthFlow {
                                router.onboardDestination(for: modalDestination)
                            }
                        }
                    
                }
            }else if router.root == .dashboard {
                NavigationStack(path: $router.dashboardNavPath) {
                    TabBarView()
                        .navigationDestination(for: DashboardFlow.self) { destination in
                            router.dashboardDestination(for: destination)
                        }
                        .sheet(isPresented: $router.isModalPresented) {
                            if let modalDestination = router.currentModalDestination as? DashboardFlow {
                                router.dashboardDestination(for: modalDestination)
                            }
                        }
                        .fullScreenCover(isPresented: $router.isFullScreenPresented) {
                            if let fullScreenDestination = router.currentFullScreenDestination as? DashboardFlow {
                                router.dashboardDestination(for: fullScreenDestination)
                            }
                        }
                }
            }
        }
        .environmentObject(router)
        .environmentObject(businessActivityViewModel)
        .environmentObject(selectionType)
        .environmentObject(whoIsThisGoalFor)
        .environmentObject(addGoalViewModel)
    }
}

#Preview {
    RootView()
}
