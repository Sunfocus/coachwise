//
//  TabSelectionManager.swift
//  CoachNest
//
//  Created by ios on 10/01/25.
//

import SwiftUI

class TabSelectionManager: ObservableObject {
    @Published var selectedTab: Tab = .home // Track the currently selected tab
}
