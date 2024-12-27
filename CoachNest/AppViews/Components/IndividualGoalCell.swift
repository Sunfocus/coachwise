//
//  IndividualGoalCell.swift
//  CoachNest
//
//  Created by ios on 26/12/24.
//

import SwiftUI

enum GoalType: Codable{
    case individual
    case group
}


struct IndividualGoalCell: View {
    var goal: GoalDetails
    var colorArray: [Color] = [Color.green, Color.pink, Color.blue, Color.purple]
    
    var body: some View {
        HStack(spacing: 16) {
            // Circular Progress
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                Circle()
                    .trim(from: 0, to: goal.progress / 100)
                    .stroke(colorArray.randomElement()!, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text("\(Int(goal.progress))%")
                    .font(.system(size: 14, weight: .bold))
            }
            .frame(width: 60, height: 60)
            
            // Task Info
                VStack(alignment: .leading, spacing: 6) {
                    Text(goal.goalTitle)
                        .customFont(.semiBold, 15)
                        .lineLimit(1)
                    if goal.cellType == .individual{
                        HStack(spacing: 7) {
                            Image(uiImage: goal.savedMembers.first?.profileImage ?? .sg1 )
                                .resizable()
                                .scaledToFill()
                                .frame(width: 22, height: 22)
                                .clipShape(Circle())
                            Text(goal.savedMembers.first?.name ?? "Guest")
                                .customFont(.medium, 13)
                                .lineLimit(1)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }else{
                        SelectedMemberView(selectedMembers: goal.savedMembers)
                    }
                }
            
            Spacer()
            
            // Update Date and Arrow
            VStack(alignment: .trailing, spacing: 4) {
                Image(.rightArrow)
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundColor(.gray)
                Text(goal.updateDate.formattedDate(customFormat:"MMM dd, yyyy"))
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

struct IndividualGoalCell_Previews: PreviewProvider {
    static var previews: some View {
        
        let goal = GoalDetails(progress: 20, goalTitle: "Learn Swift", updateDate: Date(), savedMembers: [MemberDetail(name: "Jayson Anderson", profileImage: .sg1, accountType: .coach)], description: "play with swift", dueOnDate: Date(), reminder: .daily)
        
        
        IndividualGoalCell(goal: goal)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

extension Date {
    func formattedDate(style: DateFormatter.Style = .long, customFormat: String? = nil) -> String {
        let formatter = DateFormatter()
        if let customFormat = customFormat {
            formatter.dateFormat = customFormat
        } else {
            formatter.dateStyle = style
            formatter.timeStyle = .none
        }
        return formatter.string(from: self)
    }
}
