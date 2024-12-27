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
                //MARK: - No goal view Section -
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
                
                ScrollView{
                    ForEach(addGoalViewModel.getAllGoals()) { goal in
                        IndividualGoalCell(goal: goal)
                            .padding(.horizontal)
                            .padding(.bottom, 4)
                            .onTapGesture {
                                router.navigate(to: .goalDetailedView(goalId: goal.id))
                            }
                    }
                }
            }
        }.background(.backgroundTheme)
            .overlay(
                Button(action: {
                    print("Add new tapped")
                    router.navigate(to: .addGoalView(userType: .coach))
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
