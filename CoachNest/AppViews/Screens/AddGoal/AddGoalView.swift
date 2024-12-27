//
//  AddGoalView.swift
//  CoachNest
//
//  Created by ios on 24/12/24.
//

import SwiftUI

struct AddGoalView: View {
    
    //MARK: - Variables -
    @State private var goalName: String = ""
    @State private var description: String = ""
    @State private var dueDate = Date.now
    @State private var showDatePicker = false
    @State private var errorCatch: String = ""
    @State private var selectedOption: DurationVal = .daily
    @EnvironmentObject var router: Router
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var whoIsThisGoalForViewModel: ContactsViewModel
    @EnvironmentObject var addGoalViewModel: AddGoalViewModel
    
    
    var userType: AccountType = .coach
    
    var body: some View {
        ZStack{

            if colorScheme != .dark{
                Color.lightGrey
                    .ignoresSafeArea()
            }
            
                VStack{
                    // Heading and dismiss button section
                    VStack{
                        HStack {
                            Image(.arrowBack)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .onTapGesture {
                                    router.dashboardNavigateBack()
                                }
                            Spacer()
                        }.padding([.horizontal, .vertical], 15)
                            .overlay {
                                HStack{
                                    Text(Constants.AddYourGoalsViewTitle.addGoal)
                                        .customFont(.medium, 16)
                                }
                            }
                        Divider()
                    }
                    .background(.darkGreyBackground)
                    .padding( .bottom)
                    
                    ScrollView{
                    // Add Goal Input fields Section
                    VStack(spacing: 20){
                        
                        // Enter Goal Name Section
                        VStack(spacing: 6){
                            Text(Constants.TextField.Title.goal)
                                .customFont(.regular, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField(Constants.TextField.Placeholder.goalName, text: $goalName)
                                .customFont(.regular, 14)
                                .frame(height: 48)
                            
                                .padding(.horizontal)
                                .background(.darkGreyBackground)
                                .clipShape(.rect(cornerRadius: 8))
                                .tint(.black)
                        }
                        
                        //Who is this goal for Section
                        VStack(spacing: 6){
                            Text(Constants.TextField.Title.whoIsThisGoalFor)
                                .customFont(.regular, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack{
                                if !whoIsThisGoalForViewModel.savedMembers.isEmpty{
                                    SelectedMemberView(selectedMembers: whoIsThisGoalForViewModel.savedMembers)
                                        .padding(.leading)
                                    }
                                Spacer()
                                Text("Add Members")
                                    .customFont(.medium, 15)
                                    .padding(8)
                                    .foregroundStyle(.primaryTheme)
                                    .background(.primaryTheme.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .padding(.trailing, 12)
                                    .onTapGesture {
                                        whoIsThisGoalForViewModel.getSelectedSaves()
                                        router.navigate(to: .addMember)
                                        HapticFeedbackHelper.softImpact()
                                    }
                                    
                            }.frame(height: 48)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.darkGreyBackground)
                                .clipShape(.rect(cornerRadius: 8))
                                
                        }
                        
                        //Description Section
                        VStack(spacing: 6){
                            Text(Constants.TextField.Title.description)
                                .customFont(.regular, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            VStack{
                                TextField(Constants.TextField.Placeholder.addNotesHere, text: $description, axis: .vertical)
                                    .customFont(.regular, 14)
                                    .tint(.primaryTheme)
                                    .lineLimit(4, reservesSpace: true)
                                    .textFieldStyle(.plain)
                            }
                            .padding()
                            .background(.darkGreyBackground)
                            .cornerRadius(8)
                        }
                        
                        //Due on selection date Section
                        VStack(spacing: 6){
                            Text(Constants.TextField.Title.dueOn)
                                .customFont(.regular, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(){
                                Text("Select Date")
                                    .customFont(.regular, 16)
                                    .padding(.leading, 10)
                                    .foregroundStyle(Color.gray)
                                
                                Spacer()
                                DatePicker("", selection: $dueDate, in: Date()..., displayedComponents: .date)
                                    .tint(colorScheme == .dark ? .white : .primaryTheme)
                                    .labelsHidden()
                                    .padding(.trailing, 10)
                                
                                
                            }.frame(height: 55)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.darkGreyBackground)
                                .clipShape(.rect(cornerRadius: 8))
                            
                        }
                        
                        //Reminder selection Section
                        VStack(spacing: 6){
                            Text(Constants.TextField.Title.reminder)
                                .customFont(.regular, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ReminderView(selectedOption: $selectedOption)
                        }
                        
                    }.padding(.horizontal, 15)
                    
                    Spacer()
                }
                    
                    // MARK: - Add Goal Button
                    VStack{
                        Text(errorCatch)
                            .customFont(.medium, 12)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.padding(.horizontal, 15)
                    
                    CustomButton(
                        title: Constants.AddYourGoalsViewTitle.addGoal,
                        action: {
                            let isValidName = addGoalViewModel.checkValidGoalName(goalName: goalName)
                            let isValidUser = whoIsThisGoalForViewModel.savedMembers.count > 0
                            let isValidDescription = addGoalViewModel.checkValidGoalDescription(goalDescription: description)
                            let goal = GoalDetails(progress: 0.0,
                                        goalTitle: goalName,
                                        updateDate: Date(),
                                        savedMembers: whoIsThisGoalForViewModel.savedMembers,
                                        description: description,
                                        dueOnDate: dueDate,
                                        reminder: selectedOption)
                            if isValidName{
                                if isValidUser{
                                    if isValidDescription{
                                        addGoalViewModel.addGoal(goal)
                                        whoIsThisGoalForViewModel.savedMembers = []
                                        router.dashboardNavigateBack()
                                    }else{
                                        errorCatch = "Please add description for the goal."
                                    }
                                }else{
                                    errorCatch = "Please add members for the goal."
                                }
                            }else{
                                errorCatch = "Please fill a valid Goal name."
                            }
                        }
                    ).padding(.horizontal, 15)
                        .padding(.bottom)
                    
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    AddGoalView()
        .environmentObject(ContactsViewModel())
        .environmentObject(Router())
}


struct ReminderView: View {
    
    @Binding var selectedOption: DurationVal
    
    let options: [DurationVal] = [.daily, .weekly, .monthly]
    
    var body: some View {
       
            
        HStack(spacing: 12) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    HapticFeedbackHelper.softImpact()
                }) {
                    Text(option.rawValue)
                        .customFont(.regular, 15)
                        .foregroundColor(selectedOption == option ? .primaryTheme : .cursorTint)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(
                            selectedOption == option
                            ? Color.primaryTheme.opacity(0.2)
                            : Color.darkGreyBackground
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(selectedOption == option ? .primaryTheme : .cursorTint , lineWidth: 1)
                        )
                        .cornerRadius(8)
                }
            }
        }.frame(maxWidth: .infinity)
        
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView(selectedOption: .constant(.daily))
            .environmentObject(Router())
    }
}



