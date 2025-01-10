//
//  PersonGoalCell.swift
//  CoachNest
//
//  Created by ios on 30/12/24.
//

import SwiftUI

struct PersonGoalCell: View {
    
    var goal: GoalDetails
    var colorArray: [Color] = [Color.green, Color.pink, Color.blue, Color.purple]
    @EnvironmentObject private var viewModel: AddGoalViewModel
    var member: MemberDetail
    
    
    var body: some View {
        HStack(spacing: 16) {
            // Circular Progress
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                Circle()
                    .trim(from: 0, to: (member.progress) / 100)
                    .stroke(colorArray.randomElement()!, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text("\(Int((member.progress)))%")
                    .font(.system(size: 14, weight: .bold))
            }
            .frame(width: 60, height: 60)
            
            // Task Info
                VStack(alignment: .leading, spacing: 6) {
                    Text(goal.goalTitle)
                        .customFont(.semiBold, 15)
                        .lineLimit(1)
                   
                        HStack(spacing: 7) {
                            Image(uiImage: member.profileImage ?? .sg1 )
                                .resizable()
                                .scaledToFill()
                                .frame(width: 22, height: 22)
                                .clipShape(Circle())
                            Text(member.name)
                                .customFont(.medium, 13)
                                .lineLimit(1)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            
            Spacer()
            
            // Update Date and Arrow
            VStack(alignment: .trailing, spacing: 4) {
                Image(.rightArrow)
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundColor(.gray)
                Text(goal.dueOnDate.formattedDate(customFormat:"MMM dd, yyyy"))
                    .customFont(.medium, 12)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(.darkGreyBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    
    let goal = GoalDetails(goalTitle: "Learn Swift", updateDate: Date(), createdBy: MemberDetail(id: 007, name: "Rahul Pathania", profileImage: .sg1, accountType: .coach, progress: 0.0), savedMembers: [MemberDetail(id: 01, name: "Jayson Anderson", profileImage: .sg1, accountType: .coach, progress: 53.0)], description: "play with swift", dueOnDate: Date(), reminder: .daily)
    let member = MemberDetail(id: 09, name: "Jayson Anderson", profileImage: .sg1, accountType: .coach, progress: 53.0)
    
    
    PersonGoalCell(goal: goal, member: member)
        .environmentObject(AddGoalViewModel())
}
