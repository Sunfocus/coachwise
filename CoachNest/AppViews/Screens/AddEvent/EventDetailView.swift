//
//  ScheduleDetailView.swift
//  CoachNest
//
//  Created by ios on 14/01/25.
//

import SwiftUI

struct EventDetailView: View {
    
    //MARK: - Variables -
    @StateObject var eventDetailViewModel = EventDetailViewModel()
    @EnvironmentObject var router: Router
    @State var coachesViewIsPresented = false
    
    var body: some View {
        ZStack{
            VStack{
                topHeaderView
                VStack(spacing: 15){
                    switch eventDetailViewModel.selectedSegment{
                    case .details:
                        eventDetailView
                    case .attendance:
                        eventAttendanceView
                    case .notes:
                        eventNotesView
                    case .actions:
                        eventActionsView
                    case .messages:
                        eventMessagesView
                    case .memories:
                        eventMemoriesView
                    default:
                        Text("Default View")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }.padding(.horizontal)
               
            }
        }.background(.backgroundTheme)
            .navigationBarBackButtonHidden()
            .overlay(
                announcementButtonView
                .padding(.trailing, 30),
               alignment: .bottomTrailing
            )
    }
    
    //MARK: - Subviews -
    var topHeaderView: some View{
        VStack{
            HStack {
                Image(.arrowBack)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        router.dashboardNavigateBack()
                    }
                Spacer()
                
                
                
                Menu {
                    // Edit Action
                    Button(action: {
                        print("Edit tapped")
                    }) {
                        Text("Edit")
                    }

                    // Delete Action
                    Button(role: .destructive, action: {
                        print("Delete tapped")
                    }) {
                        Text("Delete")
                    }
                } label: {
                    Image(.more)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.primary)
                }

            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    HStack{
                        Text("Learn Swift")
                            .customFont(.medium, 16)
                    }
                }
            segmentMenuView
            Divider()
        }
        .background(.darkGreyBackground)
        .padding( .bottom)
    }
    var segmentMenuView: some View{
        HStack {
            Spacer()
            Picker("Select Option", selection: $eventDetailViewModel.selectedSegment) {
                ForEach(SegmentType.allCases) { segment in
                    Text(segment.rawValue).tag(segment)
                }
            }
            .pickerStyle(.menu)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.primaryTheme)
            )
            .tint(.white)
            
        }.padding(.horizontal)
    }
    var scrollableSegmentControl: some View{
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 16) {
                            ForEach(SegmentType.allCases) { segment in
                                Text(segment.rawValue)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(eventDetailViewModel.selectedSegment == segment ? Color.primaryTheme : .white)
                                    .foregroundColor(eventDetailViewModel.selectedSegment == segment ? .white : .black)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        eventDetailViewModel.selectedSegment = segment
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 50)
    }
    
    
    //Event Details Subviews -
    var eventDetailView: some View{
        VStack{
            ScrollView{
                VStack(spacing: 20){
                    EventDetailRow(title: "Event name", value: "Junior Squad")
                    EventDetailRow(title: "Event type", value: "Training Session")
                    coachesView
                    statusOfEventView
                    eventFrequencyAndAddAttendeesView
                    venueAndLocationDetailView
                }
                .padding()
                .background(.darkGreyBackground)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 2)
                
//                .overlay(
//                    RoundedRectangle(cornerRadius: 12)
//                        .stroke(Color.secondary, lineWidth: 0.4)
//                )
            }.safeAreaPadding(EdgeInsets(top: 15, leading: 1, bottom: 90, trailing: 1))
            .scrollIndicators(.hidden)
        }
        
    }
    var coachesView: some View{
        VStack(spacing: 5){
            Text("Coaches")
                .customFont(.semiBold, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            coachesInEventListing
        }
    }
    var coachesInEventListing: some View{
        HStack{
            let selectedMember = [
                MemberDetail(id: 01, name: "Rahul", profileImage: .sg1, accountType: .coach, progress: 0.0),
                MemberDetail(id: 02, name: "Rahul", profileImage: .f1, accountType: .coach, progress: 0.0),
                MemberDetail(id: 01, name: "Rahul", profileImage: .sg1, accountType: .coach, progress: 0.0),
                MemberDetail(id: 02, name: "Rahul", profileImage: .f1, accountType: .coach, progress: 0.0),
                MemberDetail(id: 01, name: "Rahul", profileImage: .sg1, accountType: .coach, progress: 0.0),
                MemberDetail(id: 02, name: "Rahul", profileImage: .f1, accountType: .coach, progress: 0.0)
            ]
            SelectedMemberView(selectedMembers: selectedMember)
                .padding(.leading)
            Spacer()
            Text("View All")
                .customFont(.medium, 12)
                .padding(8)
                .foregroundStyle(.white)
                .background(.primaryTheme)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.trailing, 12)
                .onTapGesture {
                    coachesViewIsPresented = true
                }
            
        }.frame(height: 48)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 8))
    }
    var statusOfEventView: some View{
        VStack(spacing: 5){
            Text("Status")
                .customFont(.semiBold, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Menu {
                ForEach(StatusOption.allCases, id: \.self) { option in
                    Button(action: {
                        eventDetailViewModel.status = option
                    }) {
                        Text(option.rawValue)
                    }
                }
            } label: {
                HStack {
                    Text(eventDetailViewModel.status.rawValue)
                        .customFont(.regular, 16)
                        .foregroundStyle(.black)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 16))
                        .tint(.gray)
                }
                .padding()
                .frame(height: 45)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }//labelEnd
        }
    }
    var eventFrequencyAndAddAttendeesView: some View{
        VStack(spacing: 20){
            HStack{
                EventDetailRow(title: "Frequency", value: "Weekly")
                EventDetailRow(title: "Days", value: "Thursday")
            }
            EventDetailRow(title: "Date of this event", value: "Oct 13, 2025")
            HStack {
                EventDetailRow(title: "Member limit", value: "20")
                EventDetailRow(title: "Enrolled", value: "19")
            }
            Button {
                print("open select attendees contact view")
            } label: {
                Text("+  Add Attendees")
                    .customFont(.semiBold, 14)
                    .frame(maxWidth: .infinity)
                    .padding(14)
                    .background(Color.greenAccent)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 12))
            }
            Divider()
        }
    }
    var venueAndLocationDetailView: some View{
        VStack(spacing: 20){
            HStack{
                EventDetailRow(title: "Venue", value: "Melbourne City Sports Club")
                Spacer()
                
                Image(.landmark)
                    .resizable()
                    .frame(width: 24, height: 25)
            }
            
            HStack{
                EventDetailRow(title: "Location Details", value: "Not Specified")
                EventDetailRow(title: "Time", value: "04:00 PM - 06:00 PM")
            }
        }
    }
    // -------------------------------------------
    
    //Attendance Subviews -
    var eventAttendanceView: some View{
        VStack{
            Spacer()
            Image(.attendeesGroup)
                .resizable()
                .frame(width: 50, height: 50)
            Text("No Attendees")
                .customFont(.medium, 16)
                .foregroundStyle(.primaryTheme)
            Text("There are currently no members added to this event")
                .customFont(.regular, 14)
                .multilineTextAlignment(.center)
            Button {
                
            } label: {
                Text("+  Add Attendees")
                    .customFont(.medium, 14)
                    .frame(maxWidth: .infinity)
            }
            Spacer()
        }
    }
    
    
    var announcementButtonView: some View {
            Button(action: {
                print("Add new tapped")
            }) {
                
                Image(.announcement)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .tint(.white)
            }
        }
    
    
    
    
    var eventNotesView: some View{
        Text("Notes View")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
    var eventActionsView: some View{
        Text("Actions View")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.purple)
            .cornerRadius(10)
            .foregroundColor(.white)
        
    }
    var eventMessagesView: some View{
        Text("Messages View")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
    var eventMemoriesView: some View{
        Text("Memories View")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.yellow)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}

#Preview {
    EventDetailView()
}

struct EventDetailRow: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .customFont(.semiBold, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(value)
                .customFont(.regular, 14)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
