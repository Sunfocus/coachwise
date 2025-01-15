//
//  AddMemberView.swift
//  CoachNest
//
//  Created by ios on 24/12/24.
//

import SwiftUI

struct AddMemberView: View {
    
    //MARK: - Variables -
    @EnvironmentObject var router: Router
    @State private var searchedText = ""
    @State private var isRecording: Bool = false
    @State private var isFilterPresented: Bool = false
    @StateObject var speechManager: SpeechManager
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var addGoalViewModel: AddGoalViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    var goalId: UUID
    var isComingFrom : ComingFrom = .addNewGoal
    
    var filteredContacts: [String: [MemberDetail]] {
        if searchedText.isEmpty {
            return contactsViewModel.groupedMembers
        } else {
            return contactsViewModel.groupedMembers.reduce(into: [:]) { result, group in
                // Filter the members in the group based on the search text
                let filteredMembers = group.value.filter { $0.name.lowercased().contains(searchedText.lowercased()) }
                
                // If there are any filtered members, add them to the result
                if !filteredMembers.isEmpty {
                    result[group.key] = filteredMembers
                }
            }
        }
    }
    
    
    var body: some View {
        ZStack{
           
            
            VStack{
                // Heading and dismiss button section
                VStack{
                    // Heading and dismiss button section
                    HStack {
                        Image(.greyCloseButton)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                //we have to dismiss the current view only
                                dismiss()
//                                if isComingFrom == .chat{
//                                    dismiss()
//                                }else{
//                                    router.dashboardNavigateBack()
//                                }
                                contactsViewModel.selectedMembers = []
                               
                                
                            }
                        Spacer()
                        if isComingFrom == .chat{
                            Image(.filterList)
                                .foregroundStyle(.primaryTheme)
                                .onTapGesture {
                                    isFilterPresented = true
                                }
                        }else{
                            Text(Constants.AddMemberViewTitle.done)
                                .foregroundStyle(.primaryTheme)
                                .onTapGesture {
                                    print("save button tapped")
                                    contactsViewModel.savedMembers = contactsViewModel.selectedMembers
                                    dismiss()
                                  //  router.dashboardNavigateBack()
                                }
                        }
                        
                        
                        
                        
                    }.padding([.horizontal, .vertical], 15)
                        .overlay {
                            VStack{
                                Text(isComingFrom == .chat ? "Directory" : Constants.AddMemberViewTitle.addMember)
                                    .customFont(.medium, 16)
                                if isComingFrom != .chat{
                                    Text("\(contactsViewModel.selectedMembers.count)/\(contactsViewModel.members.count)")
                                        .customFont(.medium, 13)
                                        .foregroundStyle(.cursorTint.opacity(0.4))
                                }
                            }
                        }
                    
                    //Search Member View Section
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
                    .background(colorScheme == .dark ? .darkGreyBackground : .lightGrey)
                    .clipShape(.rect(cornerRadius: 18))
                    .padding([.horizontal, .bottom])
                    
                    Divider()
                    
                }
                .background(colorScheme == .dark ? .black : .white)
                   
                    VStack{
                        if !contactsViewModel.selectedMembers.isEmpty && isComingFrom != .chat{
                            HStack{
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(contactsViewModel.selectedMembers) { member in
                                            PersonImageView(isSelected:  Binding(
                                                get: {
                                                    contactsViewModel.isSelected(member: member) // Check if this contact is selected
                                                },
                                                set: { newValue in
                                                    contactsViewModel.toggleSelection(for: member, isSelected: newValue) // Toggle selection
                                                }
                                            ), image: member.profileImage ?? .sg1 )
                                        }
                                    }
                                }.safeAreaPadding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                
                            }.frame(height: 70)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.darkGreyBackground)
                                .clipShape(.rect(cornerRadius: 10))
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                        }
                        
                        ScrollViewReader { proxy in
                            List {
                                ForEach(filteredContacts.keys.sorted(), id: \.self) { letter in
                                    Section(header: Text(letter)
                                        .customFont(.regular, 16)
                                            
                                    ){
                                        ForEach(filteredContacts[letter]!, id: \.id) { member in
                                            ContactCell(contact: member, isSelected: contactsViewModel.isSelected(member: member), isComingFrom: isComingFrom)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                contactsViewModel.toggleSelection(for: member)
                                            }
                                        }
                                    }.id(letter)
                                }
                            }
                           // .firstLetterSectionIndex(proxy: proxy, sections: filteredContacts.keys.sorted())
                            .listStyle(InsetGroupedListStyle())
                            .scrollIndicators(.hidden)
                        }
                    }
            }
        }.background(.backgroundTheme)
        .navigationBarBackButtonHidden()
            .sheet(isPresented: $isFilterPresented) {
                GoalFilterView(isComingFrom: .chat)
                    .presentationDetents([.height(500)])
                    .presentationDragIndicator(.visible)
                    .presentationContentInteraction(.scrolls)
            }
    }
}

#Preview {
    AddMemberView(speechManager: SpeechManager(), goalId: UUID(), isComingFrom: .addNewGoal)
        .environmentObject(ContactsViewModel())
        .environmentObject(AddGoalViewModel())
        .environmentObject(Router())
}
