//
//  CoachNestApp.swift
//  CoachNest
//
//  Created by sunfocus solution on 20/12/24.
//

import SwiftUI

@main
struct CoachNestApp: App {
    
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
   
    
    var body: some Scene {
        WindowGroup {
            if router.root == .onboarding {
                NavigationStack(path: $router.authNavPath) {
                    SplashView()
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

