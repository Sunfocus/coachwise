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
                        .frame(width: 22, height: 22)
                        .clipShape(.circle)
                }
                // Show the remaining count if there are more than 5 members
                if selectedMembers.count > 3 && selectedMembers.count < 100  {
                    Text("+\(selectedMembers.count - 3)")
                        .customFont(.semiBold, 12)
                        .foregroundColor(.white)
                        .frame(width: 22, height: 22)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
            }
            
            if selectedMembers.count >= 100  {
                Text("and \(selectedMembers.count - 3) others")
                    .customFont(.semiBold, 12)
            }
        }
    }
}

#Preview {
    let selectedMember = [
        MemberDetail(id: 01, name: "Rahul", profileImage: .sg1, accountType: .coach, progress: 0.0),
        MemberDetail(id: 02, name: "Rahul", profileImage: .f1, accountType: .coach, progress: 0.0),
    ]
    SelectedMemberView(selectedMembers: selectedMember)
}

