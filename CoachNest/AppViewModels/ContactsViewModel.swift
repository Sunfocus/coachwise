//
//  ContactsViewModel.swift
//  CoachNest
//
//  Created by ios on 25/12/24.
//

import Foundation
import SwiftUI
import Combine



struct MemberDetail: Codable, Hashable, Identifiable {
    let id: UUID
    let name: String
    let profileImageData: Data
    let accountType: AccountType

    var profileImage: UIImage? {
        UIImage(data: profileImageData)
    }

    init(id: UUID = UUID(), name: String, profileImage: UIImage, accountType: AccountType) {
        self.id = id
        self.name = name
        self.profileImageData = profileImage.jpegData(compressionQuality: 1.0) ?? Data()
        self.accountType = accountType
    }
}


public class ContactsViewModel: ObservableObject{
    
    @Published var members: [MemberDetail] = []
    @Published var selectedMembers: [MemberDetail] = []
    @Published var savedMembers: [MemberDetail] = []
    var speechManager = SpeechRecognitionManager()
    private var cancellables: Set<AnyCancellable> = []
    
    
    var groupedMembers: [String: [MemberDetail]] {
        Dictionary(grouping: members, by: { String($0.name.prefix(1)) })
    }
    
    init() {
        fetchContacts()
    }
        
    func startVoiceSearch(completion: @escaping (String) -> Void) {
        speechManager.startRecording()
        speechManager.$recognizedText
            .receive(on: DispatchQueue.main)
            .sink { recognizedText in
                completion(recognizedText)
            }
            .store(in: &cancellables)
    }
    
    func stopVoiceSearch(){
        speechManager.stopRecording()
    }
    
    func saveMembers(){
        savedMembers = selectedMembers
        selectedMembers = savedMembers
    }
    
    func getSelectedSaves(){
        selectedMembers = savedMembers
    }
    
    
    func isSelected(member: MemberDetail) -> Bool {
        return selectedMembers.contains { $0.id == member.id }
    }
       
    func toggleSelection(for member: MemberDetail, isSelected: Bool? = nil) {
        if let isSelected = isSelected {
            // Explicitly set selection state
            if isSelected {
                if !selectedMembers.contains(where: { $0.id == member.id }) {
                    selectedMembers.append(member)
                }
            } else {
                if let index = selectedMembers.firstIndex(where: { $0.id == member.id }) {
                    selectedMembers.remove(at: index)
                }
            }
        } else {
            // Toggle selection state
            if let index = selectedMembers.firstIndex(where: { $0.id == member.id }) {
                selectedMembers.remove(at: index)
            } else {
                selectedMembers.append(member)
            }
        }
    }
    
    func fetchContacts(){
        self.members = [
            .init(name: "Alice Anderson", profileImage: .sg1, accountType: .member),
            .init(name: "Amanda ", profileImage: .f1, accountType: .member),
            .init(name: "Anderson", profileImage: .f2, accountType: .member),
            .init(name: "Ashley", profileImage: .f3, accountType: .member),
            .init(name: "Alex", profileImage: .sg6, accountType: .member),
            .init(name: "Ben Brown", profileImage: .f1, accountType: .parent),
            .init(name: "Ben Brown2", profileImage: .f2, accountType: .parent),
            .init(name: "Ben Brown3", profileImage: .f3, accountType: .parent),
            .init(name: "Charlie Carter", profileImage: .f2, accountType: .coach),
            .init(name: "Charlie Carter", profileImage: .f2, accountType: .coach),
            .init(name: "Charlie Carter", profileImage: .f2, accountType: .coach),
            .init(name: "David Dawson", profileImage: .sg1, accountType: .member),
            .init(name: "David Dawson", profileImage: .sg1, accountType: .member),
            .init(name: "David Dawson", profileImage: .sg1, accountType: .member),
            .init(name: "Eleanor Edwards", profileImage: .f1, accountType: .parent),
            .init(name: "Fiona Foster", profileImage: .f2, accountType: .coach),
            .init(name: "George Green", profileImage: .sg1, accountType: .member),
            .init(name: "Hannah Harper", profileImage: .f1, accountType: .parent),
            .init(name: "Isla Irving", profileImage: .f2, accountType: .coach),
            .init(name: "Jack Johnson", profileImage: .sg1, accountType: .member),
            .init(name: "Kevin King", profileImage: .f1, accountType: .parent),
            .init(name: "Lily Lewis", profileImage: .f2, accountType: .coach),
            .init(name: "Max Walter", profileImage: .sg1, accountType: .coach),
            .init(name: "Nina Norris", profileImage: .f1, accountType: .member),
            .init(name: "Olivia Owens", profileImage: .f2, accountType: .parent),
            .init(name: "Paul Parker", profileImage: .sg1, accountType: .member),
            .init(name: "Quinn Quinn", profileImage: .f1, accountType: .coach),
            .init(name: "Rachel Roberts", profileImage: .f2, accountType: .parent),
            .init(name: "Sydney Sweetnie", profileImage: .sg1, accountType: .member),
            .init(name: "Thomas Taylor", profileImage: .f1, accountType: .coach),
            .init(name: "Uma Underwood", profileImage: .f2, accountType: .parent),
            .init(name: "Victor Vance", profileImage: .sg1, accountType: .member),
            .init(name: "Wendy Walker", profileImage: .f1, accountType: .parent),
            .init(name: "Xander Xavier", profileImage: .f2, accountType: .coach),
            .init(name: "Yasmine York", profileImage: .sg1, accountType: .member),
            .init(name: "Zachary Zane", profileImage: .f1, accountType: .parent)
        ]

    }
    
    func toggleSelection(for member: MemberDetail) {
            if let index = selectedMembers.firstIndex(of: member) {
                selectedMembers.remove(at: index)
            } else {
                selectedMembers.append(member)
            }
        }
}
