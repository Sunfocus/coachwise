//
//  SelectedMemberView.swift
//  CoachNest
//
//  Created by ios on 26/12/24.
//

import SwiftUI

struct SelectedMemberView: View {

    var selectedMembers: [MemberDetail] = []
    
    var body: some View {
        HStack{
            HStack(spacing: -10){
                let visibleCount = min(max(selectedMembers.count, 1), 3)
                ForEach(selectedMembers.prefix(visibleCount)) { member in
                    Image(uiImage: member.profileImage ?? .sg1 )
                        .resizable()
                        .scaledToFill()
                        .frame(width: 24, height: 24)
                        .clipShape(.circle)
                }
                // Show the remaining count if there are more than 5 members
                if selectedMembers.count > 3 && selectedMembers.count < 100  {
                    Text("+\(selectedMembers.count - 5)")
                        .customFont(.semiBold, 12)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
            }
            
            if selectedMembers.count >= 100  {
                Text("and \(selectedMembers.count - 5) others")
                    .customFont(.semiBold, 12)
            }
        }
    }
}

#Preview {
    let selectedMember = [
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach), MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach), MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach), MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f3, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .f2, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach),
        MemberDetail(name: "Rahul", profileImage: .sg1, accountType: .coach)
        
    ]
    SelectedMemberView(selectedMembers: selectedMember)
}

