//
//  SelectionTypeViewModel.swift
//  CoachNest
//
//  Created by ios on 23/12/24.
//

import SwiftUI

public enum AccountType: String, Codable {
    case coach = "Coach"
    case parent = "Parent"
    case member = "Member"
}

class SelectionTypeViewModel: ObservableObject {
    @Published var selectedType: AccountType = .coach
}

