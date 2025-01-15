//
//  MessagesView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 23/12/24.
//

import SwiftUI

struct MessagesView: View {
    
    //MARK: - Variables -
    @EnvironmentObject var router: Router
    @StateObject var messageViewModel: MessagesViewModel
    @State private var searchedText = ""
    @State private var isRecording: Bool = false
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @StateObject var speechManager: SpeechManager
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedSegment = 0
    @State private var isContactListPresented = false
    @Environment(\.presentSideMenu) var presentSideMenu
    
    var body: some View {
        ZStack{
            VStack{
                // top header view
                topHeaderView
                pickerView
                if !messageViewModel.messages.isEmpty{
                    noMessageToView
                }else{
                    messageListingView
                }}
        }.background(.backgroundTheme)
            .sheet(isPresented: $isContactListPresented) {
                AddMemberView(speechManager: SpeechManager(), goalId: UUID(), isComingFrom: .chat)
                    .presentationDetents([.large])
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
                        //Open sidemenu
                        presentSideMenu.wrappedValue.toggle()
                    }
                Text("Messages")
                    .customFont(.semiBold, 24)
                Spacer()
                Image(.bell)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        router.navigate(to: .notificationView)
                    }
                    .padding(.trailing, 12)
                Image(.newMessage)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        isContactListPresented = true
                    }
            }.padding([.horizontal, .vertical], 15)
            
            //Search Member View Section
            if messageViewModel.messages.isEmpty{
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
    var noMessageToView: some View{
        //MARK: - No goal to view Section -
        VStack{
            Spacer()
            Image(.noMessage)
                .resizable()
                .frame(width: 64, height: 64)
            Text(Constants.AddYourMessageViewTitle.noMessage)
                .customFont(.medium, 16)
                .foregroundStyle(.primaryTheme)
            Text(Constants.AddYourMessageViewTitle.startConversation)
                .customFont(.regular, 14)
            Button {
                
            } label: {
                Text("Chat with other now")
                    .customFont(.semiBold, 16)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.primaryTheme)
                    .padding()
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primaryTheme, lineWidth: 1) // Adds a border
                    })
                   
                
            }.padding(.horizontal, 30)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    var messageListingView: some View{
        VStack{
            ScrollView{
                ForEach(0..<50) { index in
                    MessageCell()
                        .onTapGesture {
                            router.navigate(to: .chatView)
                        }
                        .padding(.horizontal)
                       
                }
            }.scrollIndicators(.hidden)
        }
    }
    private var pickerView: some View{
            VStack{
                Picker("Select Option", selection: $selectedSegment) {
                    Text("All").tag(0)
                    Text("Groups").tag(1)
                    Text("Individuals").tag(2)
                }
                .pickerStyle(.segmented)
                .frame(height: 44)
            }
            .padding([.horizontal, .vertical])
            
        }
    
    
}

#Preview {
    MessagesView(messageViewModel: MessagesViewModel(), speechManager: SpeechManager())
        .environmentObject(Router())
}
