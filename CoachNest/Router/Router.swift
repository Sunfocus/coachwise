//
//  Router.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 13/11/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    enum RootFlow {
        case onboarding
        case dashboard
    }
    
    @Published var authNavPath = NavigationPath()
    @Published var dashboardNavPath = NavigationPath()
    @Published var isUserLoggedIn: Bool = false
    
    var root: RootFlow = .dashboard
    
    private var authDestinations: [AuthFlow] = []
    private var dashboardDestinations: [DashboardFlow] = []
    
    func setRoot(to newRoot: RootFlow) {
        root = newRoot
        switch newRoot {
        case .onboarding:
            authNavigateToRoot()
        case .dashboard:
            self.isUserLoggedIn = false
            dashboardNavigateToRoot()
        }
    }
}

extension Router {
    // Push navigation only
    func navigate<T: Hashable>(to destination: T, path: inout NavigationPath, destinations: inout [T]) {
        if let index = destinations.firstIndex(of: destination) {
            path.removeLast(path.count - (index + 1))
            destinations.removeLast(destinations.count - (index + 1))
        } else {
            path.append(destination)
            destinations.append(destination)
        }
    }
    
    func navigateBack<T>(path: inout NavigationPath, destinations: inout [T]) {
        guard !destinations.isEmpty else { return }
        path.removeLast()
        destinations.removeLast()
    }
    
    func navigateToRoot<T>(path: inout NavigationPath, destinations: inout [T]) {
        path = NavigationPath()
        destinations.removeAll()
    }
}

// MARK: - Auth Flow -
extension Router {
    func navigate(to destination: AuthFlow) {
        navigate(to: destination, path: &authNavPath, destinations: &authDestinations)
    }
    
    func authNavigateBack() {
        navigateBack(path: &authNavPath, destinations: &authDestinations)
    }
    
    func authNavigateToRoot() {
        navigateToRoot(path: &authNavPath, destinations: &authDestinations)
    }
}

// MARK: - Dashboard Flow -
extension Router {
    func navigate(to destination: DashboardFlow) {
        navigate(to: destination, path: &dashboardNavPath, destinations: &dashboardDestinations)
    }
    
    func dashboardNavigateBack() {
        navigateBack(path: &dashboardNavPath, destinations: &dashboardDestinations)
    }
    
    func dashboardNavigateToRoot() {
        navigateToRoot(path: &dashboardNavPath, destinations: &dashboardDestinations)
    }
}
