//
//  MemberDetailModel.swift
//  CoachNest
//
//  Created by Rahul Pathania on 04/02/25.
//

import Foundation
import SwiftUI

public struct MemberDetail: Codable, Hashable, Identifiable {
    public let id: Int
    let name: String
    let profileImageData: Data
    let accountType: AccountType
    let progress: Double
    var profileImage: UIImage? {
        UIImage(data: profileImageData)
    }

    init(id: Int, name: String, profileImage: UIImage, accountType: AccountType, progress: Double) {
        self.id = id
        self.name = name
        self.profileImageData = profileImage.jpegData(compressionQuality: 1.0) ?? Data()
        self.accountType = accountType
        self.progress = progress
    }
}
