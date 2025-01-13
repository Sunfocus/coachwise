//
//  AddEventView.swift
//  CoachNest
//
//  Created by ios on 13/01/25.
//

import SwiftUI

struct AddEventView: View {
    
    //MARK: - Variables -
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @StateObject var eventViewModel = AddEventViewModel()
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @State private var isAddNewVenueViewPresented = false
    @State private var isAddNewEventTypeViewPresented = false
    @State private var isAddMemberViewIsPresented = false
    var savedMembers: [MemberDetail]{
        return contactsViewModel.savedMembers
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
                    VStack(spacing: 15){
                        addEventNameView
                        selectEventType
                        selectRecurrenceType
                        selectDateBasedOnRecurringTypeView
                        selectVenueType
                        locationDetail
                        memberLimit
                        addCoach
                    }.padding(.horizontal)
                }.safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                    .scrollIndicators(.hidden)
                Spacer()
                
                CustomButton(
                    title: Constants.addSchedule,
                    action: {
                        dismiss()
                    }
                ).padding(.horizontal, 15)
                    .padding(.bottom)
            }
        }.fullScreenCover(isPresented: $isAddMemberViewIsPresented) {
            AddMemberView(speechManager: SpeechManager(), goalId: UUID())
        }
        .fullScreenCover(isPresented: $isAddNewVenueViewPresented) {
            AddVenueView()
        }
    }
    
    //MARK: - Subviews
    var topHeaderView: some View{
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
                        Text(Constants.AddScheduleEventViewTitle.addEvent)
                            .customFont(.medium, 16)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
        .padding( .bottom)
    }
    var addEventNameView: some View{
        // Enter Goal Name Section
        VStack(spacing: 6){
            Text(Constants.AddScheduleEventViewTitle.eventName)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(Constants.TextField.Placeholder.eventName, text: $eventViewModel.eventName)
                .customFont(.regular, 14)
                .frame(height: 48)
                .padding(.horizontal)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
                .tint(.primary)
        }
    }
    var selectEventType: some View{
        VStack(spacing: 6){
            Text(Constants.AddScheduleEventViewTitle.eventType)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                DropDownMenu(
                    placeholder: Constants.TextField.Placeholder.eventType,
                    options: eventViewModel.eventTypes,
                    selectedOption: $eventViewModel.selectedEventType)
                Spacer()
                Button{
                    isAddNewEventTypeViewPresented = true
                } label: {
                    Text("Add Event")
                        .customFont(.medium, 14)
                        .foregroundStyle(.primaryTheme)
                        .padding()
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 10))
                }
            }
        }
    }
    var selectRecurrenceType: some View{
        VStack(spacing: 6){
            Text(Constants.AddScheduleEventViewTitle.recurrance)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 20){
                RecurrenceTypeSelectView(isSelected: eventViewModel.selectedRecurrenceType.rawValue == "One time", name: "One time")
                    .onTapGesture {
                        eventViewModel.selectedRecurrenceType = .once
                    }
                RecurrenceTypeSelectView(isSelected: eventViewModel.selectedRecurrenceType.rawValue == "Recurring", name: "Recurring")
                    .onTapGesture {
                        eventViewModel.selectedRecurrenceType = .recurring
                    }
                
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 2)
        }
    }
    var selectDateBasedOnRecurringTypeView: some View{
        Group{
            if eventViewModel.selectedRecurrenceType == .once{
                selectOneTimeDateView
            }else{
                reccuringDaysView
                selectFromToRecurrenceDate
                
            }
            selectStartEndTime
        }
    }
    var selectOneTimeDateView: some View{
        VStack(spacing: 6){
            Text(Constants.AddScheduleEventViewTitle.on)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(){
                Text("Select Date")
                    .customFont(.regular, 16)
                    .padding(.leading, 10)
                    .foregroundStyle(Color.gray)
                
                Spacer()
                DatePicker("", selection: $eventViewModel.onetimeDate, in: Date()..., displayedComponents: .date)
                    .tint(colorScheme == .dark ? .white : .primaryTheme)
                    .labelsHidden()
                    .padding(.trailing, 10)
                
            }.frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
            
        }
    }
    var selectFromToRecurrenceDate: some View{
        HStack(){
            VStack(alignment: .leading, spacing: 6){
                Text(Constants.AddScheduleEventViewTitle.from)
                    .customFont(.regular, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(){
                    DatePicker("", selection: $eventViewModel.fromDate, in: Date()..., displayedComponents: .date)
                        .tint(colorScheme == .dark ? .white : .primaryTheme)
                        .labelsHidden()
                    
                    Spacer()
                    
                    Image(systemName: "calendar")
                        .resizable()
                        .foregroundStyle(.primaryTheme)
                        .frame(width: 20 ,height: 20)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 12))
                
            }
            
            VStack(alignment: .leading,spacing: 6){
                Text(Constants.AddScheduleEventViewTitle.to)
                    .customFont(.regular, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(){
                    
                    DatePicker("", selection: $eventViewModel.toDate, in: Date()..., displayedComponents: .date)
                        .tint(colorScheme == .dark ? .white : .primaryTheme)
                        .labelsHidden()
                    Spacer()
                    Image(systemName: "calendar")
                        .resizable()
                        .foregroundStyle(.primaryTheme)
                        .frame(width: 20 ,height: 20)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 12))
                
            }
        }.frame(maxWidth: .infinity)
        
    }
    var selectStartEndTime: some View{
        HStack(){
            VStack(alignment: .leading, spacing: 6){
                Text(Constants.AddScheduleEventViewTitle.startTime)
                    .customFont(.regular, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(){
                    DatePicker("", selection: $eventViewModel.fromDate, in: Date()..., displayedComponents: .hourAndMinute)
                        .tint(colorScheme == .dark ? .white : .primaryTheme)
                        .labelsHidden()
                    
                    Spacer()
                    
                    Image(.clock)
                        .resizable()
                        .frame(width: 20 ,height: 20)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 12))
                
            }
            
            VStack(alignment: .leading,spacing: 6){
                Text(Constants.AddScheduleEventViewTitle.endTime)
                    .customFont(.regular, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(){
                    DatePicker("", selection: $eventViewModel.toDate, in: Date()..., displayedComponents: .hourAndMinute)
                        .tint(colorScheme == .dark ? .white : .primaryTheme)
                        .labelsHidden()
                    Spacer()
                    Image(.clock)
                        .resizable()
                        .frame(width: 20 ,height: 20)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 12))
                
            }
        }.frame(maxWidth: .infinity)
        
    }
    var selectVenueType: some View{
        VStack(spacing: 6){
            Text(Constants.AddScheduleEventViewTitle.venue)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                DropDownMenu(
                    placeholder: Constants.TextField.Placeholder.venueType,
                    options: eventViewModel.venueTypes,
                    selectedOption: $eventViewModel.selectedVenueType)
                Spacer()
                Button{
                    isAddNewVenueViewPresented = true
                } label: {
                    Text("Add Venue")
                        .customFont(.medium, 14)
                   
                        .foregroundStyle(.primaryTheme)
                        .padding()
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 10))
                }
            }
        }
    }
    var locationDetail: some View{
        VStack(spacing: 6){
            Text(Constants.AddScheduleEventViewTitle.locationDetails)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(Constants.TextField.Placeholder.locationDetails, text: $eventViewModel.eventName)
                .customFont(.regular, 14)
                .frame(height: 48)
                .padding(.horizontal)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
                .tint(.primary)
        }
    }
    var memberLimit: some View{
        VStack{
            Text(Constants.AddScheduleEventViewTitle.memberLimit)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                DropDownMenu(
                    placeholder: "20",
                    options: eventViewModel.memberLimits,
                    selectedOption: $eventViewModel.selectedMemberLimit)
                Spacer()
            }
        }
    }
    var addCoach: some View{
        //Who is this goal for Section
        VStack(spacing: 6){
            Text(Constants.TextField.Title.addCoach)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                if !savedMembers.isEmpty{
                    SelectedMemberView(selectedMembers: contactsViewModel.savedMembers)
                        .padding(.leading)
                }
                Spacer()
                Text("Add Coach")
                    .customFont(.medium, 15)
                    .padding(8)
                    .foregroundStyle(.primaryTheme)
                    .background(.primaryTheme.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.trailing, 12)
                    .onTapGesture {
                        //     router.navigate(to: .addMember(goalId: goalId ?? UUID(), comingFrom: comingFrom))
                        isAddMemberViewIsPresented = true
                    }
                
            }.frame(height: 48)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
            
        }
    }
    var reccuringDaysView: some View{
        VStack(spacing: 6){
            Text(Constants.AddScheduleEventViewTitle.runsEvery)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                ForEach(eventViewModel.reccuringDays, id: \.self) { day in
                    DaySelectionView(isSelected: eventViewModel.selectedReccuringDays.contains(where: { $0 == day}) , name: day)
                        .onTapGesture {
                            if let index = eventViewModel.selectedReccuringDays.firstIndex(where: { $0 == day }) {
                                eventViewModel.selectedReccuringDays.remove(at: index)
                            } else {
                                eventViewModel.selectedReccuringDays.append(day)
                            }
                        }
                }
            }
        }.padding(.bottom)
    }
}
    

#Preview {
    AddEventView()
        .environmentObject(ContactsViewModel())
}

struct RecurrenceTypeSelectView: View {
    
    var isSelected = false
    var name = ""
    
    var body: some View {
        
        HStack{
            Image(isSelected ? .selectedRadio :.unSelectedRadio)
                .resizable()
                .frame(width: 22 ,height: 22)
            Text(name)
                .customFont(.regular, 16)
                .tint(.primary)
        }
        .padding()
        .background(isSelected ? Color.primaryTheme.opacity(0.10) : Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.primaryTheme : Color.gray, lineWidth: 1)
        )
    }
}
struct DaySelectionView: View {
    var isSelected = false
    var name = ""
    var body: some View {
        HStack{
            Text(name)
                .customFont(.regular, 12)
                .frame(width: 40, height: 40, alignment: .center)
                .background(isSelected ? .primaryTheme :.white)
                .foregroundStyle(isSelected ? .white : Color.gray)
                .clipShape(.rect(cornerRadius: 7))
                .overlay {
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(!isSelected ? Color.gray : Color.clear, lineWidth: 0.7)
                }
        }.frame(maxWidth: .infinity, alignment: .center)
    }
}
