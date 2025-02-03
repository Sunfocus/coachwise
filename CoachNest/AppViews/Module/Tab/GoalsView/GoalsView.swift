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
    @State private var searchedText = ""
    @State private var isRecording: Bool = false
    @State private var addGoalViewIsPresented: Bool = false
    @State private var isFilterViewPresented: Bool = false
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @StateObject var speechManager: SpeechManager
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentSideMenu) var presentSideMenu
    
    var body: some View {
        ZStack{
            VStack{
                topHeaderView
                if addGoalViewModel.getAllGoals().isEmpty{
                    noGoalToView
                }else{
                    goalListingView
                }
            }
        }.background(.backgroundTheme)
            .overlay(
                addGoalButtonView
                .padding(.trailing, 30)
                .padding(.bottom, 40),
               alignment: .bottomTrailing
            )
            .fullScreenCover(isPresented: $addGoalViewIsPresented) {
                AddGoalView(comingFrom: .addNewGoal, goalId: UUID(), userType: .coach)
            }
            .sheet(isPresented: $isFilterViewPresented) {
                FilterView(isComingFrom: .addNewGoal, filterOptions: Constants.goalFilterOptions)
                    .presentationDetents([.height(280)])
                    .presentationDragIndicator(.visible)
                    .presentationContentInteraction(.scrolls)
            }
    }
    
    //MARK: - Subviews -
    var topHeaderView: some View {
        //Tab Name menu icon filter and notification toggle Section
        VStack(spacing: 0){
            //Tab Name menu icon filter and notification toggle Section
            HStack {
                Image(.menuIcon)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        presentSideMenu.wrappedValue.toggle()
                    }
                Text("Goals")
                    .customFont(.semiBold, 24)
                Spacer()
                Image(.bell)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        router.navigate(to: .notificationView)
                    }
                    .padding(.trailing, 12)
                Image(.filterList)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        isFilterViewPresented = true
                    }
            }.padding([.horizontal, .vertical], 15)
            
            //Search Member View Section
            if !addGoalViewModel.goals.isEmpty{
                HStack{
                    Image(.searchIcon)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.leading)
                    
                    TextField("Search here...", text: $searchedText)
                        .customFont(.regular, 14)
                    Spacer()
                    Image(.micIcon)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 15, height: 20)
                        .foregroundColor(isRecording ? .red : .gray)
                        .padding(.trailing)
                        .onTapGesture {
                            if isRecording{
                                searchedText = ""
                                speechManager.stopVoiceSearch()
                            }else{
                                speechManager.startVoiceSearch { voiceText in
                                    searchedText = voiceText
                                    if !voiceText.isEmpty{
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                                            print(voiceText)
                                            speechManager.stopVoiceSearch()
                                            isRecording = false
                                        }
                                    }
                                }
                            }
                            isRecording.toggle()
                        }
                }
                .frame(height: 45)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(colorScheme == .dark ? .lightGrey.opacity(0.1) : .lightGrey)
                .clipShape(.rect(cornerRadius: 18))
                .padding([.horizontal, .bottom])
            }
            Divider()
        }
        .background(.darkGreyBackground)
        .padding( .bottom, 10)
    }
    var noGoalToView: some View{
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
    }
    var goalListingView: some View{
        
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
                        withAnimation {
                            addGoalViewModel.deleteGoal(byID: goal.id)
                        }
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
        .safeAreaPadding(EdgeInsets(top: 5, leading: 0, bottom: 100, trailing: 0))
        .scrollIndicators(.hidden)
        
        //list ends
    }
    var addGoalButtonView: some View {
        Button(action: {
            print("Add new tapped")
            addGoalViewIsPresented = true
        }) {
            Circle()
                .foregroundStyle(.primaryTheme)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(.white)
                }
        }
    }
}

#Preview {
    GoalsView(speechManager: SpeechManager())
        .environmentObject(Router())
        .environmentObject(AddGoalViewModel())
}
