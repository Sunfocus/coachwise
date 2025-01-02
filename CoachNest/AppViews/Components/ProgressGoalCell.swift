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


struct ProgressGoalCell: View {
    var goal: GoalDetails
    var colorArray: [Color] = [Color.yellow, Color.blue, Color.pink, Color.green]
    // Function to assign a color based on progress
        private var assignedColor: Color {
            switch progress {
            case 0..<25:
                return colorArray[0] // Red for 0-24% progress
            case 25..<50:
                return colorArray[1] // Orange for 25-49% progress
            case 50..<75:
                return colorArray[2] // Yellow for 50-74% progress
            default:
                return colorArray[3] // Green for 75-100% progress
            }
        }
    @EnvironmentObject private var viewModel: AddGoalViewModel
    
    var progress: Double {
        if goal.cellType == .individual {
            return goal.savedMembers.first?.progress ?? 0.0
        } else {
            print("group percentage total: \(viewModel.getGroupProgress(byID: goal.id))")
            return viewModel.getGroupProgress(byID: goal.id)
        }
    }
    
    var body: some View {
    
        HStack(spacing: 16) {
            // Circular Progress
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                Circle()
                    .trim(from: 0, to: (progress) / 100)
                    .stroke(assignedColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text("\(Int((progress)))%")
                    .font(.system(size: 14, weight: .bold))
            }
            .frame(width: 60, height: 60)
            
            // Task Info
                VStack(alignment: .leading, spacing: 6) {
                    Text(goal.goalTitle)
                        .customFont(.semiBold, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
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
            
         //   Spacer()
            
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

struct ProgressGoalCell_Previews: PreviewProvider {
    static var previews: some View {
        
        let goal = GoalDetails(goalTitle: "Learn to solve rubiks cube", updateDate: Date(), createdBy: MemberDetail(id: 007, name: "Rahul Pathania", profileImage: .sg1, accountType: .coach, progress: 0.0), savedMembers: [MemberDetail(id: 01, name: "Jayson Anderson", profileImage: .sg1, accountType: .coach, progress: 53.0)], description: "play with swift", dueOnDate: Date(), reminder: .daily)
        
       ProgressGoalCell(goal: goal)
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
