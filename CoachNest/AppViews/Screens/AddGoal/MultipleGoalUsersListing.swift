//
//  MultipleGoalUsersListing.swift
//  CoachNest
//
//  Created by ios on 30/12/24.
//

import SwiftUI

struct MultipleGoalUsersListing: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var addGoalViewModel: AddGoalViewModel
    var goalId: UUID
    var goal: GoalDetails? {
       return addGoalViewModel.getGoal(byID: goalId)
    }
    
    
    var body: some View {
       
        ZStack{
            VStack{

                // Heading and back button Section
                VStack{
                    HStack {
                        Image(.arrowBack)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                //back button tapped
                                router.dashboardNavigateBack()
                            }
                        Spacer()
                        
//                        Image(.more)
//                            .resizable()
//                            .frame(width: 24, height: 24)
//                            .onTapGesture {
//                                //more button tapped
//                            }
                        
                        
                    }.padding([.horizontal, .vertical], 15)
                        .overlay {
                            HStack{
                                Text(goal?.goalTitle ?? "Dummy Name")
                                    .customFont(.semiBold, 16)
                            }
                        }
                    Divider()
                }
                .background(.darkGreyBackground)
                
                Spacer()
                
                ScrollView{
                    ForEach(goal!.savedMembers) { member in
                        PersonGoalCell(goal: goal!, member: member)
                            .padding(.horizontal)
                            .padding(.bottom, 4)
                            .onTapGesture {
                                router.navigate(to: .goalDetailedView(goalId: goalId, member: member))
                            }
                    }
                }.safeAreaPadding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
                 .scrollIndicators(.hidden)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MultipleGoalUsersListing(goalId: UUID())
}
