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
    @StateObject var memoriesViewModel = MemoriesViewModel()
    @StateObject private var chatViewModel = MessagesViewModel()
    @EnvironmentObject var addActionViewModel: AddActionViewModel
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dismiss
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
                                .padding(.horizontal)
                        case .messages:
                            eventMessagesView
                        case .memories:
                            eventMemoriesView
                                .padding(.horizontal)
                        }
                }
                .animation(.easeIn(duration: 0.3), value: viewModel.selectedSegment)
            }
        }.background(.backgroundTheme)
            .navigationBarBackButtonHidden()
            .onChange(of: memoriesViewModel.photosPickerItems) { _, _ in
                Task{
                    await memoriesViewModel.processMediaItems()
                }
            }
            .overlay(
                Group{
                    if viewModel.selectedSegment == .memories{
                        addMemoryButtonView
                    }else{
                        announcementButtonView
                    }
                }.padding(.trailing, 20)
                    .padding(.bottom, 60),
                   alignment: .bottomTrailing
            )
            .sheet(isPresented: $memoriesViewModel.isImageSelected) {
                ZStack{
                    if let item = memoriesViewModel.selectedItem{
                        if item.isVideo{
                            VideoPlayerView(videoURL: URL(string: item.videoUrl)! )
                        }else{
                            ZStack{
                                Color.white.ignoresSafeArea()
                                VStack {
                                    Image(uiImage: memoriesViewModel.selectedItem?.image ?? .sg1)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(20)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                }.ignoresSafeArea()
                            }
                        }
                    }
                }
            }
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
    // -------------------------------------------
    
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
            if !viewModel.isTextFieldFocused {
                OnlyVisibleCoachHeaderView(visibleType: "Notes")
                    .padding(.horizontal)
                uploadDocumentView
            }
                documentsAndEventNotesListView
            Spacer()
            addNoteTextView
        }
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
                   
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            if let lastNote = viewModel.eventNotes.last {
//                                withAnimation {
//                                    print("isTextFieldFocused scroll to last note by user")
//                                    proxy.scrollTo(lastNote.id, anchor: .bottom)
//                                }
//                            }
//                        }
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
    
    //Event Action Subviews -
    var eventActionsView: some View{
        VStack{
            OnlyVisibleCoachHeaderView(visibleType: "Action here")
            if !addActionViewModel.getActionsByParentId(byId: viewModel.eventId).isEmpty{
                toDoListView
                Spacer()
                CustomButton(title: "Add Action") {
                    print("add action button tapped")
                    let user = MemberDetail(id: 1, name: "Max Walter", profileImage: .sg1, accountType: .coach, progress: 0.0)
                    router.navigate(to: .addNewAction(member: user, goalId: viewModel.eventId))
                }
            }else{
                emptyActionView
                Spacer()
                CustomButton(title: "Add Action") {
                    print("add action button tapped")
                    let user = MemberDetail(id: 1, name: "Max Walter", profileImage: .sg1, accountType: .coach, progress: 0.0)
                    router.navigate(to: .addNewAction(member: user, goalId: viewModel.eventId))
                }
            }
        }
        
    }
    private var emptyActionView: some View{
        VStack{
            Spacer()
            Image(.doubleTick)
                .resizable()
                .frame(width: 64, height: 64)
            Text("No Actions")
                .customFont(.medium, 16)
                .foregroundStyle(.primaryTheme)
            Text("You have no actions in this event !")
                .customFont(.regular, 14)
                .foregroundStyle(.primaryTheme)
            Spacer()
        }
    }
    private var toDoListView: some View{
        ScrollView{
            VStack{
                //add new To do Section
                let eventId = viewModel.eventId
                let todoActions = addActionViewModel.sortActionByStatus(status: .todo, parentId: eventId)
                let pendingActions = addActionViewModel.sortActionByStatus(status: .inProgress, parentId: eventId)
                let completedActions = addActionViewModel.sortActionByStatus(status: .completed, parentId: eventId)
                if !todoActions.isEmpty{
                    VStack(spacing: 7){
                        Text("To do")
                            .customFont(.semiBold, 18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(todoActions, id: \.self) { action in
                            ToDoCell(action: action)
                                .padding(.bottom, 3)
                                .onTapGesture {
                                    router.navigate(to: .actionDetailView(actionId: action.id))
                                }
                        }
                    } .padding(.bottom)
                }
                
               
                //In progress Section
                if !pendingActions.isEmpty{
                    VStack(spacing: 7){
                        Text("Pending")
                            .customFont(.semiBold, 18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(pendingActions, id: \.self) { action in
                            ToDoCell(action: action)
                                .padding(.bottom, 3)
                                .onTapGesture {
                                    router.navigate(to: .actionDetailView(actionId: action.id))
                                }
                        }
                    }
                    .padding(.bottom)
                }
                //Completed Section
                if !completedActions.isEmpty{
                    VStack(spacing: 7){
                        Text("Completed")
                            .customFont(.semiBold, 18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(completedActions, id: \.self) { action in
                            ToDoCell(action: action)
                                .padding(.bottom, 3)
                                .onTapGesture {
                                    router.navigate(to: .actionDetailView(actionId: action.id))
                                }
                        }
                    }
                }
            }.shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .padding(.horizontal, 1)
        }
    }
    // -------------------------------------------
    
    //Event Memories Subviews -
    var eventMemoriesView: some View{
        VStack{
            if memoriesViewModel.mediaItems.isEmpty{
                Spacer()
                noMemoriesView
                Spacer()
            }else{
                ImageGridView(viewModel: memoriesViewModel)
            }
        }
    }
    var noMemoriesView: some View{
        VStack{
            Spacer()
            Image(.memory)
                .resizable()
                .frame(width: 50, height: 50)
            Text("No Memories")
                .customFont(.medium, 16)
                .foregroundStyle(.primaryTheme)
            Text("There are currently no memories here")
                .customFont(.regular, 14)
                .multilineTextAlignment(.center)
            
            PhotosPicker(
                selection: $memoriesViewModel.photosPickerItems,
                maxSelectionCount: 50,
                matching: .any(of: [.images, .videos])
            ) {
                Text("+  Add Memories")
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
    var addMemoryButtonView: some View {
        Group{
            if !memoriesViewModel.mediaItems.isEmpty{
                PhotosPicker(
                    selection: $memoriesViewModel.photosPickerItems,
                    maxSelectionCount: 50,
                    matching: .any(of: [.images, .videos])
                ) {
                    Circle()
                        .foregroundStyle(.primaryTheme)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Image(.memory)
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .tint(.white)
                        }
                }
            }
        }
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
    var eventMessagesView: some View{
        VStack{
            if chatViewModel.messages.isEmpty{
                VStack(spacing: 15){
                    Spacer()
                    Image(.noMessage)
                        .resizable()
                        .frame(width: 50, height: 50)
                     Text("No Chats available, Send a message to start a chat")
                        .customFont(.regular, 15)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .foregroundStyle(.cursorTint)
                    Spacer()
                }
            }else{
                ScrollViewReader { scrollViewProxy in
                    ScrollView{
                        ForEach(chatViewModel.messages) { message in
                            switch message.messageType{
                            case .audio:
                                SenderAudioView(chat: message)
                            case .image:
                                SenderImageView(chat: message)
                            case .document:
                                SenderView(chat: message)
                            case .text:
                                SenderView(chat: message)
                            case .video:
                                SenderView(chat: message)
                            }
                        }
                    }.safeAreaPadding(EdgeInsets(top: 2, leading: 0, bottom: 20, trailing: 0))
                        .scrollIndicators(.hidden)
                        .onChange(of: chatViewModel.messages.count) {
                            if let lastMessage = chatViewModel.messages.last {
                                withAnimation {
                                    scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                }
            }
            
            // User input field
            UserInputFieldView(
                text: $chatViewModel.newMessage,
                images: $chatViewModel.images,
                photosPickerItems: $chatViewModel.photosPickerItems,
                audioRecorder: chatViewModel.audioRecorderHelper,
                placeholder: "Write a message...",
                onSend: { messageType in
                    HapticFeedbackHelper.mediumImpact()
                    chatViewModel.sendMessage(messageType: messageType)
                }
                )
            .padding()
            .background(.darkGreyBackground)
        }
    }
    // -------------------------------------------
   
}

#Preview {
    EventDetailView()
        .environmentObject(AddActionViewModel())
        .environmentObject(Router())
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
                            .customFont(.regular, 14)
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
                        .customFont(.semiBold, 16)
                    Text(noteDetail.accountType.rawValue)
                        .customFont(.medium, 13)
                        .foregroundStyle(.primary.opacity(0.7))
                }
                
                Spacer()
                
                Text(time.formattedAsMonthDayYear())
                    .customFont(.regular, 13)
            }
            
            VStack(alignment: .leading) {
                Text(noteDetail.note)
                    .customFont(.regular, 15)
                    .padding(.leading, 45)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }.padding(5)

    }
}
struct OnlyVisibleCoachHeaderView: View {
    
    var visibleType: String = ""
    var body: some View {
      
            HStack(spacing: 5){
                Image(.lock)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("\(visibleType) are only visible to coaches")
                    .customFont(.regular, 14)
                    .foregroundStyle(.primaryTheme)
            }.frame(maxWidth: .infinity)
                .padding(8)
                .background(.primaryTheme.opacity(0.1))
                .clipShape(.rect(cornerRadius: 5))
                .padding(.bottom)
    }
}




