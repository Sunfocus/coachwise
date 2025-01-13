//
//  AddGoalView.swift
//  CoachNest
//
//  Created by ios on 24/12/24.
//

import SwiftUI

public enum ComingFrom: Codable{
    case addNewGoal
    case editGoal
    case chat
}

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
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var addGoalViewModel: AddGoalViewModel
    @State private var isInitialized = false
    @State private var addMemberViewIsPresented = false
    
    var comingFrom: ComingFrom = .addNewGoal
    var goalId: UUID?
    var userType: AccountType = .coach
    var editedGoal: GoalDetails? {
        return addGoalViewModel.getGoal(byID: goalId ?? UUID() )
    }
    var savedMembers: [MemberDetail]{
        if comingFrom == .editGoal{
            return editedGoal?.savedMembers ?? []
        }else{
            return contactsViewModel.savedMembers
        }
    }
    
    
    var body: some View {
        ZStack{
            if colorScheme != .dark{
                Color.lightGrey
                    .ignoresSafeArea()
            }
                VStack{
                    topHeaderView
                    ScrollView{
                    VStack(spacing: 20){
                        addGoalNameView
                        addGoalMembers
                        goalDescription
                        selectGoalDueDate
                        selectReminderType
                    }.padding(.horizontal, 15)
                    
                    Spacer()
                    }.scrollIndicators(.hidden)
                    
                    // MARK: - Add Goal Button
                    VStack{
                        Text(errorCatch)
                            .customFont(.medium, 12)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.padding(.horizontal, 15)
                    
                    CustomButton(
                        title: (comingFrom == .addNewGoal ? Constants.AddYourGoalsViewTitle.addGoal : Constants.AddYourGoalsViewTitle.editGoal),
                        action: {
                            let isValidName = addGoalViewModel.checkValidGoalName(goalName: goalName)
                            let isValidUser = contactsViewModel.savedMembers.count > 0
                            let isValidDescription = addGoalViewModel.checkValidGoalDescription(goalDescription: description)
                            let goal = GoalDetails(
                                        goalTitle: goalName,
                                        updateDate: Date(),
                                        createdBy: MemberDetail(id: 007, name: "Rahul Pathania", profileImage: .sg1, accountType: .coach, progress: 0.0),
                                        savedMembers: contactsViewModel.savedMembers,
                                        description: description,
                                        dueOnDate: dueDate,
                                        reminder: selectedOption)
                            if isValidName{
                                if isValidUser{
                                    if isValidDescription{
                                        if comingFrom == .editGoal{
                                            addGoalViewModel.updateGoal(byID: editedGoal!.id , newGoal: goal)
                                        }else{
                                            addGoalViewModel.addGoal(goal)
                                        }
                                        contactsViewModel.resetSelection()
                                      //  router.dashboardNavigateBack()
                                        dismiss()
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
                    
                }.onAppear{
                    if comingFrom == .editGoal{
                        goalName = editedGoal?.goalTitle ?? ""
                        description = editedGoal?.description ?? ""
                        dueDate = editedGoal?.dueOnDate ?? Date()
                        selectedOption = editedGoal?.reminder ?? .daily
                        if !isInitialized {
                            print("MyView initialized for the first time.")
                            isInitialized = true
                            contactsViewModel.updateSelection(members: editedGoal?.savedMembers ?? [])
                        }else{
                            
                        }
                    }
                }
        }.navigationBarBackButtonHidden()
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
            .fullScreenCover(isPresented: $addMemberViewIsPresented) {
                AddMemberView(speechManager: SpeechManager(), goalId: goalId ?? UUID(), isComingFrom: .addNewGoal)
            }
    }
    //MARK: - Subviews
    var topHeaderView: some View{
        // Heading and dismiss button section
        VStack{
            HStack {
                Image(.greyCloseButton)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        dismiss()
                        contactsViewModel.resetSelection()
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
    }
    var addGoalNameView: some View{
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
                .tint(.primary)
        }
    }
    var addGoalMembers: some View{
        //Who is this goal for Section
        VStack(spacing: 6){
            Text(Constants.TextField.Title.whoIsThisGoalFor)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                if !savedMembers.isEmpty{
                    SelectedMemberView(selectedMembers: contactsViewModel.savedMembers)
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
                   //     router.navigate(to: .addMember(goalId: goalId ?? UUID(), comingFrom: comingFrom))
                        addMemberViewIsPresented = true
                    }
                    
            }.frame(height: 48)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
                
        }
    }
    var goalDescription: some View{
        //Description Section
        VStack(spacing: 6){
            Text(Constants.TextField.Title.description)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack{
                TextField(Constants.TextField.Placeholder.goalDescription, text: $description, axis: .vertical)
                    .customFont(.regular, 14)
                    .tint(.primary)
                    .lineLimit(4, reservesSpace: true)
                    .textFieldStyle(.plain)
            }
            .padding()
            .background(.darkGreyBackground)
            .cornerRadius(8)
        }
    }
    var selectGoalDueDate: some View{
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
    }
    var selectReminderType: some View{
        //Reminder selection Section
        VStack(spacing: 6){
            Text(Constants.TextField.Title.reminder)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            ReminderView(selectedOption: $selectedOption)
        }
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



