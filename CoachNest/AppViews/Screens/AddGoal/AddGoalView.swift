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
    @State private var date = Date.now
    @State private var showDatePicker = false
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dismiss
    
    var userType: AccountType = .coach
    
    var body: some View {
        ZStack{

            Color.lightGrey
                .ignoresSafeArea()
            
                VStack{
                    // Heading and dismiss button section
                    VStack{
                        HStack {
                            Image(.greyCloseButton)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .onTapGesture {
                                    dismiss()
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
                    .background(.white)
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
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 8))
                                .tint(.black)
                        }
                        
                        //Who is this goal for Section
                        VStack(spacing: 6){
                            Text(Constants.TextField.Title.whoIsThisGoalFor)
                                .customFont(.regular, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack{
                                Image(.addGoalMemberButton)
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        router.navigate(to: .addMember, style: .fullScreenCover)
                                        HapticFeedbackHelper.mediumImpact()
                                    }
                            }.frame(height: 48)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.white)
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
                            .background(Color.white)
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
                                DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                                    .colorInvert()
                                    .colorMultiply(.primaryTheme)
                                    .tint(.primaryTheme)
                                    .labelsHidden()
                                    .padding(.trailing, 10)
                                
                                
                            }.frame(height: 55)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 8))
                            
                        }
                        
                        //Reminder selection Section
                        VStack(spacing: 6){
                            Text(Constants.TextField.Title.reminder)
                                .customFont(.regular, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ReminderView()
                        }
                        
                    }.padding(.horizontal, 15)
                    
                    Spacer()
                }
                    
                    // MARK: - Login Button
                    CustomButton(
                        title: Constants.AddYourGoalsViewTitle.addGoal,
                        action: {
                            
                        }
                    ).padding(.horizontal, 15)
                        .padding(.bottom)
            }
        }
    }
}

#Preview {
    AddGoalView()
}


struct ReminderView: View {
    
    enum DurationVal: String, Equatable {
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"
    }
    
    @State private var selectedOption: DurationVal = .daily
    
    let options: [DurationVal] = [.daily, .weekly, .monthly]
    
    var body: some View {
       
            
        HStack(spacing: 12) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    HapticFeedbackHelper.mediumImpact()
                }) {
                    Text(option.rawValue)
                        .customFont(.regular, 15)
                        .foregroundColor(selectedOption == option ? .primaryTheme : .black)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(
                            selectedOption == option
                            ? Color.primaryTheme.opacity(0.2)
                            : Color.white
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(selectedOption == option ? .primaryTheme : Color.gray, lineWidth: 1)
                        )
                        .cornerRadius(8)
                }
            }
        }.frame(maxWidth: .infinity)
        
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
            .environmentObject(Router())
    }
}
