//
//  EditProfileViewModel.swift
//  CoachNest
//
//  Created by Rahul Pathania on 04/02/25.
//

import SwiftUI

class EditProfileViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var emergencyContact: String = ""
    @Published var relationshipToMember: String = ""
    @Published var emergencyContactMobile: String = ""
    @Published var allergies: String = ""
    @Published var injuries: String = ""
    @Published var dueDate: Date = Date()
    
    func updateProfile(firstName: String, lastName: String, phone: String, email: String, emergencyContact: String, relationship: String, emergencyMobile: String, allergies: String, injuries: String, dueDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.emergencyContact = emergencyContact
        self.relationshipToMember = relationship
        self.emergencyContactMobile = emergencyMobile
        self.allergies = allergies
        self.injuries = injuries
        self.dueDate = dueDate
    }
}
