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
            }else if router.root == .tab {
                
            }
        }
        .environmentObject(router)
        .environmentObject(businessActivityViewModel)
    }
}

