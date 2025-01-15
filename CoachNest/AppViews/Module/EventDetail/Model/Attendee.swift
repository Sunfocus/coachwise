//
//  AttendeeModel.swift
//  CoachNest
//
//  Created by ios on 15/01/25.
//
import SwiftUI

struct Attendee: Codable, Hashable, Identifiable{
    var id: UUID
    var name: String
    var rating: Int
    var contactNumber: String
    var hasAttendedClass: Bool
    let profileImageData: Data
    var profileImage: UIImage? {
        UIImage(data: profileImageData)
    }
    
    init(id: UUID, name: String, rating: Int, contactNumber: String, hasAttendedClass: Bool, profilePicture: UIImage) {
        self.id = id
        self.name = name
        self.rating = rating
        self.contactNumber = contactNumber
        self.hasAttendedClass = hasAttendedClass
        self.profileImageData = profilePicture.jpegData(compressionQuality: 1.0) ?? Data()
    }
}
