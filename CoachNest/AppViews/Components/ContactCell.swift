//
//  ContactCell.swift
//  CoachNest
//
//  Created by ios on 25/12/24.
//

import SwiftUI

struct ContactCell: View {
    
    var contact: MemberDetail
    var isSelected: Bool
    
    var body: some View {
        HStack{
            Image(uiImage: contact.profileImage ?? .sg1)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(.circle)
            VStack(alignment: .leading){
                Text(contact.name)
                    .customFont(.semiBold, 14)
                Text(contact.accountType.rawValue)
                    .customFont(.regular, 12)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            Image(isSelected ? .checkboxFill : .checkboxEmpty)
                .resizable()
                .frame(width: 24, height: 24)
                .clipShape(.circle)
            
        } .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    let member = MemberDetail(name: "Rahul Pathania", profileImage: .sg1, accountType: .coach)
    ContactCell(contact: member, isSelected: false)
}
