//
//  SelectionTypeViewModel.swift
//  CoachNest
//
//  Created by ios on 23/12/24.
//

import SwiftUI

public enum AccountType: String, CaseIterable,Codable, Identifiable {
    case coach = "Coach"
    case parent = "Parent"
    case member = "Member"
    public var id: String { self.rawValue }
    
}

class SelectionTypeViewModel: ObservableObject {
    @Published var selectedType: AccountType = .coach
}

