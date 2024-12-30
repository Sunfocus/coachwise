//
//  GoalDetailView.swift
//  CoachNest
//
//  Created by ios on 27/12/24.
//

import SwiftUI

struct GoalDetailView: View {
    
    //MARK: - Variables -
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var router: Router
    @EnvironmentObject var addGoalViewModel: AddGoalViewModel
    @State private var selectedSegment = 0
    var goalId: UUID
    var member: MemberDetail
    
    
    //Segment Control Custom UI Section

    
    
    
    var body: some View {
        
        let goal = addGoalViewModel.getGoal(byID: goalId)
        
        
        ZStack{
            
            //Background Color
            if colorScheme != .dark{
                Color.lightGrey
                    .ignoresSafeArea()
            }
            
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
                        
                        Image(.more)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                //more button tapped
                            }
                        
                        
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
                
                // Picker Control Section
                VStack{
                    Picker("Select Option", selection: $selectedSegment) {
                        Text("Details").tag(0)
                        Text("Action").tag(1)
                        Text("Feedback").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .frame(height: 44)
                }
                .padding([.horizontal, .vertical])
                   
                                
                //Goal Information and Status Section
                ScrollView{
                    VStack{
                        switch selectedSegment{
                        case 0:
                            //Goal Details
                            VStack(spacing: 30){
                                //Goal Name and Status Section
                                VStack{
                                    HStack{
                                        VStack{
                                            Text("Goal name")
                                                .customFont(.semiBold, 16)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text(goal?.goalTitle ?? "Dummy Name")
                                                .customFont(.regular, 14)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        Spacer()
                                        VStack{
                                            Text("Working on it")
                                                .customFont(.semiBold, 12)
                                                .padding(6.5)
                                                .background(.yellowAccent.opacity(0.3))
                                                .foregroundStyle(.yellow)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                            
                                        }
                                    }
                                }
                                
                                //Goal From and Assigned to Section
                                VStack(){
                                    HStack(spacing: 20){
                                        VStack(spacing: 5){
                                            Text("Goal from")
                                                .customFont(.semiBold, 16)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            HStack{
                                                Image(.sg1)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .clipShape(.circle)
                                                    .frame(width: 22, height: 22)
                                                
                                                Text("Rahul Pathania")
                                                    .customFont(.regular, 14)
                                                    .lineLimit(1)
                                            }.frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            
                                        }
                                        Spacer()
                                        VStack(spacing: 5){
                                            
                                            HStack{
                                                Text("Goal to")
                                                    .customFont(.semiBold, 16)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            }
                                            
                                            HStack{
                                                Image(uiImage: member.profileImage ?? .sg1)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .clipShape(.circle)
                                                    .frame(width: 22, height: 22)
                                                
                                                Text(member.name)
                                                    .customFont(.regular, 14)
                                                    .lineLimit(1)
                                            }.frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                    Divider()
                                }
                                
                                //Description Section
                                VStack(alignment: .leading, spacing: 10){
                                    Text(Constants.GoalInfoViewTitle.description)
                                        .customFont(.semiBold, 16)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text( goal?.description ?? "Complete a 30-day fitness challenge to improve overall strength and endurance. This goal includes daily workouts focusing on different muscle groups, with an emphasis on progressive difficulty. The objective is to build a consistent fitness routine, track progress, and see measurable improvements in stamina, flexibility, and muscle tone by the end of the challenge. Weekly assessments will help evaluate progress and make adjustments to the routine if needed. By the end of the 30 days, the goal is to feel more energized, healthier, and capable of performing exercises with better form and technique.")
                                        .customFont(.regular, 14)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                }
                                
                                //Due on, reminder, goal status section
                                HStack{
                                    VStack{
                                        Text(Constants.GoalInfoViewTitle.dueOn)
                                            .customFont(.semiBold,16)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text(goal?.dueOnDate.formattedDate(customFormat:"MMM dd, yyyy") ?? "No data")
                                            .customFont(.regular, 14)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    
                                    VStack{
                                        Text(Constants.GoalInfoViewTitle.reminder)
                                            .customFont(.semiBold,16)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text(goal?.reminder.rawValue ?? "No data")
                                            .customFont(.regular, 14)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    
                                    VStack{
                                        Text(Constants.GoalInfoViewTitle.goalStatus)
                                            .customFont(.semiBold,16)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(Int((member.progress)))%")
                                            .customFont(.regular, 14)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                            }.padding()
                                .background(.darkGreyBackground)
                        case 1:
                            //Actions
                            VStack{
                                //add new To do Section
                                VStack(spacing: 7){
                                    Text("To do")
                                        .customFont(.semiBold, 18)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    ForEach(0..<2, id: \.self) { _ in // Use ForEach for dynamic views
                                        ToDoCell()
                                    }
                                    
                                }
                               
                                .padding(.bottom)
                                //In progress Section
                                VStack(spacing: 7){
                                    Text("Pending")
                                        .customFont(.semiBold, 18)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    ForEach(0..<3, id: \.self) { _ in // Use ForEach for dynamic views
                                        ToDoCell()
                                    }
                                }
                               
                                .padding(.bottom)
                                //Completed Section
                                VStack(spacing: 7){
                                    Text("Completed")
                                        .customFont(.semiBold, 18)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    ForEach(0..<2, id: \.self) { _ in // Use ForEach for dynamic views
                                        ToDoCell()
                                    }
                                }
                            }
                        case 2:
                            //Feedback
                            EmptyView()
                        default:
                            EmptyView()
                        }
                    }
                 //   .background(.darkGreyBackground)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    .padding()
                }// Scroll End
               
                Spacer()
                
                // MARK: - Login Button
                VStack{
                    CustomButton(
                        title: Constants.GoalInfoViewTitle.markAsComplete,
                        action: {
                            router.dashboardNavigateBack()
                        }
                    )
                }
                .padding([.horizontal])
            }
        }.navigationBarBackButtonHidden()
        
         
    }
    
}

#Preview {
    GoalDetailView( goalId: UUID(), member: MemberDetail(id: 12, name: "dfgdg", profileImage: .sg1, accountType: .coach, progress: 32.0))
        .environmentObject(AddGoalViewModel())
}
