//
//  AddContactManuallyViewModel.swift
//  CoachNest
//
//  Created by Rahul Pathania on 05/02/25.
//

import SwiftUI

class AddContactManuallyViewModel: ObservableObject{
    @Published var selectedSegment: AccountType  = .coach
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var emailAddress: String = ""
    @Published var searchedParent: String = ""
    @Published var isAdminAccessEnabled: Bool = false
    @Published var isSendInviteEnabled: Bool = false
}
