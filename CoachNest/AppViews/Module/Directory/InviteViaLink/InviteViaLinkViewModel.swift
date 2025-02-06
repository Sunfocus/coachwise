//
//  InviteViaLinkViewModel.swift
//  CoachNest
//
//  Created by Rahul Pathania on 06/02/25.
//

import SwiftUI

struct Invites: Hashable{
    let id = UUID()
    let email: String
    let accountType: AccountType
}

class InviteViaLinkViewModel: ObservableObject{
    @Published var selectedSegment: AccountType  = .coach
    @Published var email: String = ""
    @Published var searchedParent: String = ""
    @Published var isAdminAccessEnabled: Bool = false
    @Published var isSendInviteEnabled: Bool = false
    @Published var invitedPeopleEmail: [Invites] = []
    
    let users = ["paras@example.com", "rahul@example.com", "ankush@example.com"]
    var filteredUsers: [String] {
        if email.isEmpty {
            return []
        }
        return users.filter { $0.localizedCaseInsensitiveContains(email) }
    }
    
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    
    func addToInvitedList(accountType: AccountType){
        let invitedContact = Invites(email: email, accountType: accountType)
        invitedPeopleEmail.append(invitedContact)
        self.email = ""
    }
    
    func removeInvite(id: UUID){
        invitedPeopleEmail.removeAll { $0.id == id }
    }

}
