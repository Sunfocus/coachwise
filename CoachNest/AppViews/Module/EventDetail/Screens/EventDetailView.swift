//
//  ScheduleDetailView.swift
//  CoachNest
//
//  Created by ios on 14/01/25.
//

import SwiftUI
import PhotosUI

struct EventDetailView: View {
    
    //MARK: - Variables -
    @StateObject var viewModel = EventDetailViewModel()
    @EnvironmentObject var router: Router
    @State var coachesViewIsPresented = false
    
    
    var body: some View {
        ZStack{
            VStack{
                topHeaderView
                
                VStack(spacing: 15){
                        switch viewModel.selectedSegment{
                        case .details:
                            eventDetailView
                                .padding(.horizontal)
                        case .attendance:
                            eventAttendanceView
                                .padding(.horizontal)
                        case .notes:
                            eventNotesView
                        case .actions:
                            eventActionsView
                        case .messages:
                            eventMessagesView
                        case .memories:
                            eventMemoriesView
                        }
                }
                    .animation(.easeIn(duration: 0.3), value: viewModel.selectedSegment)
            }
        }.background(.backgroundTheme)
            .navigationBarBackButtonHidden()
            .overlay(
                announcementButtonView
                .padding(.trailing, 30)
                .padding(.bottom, 50),
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
            Picker("Select Option", selection: $viewModel.selectedSegment) {
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
                                    .background(viewModel.selectedSegment == segment ? Color.primaryTheme : .white)
                                    .foregroundColor(viewModel.selectedSegment == segment ? .white : .black)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        viewModel.selectedSegment = segment
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
            }.safeAreaPadding(EdgeInsets(top: 15, leading: 1, bottom: 130, trailing: 1))
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
            SelectedMemberView(selectedMembers: viewModel.selectedMember)
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
                        viewModel.status = option
                    }) {
                        Text(option.rawValue)
                    }
                }
            } label: {
                HStack {
                    Text(viewModel.status.rawValue)
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
    
    //Event Attendance Subviews -
    var eventAttendanceView: some View{
        Group{
            if viewModel.eventAttendees.isEmpty{
                noAttendeesView
            }else{
                eventAttendeesListingView
            }
        }
    }
    var noAttendeesView: some View{
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
                    .padding()
                    .tint(.primaryTheme)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primaryTheme, lineWidth: 1)
                    }
            }
            Spacer()
        }
    }
    var eventAttendeesListingView: some View{
        VStack{
            //Enrolled count and mark all attendancees subview
            HStack{
                Text("Enrolled (\(viewModel.eventAttendees.count))")
                    .customFont(.medium, 16)
                
                Spacer()
                
                Group{
                    Text("Mark all as attended")
                        .customFont(.regular, 14)
                    Button {
                        viewModel.markAllAsAttended()
                    } label: {
                        Image(viewModel.isMarkAllAsAttended ? .checkboxFill : .checkboxEmpty)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
            }
            ScrollView{
                ForEach(viewModel.eventAttendees, id: \.self){ attendee in
                    AttendeeView(attendee: attendee, viewModel: viewModel)
                        .padding(.bottom, 5)
                }
            }.safeAreaPadding(EdgeInsets(top: 5, leading: 1, bottom: 100, trailing: 1))
                .scrollIndicators(.hidden)
            
            CustomButton(title: "Add Attendees") {
                print("add attendees button tapped")
            }
        }
    }
    // -------------------------------------------
    
    //Event Notes Subviews -
    var eventNotesView: some View{
        VStack{
            if !viewModel.isTextFieldFocused{
                onlyVisibleToCoachView
                uploadDocumentView
            }
                documentsAndEventNotesListView
            Spacer()
            addNoteTextView
        }
    }
    var onlyVisibleToCoachView: some View{
        HStack(spacing: 5){
            Image(.lock)
                .resizable()
                .frame(width: 20, height: 20)
            Text("Notes are only visible to coaches")
                .customFont(.regular, 14)
                .foregroundStyle(.primaryTheme)
        }.frame(maxWidth: .infinity)
            .padding(8)
            .background(.primaryTheme.opacity(0.1))
            .clipShape(.rect(cornerRadius: 5))
            .padding(.bottom)
            .padding(.horizontal)
    }
    var uploadDocumentView: some View{
        //Upload Docs View
        VStack {
            Image(.documentUpload)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.bottom, 12)
            
            Text(Constants.AddEventTypeViewTitle.clickToUploadDoc)
                .customFont(.medium, 14)
                .foregroundStyle(.primaryTheme)
            Text(Constants.AddActionViewTitle.maxSizeLimit)
                .customFont(.regular, 12)
        }
        .frame(height: 130)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 12.0, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 1.2,
                        dash: [7]
                    )
                )
                .foregroundColor(.gray)
        )
        .padding(.horizontal, 1)
        .padding(.horizontal)
    }
    var documentsAndEventNotesListView: some View{
        ScrollViewReader { proxy in
            VStack(alignment: .leading) {
                
                List {
                    // Documents Section
                   
                        Section(header: Text("Documents")
                            .customFont(.regular, 15)
                            .foregroundColor(.primary)
                        ) {
                            ForEach(0..<2, id: \.self) { index in
                                DocumentView()
                                    .id("document-\(index)") // Unique identifier for each document item
                            }
                        }
                    
                    
                    // Event Notes Section
                    Section(header: Text("Event Notes")
                        .customFont(.regular, 15)
                        .foregroundColor(.primary)
                    ) {
                        ForEach(viewModel.eventNotes, id: \.self) { note in
                            EventNoteView(noteDetail: note)
                                .id(note.id) // Ensure each note has a unique identifier (e.g., note.id)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                .onChange(of: viewModel.eventNotes) { _, newValue in
                    if let lastNote = viewModel.eventNotes.last {
                        withAnimation {
                            print("scroll to last note by user")
                            proxy.scrollTo(lastNote.id, anchor: .bottom)
                        }
                    }
                }
                .onChange(of: viewModel.isTextFieldFocused) { _, newValue in
                        if let lastNote = viewModel.eventNotes.last {
                            withAnimation {
                                print("isTextFieldFocused scroll to last note by user")
                                proxy.scrollTo(lastNote.id, anchor: .bottom)
                            }
                        }
                    }
            }
        }

    }
    var addNoteTextView: some View{
        Group{
            AddNoteInputFieldView(text: $viewModel.note,
                                  viewModel: viewModel,
                                  placeholder: "Write a note",
                                  userImage: .sg1,
                                  actionButtonImage: .plane) {
                if !viewModel.note.isEmpty {
                    viewModel.addNote(note: EventNote(id: UUID(),
                                                      name: "Max Collins",
                                                      accountType: .coach,
                                                      note: viewModel.note)
                    )
                }
                HapticFeedbackHelper.softImpact()
            }
        }.padding(.horizontal)
            .padding(.bottom, 10)
    }
    // -------------------------------------------
    

    //Event Announcement Button View
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

//MARK: - Reusable Views -
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
struct AttendeeView: View {
    
    var attendee: Attendee
    @State private var hasAttendedClass: Bool = false
    @ObservedObject var viewModel: EventDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top){
                Image(uiImage: attendee.profileImage ?? .f3)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(.circle)
                
                VStack(alignment: .leading, spacing: 3){
                    Text(attendee.name)
                        .customFont(.medium, 16)
                    HStack(spacing: 7){
                        Image(.phone)
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text(attendee.contactNumber)
                            .customFont(.regular, 12)
                            .foregroundStyle(.primary.opacity(0.7))
                    }
                }
                Spacer()
                Image(.more)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.top, 3)
            }
            Divider()
            HStack{
                RatingView(rating: 3, maxRating: 5, starSize: CGSize(width: 16, height: 16))
                Spacer()
                Text("Attended?")
                    .customFont(.regular, 16)
                HStack(spacing: 10){
                    Button {
                        viewModel.markAttendance(id: attendee.id, hasAttended: true)
                    } label: {
                        Image(attendee.hasAttendedClass ? .attendedFill : .attended)
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    Button {
                        viewModel.markAttendance(id: attendee.id, hasAttended: false)
                    } label: {
                        Image(attendee.hasAttendedClass ? .notAttended : .notAttendedFill)
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                }
            }
        }.padding()
            .background(.darkGreyBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 1)
           
    }
}
struct DocumentView: View {
    
    
    var body: some View {
        HStack{
            Image(.pdfDoc)
                .resizable()
                .frame(width: 22, height: 22)
            
            VStack(alignment: .leading, spacing: 3){
                Text("Lesson Plan")
                    .customFont(.medium, 15)
                HStack(spacing: 5){
                    Text("PDF")
                        .customFont(.regular, 13)
                        .foregroundStyle(Color.primary.opacity(0.7))
                    Circle()
                        .frame(width: 5, height: 5)
                        .foregroundStyle(Color.primary.opacity(0.7))
                    
                    Text("200KB")
                        .customFont(.regular, 12)
                        .foregroundStyle(Color.primary.opacity(0.7))
                }
                
            }
            
            Spacer()
            Image(.rightArrow)
                .foregroundColor(.gray)
        }//
    }
}
struct EventNoteView: View {
    var noteDetail: EventNote
    var time = Date()
    var body: some View {
        VStack(spacing: 7) {
            HStack(alignment: .center) {
                Image(.sg1)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(noteDetail.name)
                        .customFont(.semiBold, 14)
                    Text(noteDetail.accountType.rawValue)
                        .customFont(.medium, 12)
                        .foregroundStyle(.primary.opacity(0.7))
                }
                
                Spacer()
                
                Text(time.formattedAsMonthDayYear())
                    .customFont(.regular, 11)
            }
            
            VStack(alignment: .leading) {
                Text(noteDetail.note)
                    .customFont(.regular, 13)
                    .padding(.leading, 45)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }

    }
}




