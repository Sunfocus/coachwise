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
    @StateObject var selectionType = SelectionTypeViewModel()
    
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
                }
            }
        }
        .environmentObject(router)
        .environmentObject(businessActivityViewModel)
        .environmentObject(selectionType)
    }
}

