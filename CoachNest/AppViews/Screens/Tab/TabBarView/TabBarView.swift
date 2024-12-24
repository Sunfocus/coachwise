//
//  TabView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 23/12/24.
//

import SwiftUI

// MARK: - Enum for Tab Identifiers
enum Tab: Int, CaseIterable {
    case home
    case messages
    case schedule
    case goals
    case memories

    // Display name for each tab
    var title: String {
        switch self {
        case .home: return "Home"
        case .messages: return "Messages"
        case .schedule: return "Schedule"
        case .goals: return "Goals"
        case .memories: return "Memories"
        }
    }

    //  custom asset for each tab
    var imageName: String {
        switch self {
        case .home: return "home"
        case .messages: return "messages"
        case .schedule: return "schedule"
        case .goals: return "goals"
        case .memories: return "memories"
        }
    }
}

// MARK: - TabBarView
struct TabBarView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Iterate over all tabs to create their views
            ForEach(Tab.allCases, id: \.self) { tab in
                tabView(for: tab)
                    .tabItem {
                        Image(tab.imageName) // Use the tab's image
                        Text(tab.title) // Use the tab's title
                    }
                    .tag(tab)
            }
        }
        .tint(.primaryTheme)
        .onAppear(perform: {
            configureTabBarAppearance()
        })
        .onChange(of: selectedTab) { (oldValue, newValue) in
            HapticFeedbackHelper.mediumImpact()
        }
    }
    
    // View for each tab
    @ViewBuilder
    private func tabView(for tab: Tab) -> some View {
        switch tab {
        case .home:
            HomeView()
        case .messages:
            MessagesView()
        case .schedule:
            ScheduleView()
        case .goals:
            GoalsView()
        case .memories:
            MemoriesView()
        }
    }
    
    // MARK: - Set TabBar Appearance
    private func configureTabBarAppearance() {
        let standardAppearance = UITabBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.shadowColor = .black.withAlphaComponent(0.3)
        UITabBar.appearance().standardAppearance = standardAppearance
        UITabBar.appearance().scrollEdgeAppearance = standardAppearance
    }
}

#Preview {
    TabBarView()
}
