//
//  SwitchProfile.swift
//  CoachNest
//
//  Created by Rahul Pathania on 04/02/25.
//

import Foundation

enum ProfileType: String{
    case coach = "Coach"
    case member = "Member"
    case parent = "Parent"
    case superAdmin = "Super Admin"
}

struct SwitchProfile: Identifiable, Hashable{
    let id = UUID()
    let clubName: String
    let clubId: String
    var inviteAccepted: Bool
    let profileType: ProfileType
}
