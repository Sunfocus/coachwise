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
    @StateObject private var tabManager = TabSelectionManager()
    @EnvironmentObject var router: Router
    @State private var presentSideMenu = false

    var body: some View {
        ZStack{
            TabView(selection: $tabManager.selectedTab) {
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
            .onChange(of: tabManager.selectedTab) { (oldValue, newValue) in
                HapticFeedbackHelper.mediumImpact()
            }
            .environment(\.presentSideMenu, $presentSideMenu)
            
            SideMenu(
                isShowing: $presentSideMenu,
                content: AnyView(
                    SideMenuView(
                        activeTab: $tabManager.selectedTab,
                        presentSideMenu: $presentSideMenu
                    )
                )
            )
        }
    }
    
    // View for each tab
    @ViewBuilder
    private func tabView(for tab: Tab) -> some View {
        switch tab {
        case .home:
            HomeView(speechManager: SpeechManager())
                .environmentObject(tabManager)
        case .messages:
            MessagesView(messageViewModel: MessagesViewModel(), speechManager: SpeechManager())
        case .schedule:
            ScheduleView()
        case .goals:
            GoalsView( speechManager: SpeechManager())
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
        .environmentObject(Router())
        .environmentObject(AddGoalViewModel())
}


struct PresentSideMenuKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var presentSideMenu: Binding<Bool> {
        get { self[PresentSideMenuKey.self] }
        set { self[PresentSideMenuKey.self] = newValue }
    }
}
