//
//  CoachifyApp.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 12/12/24.
//

import SwiftUI

@main
struct CoachifyApp: App {
    
    //MARK: - App-Router and state objects
    @StateObject var router = Router()
    
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
    }
}
