//
//  SwitchProfileViewModel.swift
//  CoachNest
//
//  Created by Rahul Pathania on 03/02/25.
//

import Foundation


enum ProfileType: String{
    case coach = "Coach"
    case member = "Member"
    case parent = "Parent"
    case superAdmin = "Super Admin"
}

struct SwitchProfileModel: Identifiable, Hashable{
    let id = UUID()
    let clubName: String
    let clubId: String
    var inviteAccepted: Bool
    let profileType: ProfileType
}

class SwitchProfileViewModel: ObservableObject{
    @Published var selectedProfile: SwitchProfileModel = SwitchProfileModel(clubName: "Canvas Hockey Club",
                                                                            clubId: "AZ212323",
                                                                            inviteAccepted: true,
                                                                            profileType: .coach)
    
    @Published var userProfiles: [SwitchProfileModel] = [
        SwitchProfileModel(clubName: "Canvas Hockey Club",
                           clubId: "AZ212312",
                           inviteAccepted: true,
                           profileType: .coach),
        
        SwitchProfileModel(clubName: "Jack Gym Club",
                           clubId: "BH212323",
                           inviteAccepted: true,
                           profileType: .coach),
        
        SwitchProfileModel(clubName: "Ramzy Painting Club",
                           clubId: "GF212323",
                           inviteAccepted: true,
                           profileType: .superAdmin),
        
        SwitchProfileModel(clubName: "Lukas Rugby Club",
                           clubId: "Jx212323",
                           inviteAccepted: false,
                           profileType: .member),
        
        SwitchProfileModel(clubName: "Max Walter",
                           clubId: "TF212323",
                           inviteAccepted: true,
                           profileType: .parent),
        
        
        SwitchProfileModel(clubName: "Jack Gym Club",
                           clubId: "XH212323",
                           inviteAccepted: true,
                           profileType: .coach),
        
        SwitchProfileModel(clubName: "Ramzy Painting Club",
                           clubId: "XF212323",
                           inviteAccepted: true,
                           profileType: .superAdmin),
        
        SwitchProfileModel(clubName: "Lukas Rugby Club",
                           clubId: "VC212323",
                           inviteAccepted: false,
                           profileType: .member),
        
        SwitchProfileModel(clubName: "Max Walter",
                           clubId: "VC212343",
                           inviteAccepted: true,
                           profileType: .parent)
        
    ]
    
    func acceptInvite(id: UUID) {
        if let index = userProfiles.firstIndex(where: { $0.id == id }) {
            userProfiles[index].inviteAccepted = true
        }
    }
}


