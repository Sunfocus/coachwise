//
//  HomeView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 23/12/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.presentSideMenu) var presentSideMenu
    @State private var isSearchActive: Bool = false
    @State private var searchedText = ""
    @State private var isRecording: Bool = false
    @StateObject var speechManager: SpeechManager
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var router: Router
    @State private var showAddEventOptions: Bool = false // State to toggle visibility
    @StateObject private var homeViewModel = HomeViewModel(
           schedule: [ScheduleEvent(eventName: "Yoga Class",
                                    startTime: "10:00 AM",
                                    endTime: "11:00 AM",
                                    eventDate: "28 Nov 2024"),
                      ScheduleEvent(eventName: "History Class",
                                    startTime: "10:00 AM",
                                    endTime: "11:00 AM",
                                    eventDate: "28 Nov 2024"),
                      ScheduleEvent(eventName: "Science Class",
                                    startTime: "10:00 AM",
                                    endTime: "11:00 AM",
                                    eventDate: "28 Nov 2024")
           ],
           recentMessages: [Messages(senderName: "Teddy Heil",
                                     senderImage: "placeholder",
                                     lastMessage: "No classes today!!"),
                            Messages(senderName: "Theresa Webb",
                                     senderImage: "placeholder",
                                     lastMessage: "Please don’t forget to bring your team.."),
                            Messages(senderName: "Jack",
                                     senderImage: "placeholder",
                                     lastMessage: "See you tomorrow!")
           ],
           memories: ["f1", "sg1", "placeholder"],
           goals: [Goals(goalPercentageValue: "75%",
                         goalAchieverName: "John Doe",
                         goalAchieverImage: "placeholder",
                         lastUpdatedDate: "20/12/24",
                         goalTitle: "Fitness Goal"),
               Goals(goalPercentageValue: "65%",
                     goalAchieverName: "Ralph Edwards",
                     goalAchieverImage: "placeholder",
                     lastUpdatedDate: "20/12/24",
                     goalTitle: "1000 Push up"),
               Goals(goalPercentageValue: "85%",
                     goalAchieverName: "Jenny Wilson",
                     goalAchieverImage: "placeholder",
                     lastUpdatedDate: "20/12/24",
                     goalTitle: "Fitness Goal")])
    
    var body: some View {
        ZStack {
            VStack {
                topHeaderView
                welcomeUserView
                ScrollView(showsIndicators: false) {
                    VStack {
                        // MARK: - Schedule Title & SubTitle Text
                        if let scheduleCount = homeViewModel.schedule?.count {
                            if scheduleCount > 0{
                                scheduleDataView
                            }else {
                                noScheduleView
                            }
                        }
                    }.background(.backgroundTheme)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 12)
                    // MARK: - Recent Messages View
                    VStack {
                        if let messagesCount = homeViewModel.recentMessages?.count {
                            if messagesCount > 0 {
                                recentMessagesView
                            }else {
                                noRecentMessagesView
                            }
                        }
                    }
                    .padding(.top, 12)
                    .background(.backgroundTheme)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 20)

                    // MARK: - New Memories
                    VStack {
                         if let memoriesCount = homeViewModel.memories?.count {
                             if memoriesCount > 0 {
                                 memoriesView
                             }else {
                                 noNewMemoriesView
                             }
                         }
                    }
                    .padding(.top, 12)
                    .background(.backgroundTheme)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 20)
                   
                    // MARK: - Goals
                    if let goalsCount = homeViewModel.goals?.count {
                        if goalsCount > 0 {
                            // Add new Goals View Here
                        }else {
                            noNewGoalView
                        }
                    }
                }
                .safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
            }
        }.background(.backgroundTheme)
            .overlay(
                // MARK: - Overlay Plus Icon
                AddNewEventView(showAddEventOptions: $showAddEventOptions)
                    .padding(.trailing, 30)
                    .padding(.bottom, 40),
                   alignment: .bottomTrailing
            )
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
                        //Open sidemenu
                        presentSideMenu.wrappedValue.toggle()
                    }
                Text("Home")
                    .customFont(.semiBold, 24)
                Spacer()
                Image(.searchNormal)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        isSearchActive.toggle()
                    }
                    .padding(.trailing, 12)
                Image(.bell)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        router.navigate(to: .notificationView)
                    }
            }.padding([.horizontal, .vertical], 15)
            
            //Search Member View Section
            if isSearchActive{
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
    }
    var welcomeUserView: some View {
        Group {
            Text("Welcome ")
                .customFont(.regular, 24)
            +
            Text("Jenny")
                .customFont(.medium, 24)
                .foregroundStyle(.primaryTheme)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 15)
        .padding(.horizontal, 20)
    }
    var scheduleDataView: some View {
        VStack{
            HStack {
                Text("Schedule")
                    .customFont(.medium, 18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text("View All")
                    .customFont(.medium, 14)
                    .onTapGesture {
                        print("View All Schedule Tapped")
                        
                    }
            }
            .padding(.horizontal, 12)
            .background(.backgroundTheme)
            ForEach(homeViewModel.schedule!, id: \.self) { scheduleEvent in
                ScheduleDataView(schedule: scheduleEvent)
                    .padding(.bottom, 2)
            }
        }
    }
    var noScheduleView: some View {
        VStack {
            HStack {
                Text("Schedule")
                    .customFont(.medium, 18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }.padding(.top, 12)
            VStack {
                Text("Let’s schedule your first event!")
                    .customFont(.regular, 14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 0)
                // MARK: - Add Schedule
                ScheduleButton(title: "Add Schedule", imageName: "addSchedule", action: {
                    print("On Tap Add Schedule")
                }) .padding(.bottom, 12)
            }
        }.padding(.horizontal, 12)
    }
    var recentMessagesView: some View {
        VStack{
            HStack {
                Text("Recent messages")
                    .customFont(.medium, 18)
                Spacer()
                Text("View All")
                    .customFont(.medium, 14)
                    .onTapGesture {
                        print("On Tap View All")
                        presentSideMenu.wrappedValue.toggle()
                    }
            }.padding(.horizontal, 12)
                .background(.backgroundTheme)
            RecentMessagesDataView(recentMessages: homeViewModel.recentMessages ?? [Messages]())
        }
    }
    var noRecentMessagesView: some View{
        VStack(spacing: 5) {
            Image(.noMessages)
                .resizable()
                .frame(width: 32, height: 32)
            Text("No messages yet")
                .customFont(.medium, 14)
                .foregroundStyle(.primaryTheme)
            Text("Tap here to start your journey and connect now!")
                .customFont(.regular, 12)
                .frame(maxWidth: .infinity, alignment: .center)
        }.padding(.top, 24)
            .padding(.bottom, 24)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(.primaryTheme)
            )
            .padding(.top, 0)
            .padding(.bottom, 12)
            .padding(.horizontal, 12)
    }
    var memoriesView: some View {
        VStack {
            HStack {
                Text("New Memories")
                    .customFont(.medium, 18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text("View All")
                    .customFont(.medium, 14)
                    .onTapGesture {
                        print("View All Memories Tapped")
                    }
            }.padding(.horizontal, 12)
               
            NewMemoriesDataView(memories: homeViewModel.memories)
                
               
        }
    }
    var noNewMemoriesView: some View {
        VStack {
            HStack {
                Text("New Memories")
                    .customFont(.medium, 18)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(.horizontal, 12)
            VStack(spacing: 12){
                Image(.sharePhotos)
                    .resizable()
                    .frame(width: 32, height: 32)
                Text("Share your photos")
                    .customFont(.medium, 12)
                    .foregroundStyle(.primaryTheme)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.top, 24)
            .padding(.bottom, 24)
            .overlay(
               RoundedRectangle(cornerRadius: 8)
                   .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                   .clipShape(RoundedRectangle(cornerRadius: 8))
                   .foregroundColor(.primaryTheme)
            )
            .padding(.top, 0)
            .background(.primaryTheme.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
    }
    var noNewGoalView: some View{
        VStack {
            HStack {
                Text("Goals")
                    .customFont(.medium, 18)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(.horizontal, 12)
            ScheduleButton(title: "Set your first goal", imageName: "goalsFlag")
                .padding(.horizontal, 12)
        }
        .padding(.top, 12)
        .padding(.bottom, 12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 20)
    }
}

#Preview {
    HomeView( speechManager: SpeechManager())
}

// MARK: - Plus Add Icon Options View
struct AddNewEventView: View {
    @Binding var showAddEventOptions: Bool // Binding property
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                if showAddEventOptions {
                    HStack {
                        Spacer()
                        // MARK: - Add Messages, Add User & Add Event
                        VStack(spacing: 10) {
                            Button(action: {
                                print("Add Messages Button tapped!")
                            }) {
                                HStack {
                                    Image(.noMessage)
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.primaryTheme)
                                    Text("Add Message")
                                        .customFont(.medium, 14)
                                        .foregroundStyle(.primaryTheme)
                                }.frame(maxWidth: .infinity)
                            }.frame(width: 160, height: 40)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(.primaryTheme, lineWidth: 1)
                                }
                            
                            Button(action: {
                                print("Add User Button tapped!")
                            }) {
                                HStack {
                                    Image(.plus)
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.primaryTheme)
                                    Text("Add User")
                                        .customFont(.medium, 14)
                                        .foregroundStyle(.primaryTheme)
                                }.frame(maxWidth: .infinity)
                                
                            }.frame(width: 160, height: 40)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(.primaryTheme, lineWidth: 1)
                                }
                            
                            Button(action: {
                                print("Add Event Button tapped!")
                            }) {
                                HStack {
                                    Image(.addSchedule)
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.primaryTheme)
                                    Text("Add Event")
                                        .customFont(.medium, 14)
                                        .foregroundStyle(.primaryTheme)
                                }.frame(maxWidth: .infinity)
                            }.frame(width: 160, height: 40)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(.primaryTheme, lineWidth: 1)
                                }
                        }.transition(.move(edge: .bottom))
                    }.padding(.trailing, 20)
                        .padding(.bottom, 10)
                }
                HStack {
                    Spacer()
                    // MARK: - Plus Add Icon
                    Button(action: {
                        withAnimation { // Animate visibility toggle
                            showAddEventOptions.toggle()
                        }
                        print("Plus Button tapped!")
                    }) {
                        Circle()
                            .foregroundStyle(.primaryTheme)
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(systemName: showAddEventOptions ? "multiply" : "plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .tint(.white)
                            }
                    }
                }
            }
        }
    }
}
