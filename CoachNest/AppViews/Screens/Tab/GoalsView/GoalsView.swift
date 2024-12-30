//
//  GoalsView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 23/12/24.
//

import SwiftUI

struct GoalsView: View {
    
    //MARK: - Variables -
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var addGoalViewModel: AddGoalViewModel
    
    
    var body: some View {
        ZStack{
            if addGoalViewModel.getAllGoals().isEmpty{
                //MARK: - No goal to view Section -
                VStack{
                    Spacer()
                    Image(.goal)
                        .resizable()
                        .frame(width: 64, height: 64)
                    Text(Constants.AddYourGoalsViewTitle.noGoals)
                        .customFont(.medium, 16)
                        .foregroundStyle(.primaryTheme)
                    Text(Constants.AddYourGoalsViewTitle.tapAdd)
                        .customFont(.regular, 14)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }else{
                
                List(addGoalViewModel.getAllGoals()) { goal in
                    ProgressGoalCell(goal: goal)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                        .swipeActions {
                            // Edit Button
                            Button(action: {
                                // Handle the edit action (e.g., navigate to an edit screen)
                                router.navigate(to: .addGoalView(userType: .coach, goalId: goal.id, comingFrom: .editGoal))
                            }) {
                                Label("Edit", image: .editGoal)
                            }
                            .tint(.blue)
                            

                            // Delete Button
                            Button(action: {
                                
                                addGoalViewModel.deleteGoal(byID: goal.id)
                            }) {
                                Label("Delete", image: .deleteGoal)
                            }
                            .tint(.red)
                        }
                        .onTapGesture {
                            if goal.cellType == .individual {
                                if let member = addGoalViewModel.getFirstMember(byID: goal.id) {
                                    router.navigate(to: .goalDetailedView(goalId: goal.id, member: member))
                                } else {
                                    print("Member not found for the given goal ID.")
                                }
                            } else {
                                router.navigate(to: .multipleGoalUsersListing(goalId: goal.id))
                            }
                        }
                        
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden, edges: .all)
                        .background(.backgroundTheme)
                }.listStyle(PlainListStyle())
               

            }
        }.background(.backgroundTheme)
            .overlay(
                Button(action: {
                    print("Add new tapped")
                    router.navigate(to: .addGoalView(userType: .coach, goalId: UUID(), comingFrom: .addNewGoal))
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.primaryTheme)
                }
                .padding(.trailing, 30)
                .padding(.bottom, 40),
               alignment: .bottomTrailing
            )
        
    }
}

#Preview {
    GoalsView()
        .environmentObject(Router())
}
