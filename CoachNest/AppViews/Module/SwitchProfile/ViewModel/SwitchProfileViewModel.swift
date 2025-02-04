//
//  SwitchProfileViewModel.swift
//  CoachNest
//
//  Created by Rahul Pathania on 03/02/25.
//

import Foundation

class SwitchProfileViewModel: ObservableObject{
    @Published var selectedProfile: SwitchProfile = SwitchProfile(clubName: "Glen Wavery Cricket Club",
                                                                  clubId: "AZ212312",
                                                                  inviteAccepted: true,
                                                                  profileType: .coach)
    
    @Published var userProfiles: [SwitchProfile] = [
        SwitchProfile(clubName: "Glen Wavery Cricket Club",
                           clubId: "AZ212312",
                           inviteAccepted: true,
                           profileType: .coach),
        
        SwitchProfile(clubName: "Jack Gym Club",
                           clubId: "BH212323",
                           inviteAccepted: true,
                           profileType: .coach),
        
        SwitchProfile(clubName: "Ramzy Painting Club",
                           clubId: "GF212323",
                           inviteAccepted: true,
                           profileType: .superAdmin),
        
        SwitchProfile(clubName: "Lukas Rugby Club",
                           clubId: "Jx212323",
                           inviteAccepted: false,
                           profileType: .member),
        
        SwitchProfile(clubName: "Max Walter",
                           clubId: "TF212323",
                           inviteAccepted: true,
                           profileType: .parent),
        
        
        SwitchProfile(clubName: "Jack Gym Club",
                           clubId: "XH212323",
                           inviteAccepted: true,
                           profileType: .coach),
        
        SwitchProfile(clubName: "Ramzy Painting Club",
                           clubId: "XF212323",
                           inviteAccepted: true,
                           profileType: .superAdmin),
        
        SwitchProfile(clubName: "Lukas Rugby Club",
                           clubId: "VC212323",
                           inviteAccepted: false,
                           profileType: .member),
        
        SwitchProfile(clubName: "Max Walter",
                           clubId: "VC212343",
                           inviteAccepted: true,
                           profileType: .parent)
        
    ]
    
    func getProfiles() -> [SwitchProfile] {
        return userProfiles.sorted { $0.inviteAccepted && !$1.inviteAccepted }
    }
    
    func acceptInvite(id: UUID) {
        if let index = userProfiles.firstIndex(where: { $0.id == id }) {
            userProfiles[index].inviteAccepted = true
        }
    }
}


