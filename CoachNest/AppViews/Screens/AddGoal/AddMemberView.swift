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
    @ObservedObject var viewModel: ContactsViewModel
    
    // Filtered contacts based on search text
    var filteredContacts: [String: [MemberDetail]] {
        if searchedText.isEmpty {
            return viewModel.groupedMembers
        } else {
            return viewModel.groupedMembers.reduce(into: [:]) { result, group in
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
            Color.lightGrey
                .ignoresSafeArea()
            
            VStack{
                // Heading and dismiss button section
                VStack{
                    // Heading and dismiss button section
                    HStack {
                        Image(.greyCloseButton)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                router.navigate(to: .addGoalView(userType: .coach), style: .fullScreenCover)
                            }
                        Spacer()
                        Text(Constants.AddMemberViewTitle.next)
                            .foregroundStyle(.primaryTheme)
                            .onTapGesture {
                                print("next nutton tapped")
                            }
                    }.padding([.horizontal, .vertical], 15)
                        .overlay {
                            VStack{
                                Text(Constants.AddMemberViewTitle.addMember)
                                    .customFont(.medium, 16)
                                Text("\(viewModel.selectedMembers.count)/\(viewModel.members.count)")
                                    .customFont(.medium, 13)
                                    .foregroundStyle(.darkGrey)
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
                            .foregroundColor(isRecording ? .red : .gray) // Tint the image
                            .padding(.trailing)
                            .onTapGesture {
                                if isRecording{
                                    searchedText = ""
                                    viewModel.stopVoiceSearch()
                                }else{
                                    viewModel.startVoiceSearch { voiceText in
                                        searchedText = voiceText
                                        if !voiceText.isEmpty{
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                                                print(voiceText)
                                                viewModel.stopVoiceSearch()
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
                    .background(.lightGrey)
                    .clipShape(.rect(cornerRadius: 18))
                    .padding([.horizontal, .bottom])
                    
                    Divider()
                    
                }.background(.white)
                   
                
                    // ScrollView{
                    VStack{
                        if !viewModel.selectedMembers.isEmpty{
                            HStack{
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(viewModel.selectedMembers) { member in
                                            PersonImageView(isSelected:  Binding(
                                                get: {
                                                    viewModel.selectedMembers.contains { $0.id == member.id } // Check if this contact is selected
                                                },
                                                set: { newValue in
                                                    if newValue {
                                                        viewModel.selectedMembers.append(member) // Add to selected
                                                    } else {
                                                        if let index = viewModel.selectedMembers.firstIndex(of: member) {
                                                            viewModel.selectedMembers.remove(at: index) // Remove from selected
                                                        }
                                                    }
                                                }
                                            ), image: member.profileImage ?? .sg1 )
                                                .onTapGesture {
                                                    HapticFeedbackHelper.lightImpact()
                                                }
                                        }
                                    }
                                }.safeAreaPadding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                
                            }.frame(height: 70)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.white)
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
                                            ContactCell(contact: member, isSelected: Binding(
                                                get: {
                                                    viewModel.selectedMembers.contains { $0.id == member.id } // Check if this contact is selected
                                                },
                                                set: { newValue in
                                                    if newValue {
                                                        viewModel.selectedMembers.append(member) // Add to selected
                                                    } else {
                                                        if let index = viewModel.selectedMembers.firstIndex(of: member) {
                                                            viewModel.selectedMembers.remove(at: index) // Remove from selected
                                                        }
                                                    }
                                                }
                                            ))
                                            .onTapGesture {
                                                HapticFeedbackHelper.mediumImpact()
                                            }
                                        }
                                        
                                    }.id(letter)
                                }
                            }
                            .firstLetterSectionIndex(proxy: proxy, sections: filteredContacts.keys.sorted())
                            .listStyle(InsetGroupedListStyle())
                            .scrollIndicators(.hidden)
                            .ignoresSafeArea()
                        }
                        
                    }
            }
        }
    }
}

#Preview {
    AddMemberView( viewModel: ContactsViewModel())
}
