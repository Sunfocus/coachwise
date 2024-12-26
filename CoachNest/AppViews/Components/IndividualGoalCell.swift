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
    let progress: Double
    var goal: GoalDetails
    
    var body: some View {
        HStack(spacing: 16) {
            // Circular Progress
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                Circle()
                    .trim(from: 0, to: progress / 100)
                    .stroke(Color.pink, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text("\(Int(progress))%")
                    .font(.system(size: 14, weight: .bold))
            }
            .frame(width: 60, height: 60)
            
            // Task Info
            
           
                VStack(alignment: .leading, spacing: 4) {
                    Text(goal.goalTitle)
                        .customFont(.semiBold, 15)
                    
                    if goal.cellType == .individual{
                        HStack(spacing: 7) {
                            Image(uiImage: .sg1)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Text(goal.savedMembers.first?.name ?? "Guest")
                                .customFont(.medium, 13)
                                .foregroundColor(.gray)
                        }
                    }else{
                        SelectedMemberView(selectedMembers: goal.savedMembers)
                    }
                }
            
            Spacer()
            
            // Update Date and Arrow
            VStack(alignment: .trailing, spacing: 4) {
                Image(.rightArrow)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                Text("Update: \(goal.updateDate.formattedDate(customFormat: "dd-MM-yyyy"))")
                    .customFont(.medium, 12)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
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
