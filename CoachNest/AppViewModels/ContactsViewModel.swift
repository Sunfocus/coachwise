//
//  ContactsViewModel.swift
//  CoachNest
//
//  Created by ios on 25/12/24.
//

import Foundation
import SwiftUI
import Combine



public struct MemberDetail: Codable, Hashable, Identifiable {
    public let id: Int
    let name: String
    let profileImageData: Data
    let accountType: AccountType
    let progress: Double
    var profileImage: UIImage? {
        UIImage(data: profileImageData)
    }

    init(id: Int, name: String, profileImage: UIImage, accountType: AccountType, progress: Double) {
        self.id = id
        self.name = name
        self.profileImageData = profileImage.jpegData(compressionQuality: 1.0) ?? Data()
        self.accountType = accountType
        self.progress = progress
    }
}


public class ContactsViewModel: ObservableObject{
    
    @Published var members: [MemberDetail] = []
    @Published var savedMembers: [MemberDetail] = []
    @Published var selectedMembers: [MemberDetail] = []
    
    var speechManager = SpeechRecognitionManager()
    private var cancellables: Set<AnyCancellable> = []
    
    
    var groupedMembers: [String: [MemberDetail]] {
        Dictionary(grouping: members, by: { String($0.name.prefix(1)) })
    }
    
    init() {
        fetchContacts()
    }
    
    func updateSelection(members: [MemberDetail]){
        savedMembers = members
        selectedMembers = members
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
    
    
    func resetSelection(){
        selectedMembers = []
        savedMembers = []
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
    
    func fetchContacts() {
        self.members = [
            .init(id: 1, name: "Alice Anderson", profileImage: .sg1, accountType: .member, progress: 45.0),
            .init(id: 2, name: "Amanda", profileImage: .f1, accountType: .member, progress: 12.0),
            .init(id: 3, name: "Anderson", profileImage: .f2, accountType: .member, progress: 23.0),
            .init(id: 4, name: "Ashley", profileImage: .f3, accountType: .member, progress: 32.0),
            .init(id: 5, name: "Alex", profileImage: .sg6, accountType: .member, progress: 33.0),
            .init(id: 6, name: "Ben Brown", profileImage: .f1, accountType: .parent, progress: 10.0),
            .init(id: 7, name: "Ben Brown2", profileImage: .f2, accountType: .parent, progress: 76.0),
            .init(id: 8, name: "Ben Brown3", profileImage: .f3, accountType: .parent, progress: 56.0),
            .init(id: 9, name: "Charlie Carter", profileImage: .f2, accountType: .coach, progress: 7.0),
            .init(id: 10, name: "Charlie Carter", profileImage: .f2, accountType: .coach, progress: 54.0),
            .init(id: 11, name: "Charlie Carter", profileImage: .f2, accountType: .coach, progress: 32.0),
            .init(id: 12, name: "David Dawson", profileImage: .sg1, accountType: .member, progress: 56.0),
            .init(id: 13, name: "David Dawson", profileImage: .sg1, accountType: .member, progress: 76.0),
            .init(id: 14, name: "David Dawson", profileImage: .sg1, accountType: .member, progress: 32.0),
            .init(id: 15, name: "Eleanor Edwards", profileImage: .f1, accountType: .parent, progress: 76.0),
            .init(id: 16, name: "Fiona Foster", profileImage: .f2, accountType: .coach, progress: 32.0),
            .init(id: 17, name: "George Green", profileImage: .sg1, accountType: .member, progress: 76.0),
            .init(id: 18, name: "Hannah Harper", profileImage: .f1, accountType: .parent, progress: 56.0),
            .init(id: 19, name: "Isla Irving", profileImage: .f2, accountType: .coach, progress: 76.0),
            .init(id: 20, name: "Jack Johnson", profileImage: .sg1, accountType: .member, progress: 32.0),
            .init(id: 21, name: "Kevin King", profileImage: .f1, accountType: .parent, progress: 56.0),
            .init(id: 22, name: "Lily Lewis", profileImage: .f2, accountType: .coach, progress: 32.0),
            .init(id: 23, name: "Max Walter", profileImage: .sg1, accountType: .coach, progress: 76.0),
            .init(id: 24, name: "Nina Norris", profileImage: .f1, accountType: .member, progress: 56.0),
            .init(id: 25, name: "Olivia Owens", profileImage: .f2, accountType: .parent, progress: 76.0),
            .init(id: 26, name: "Paul Parker", profileImage: .sg1, accountType: .member, progress: 32.0),
            .init(id: 27, name: "Quinn Quinn", profileImage: .f1, accountType: .coach, progress: 76.0),
            .init(id: 28, name: "Rachel Roberts", profileImage: .f2, accountType: .parent, progress: 56.0),
            .init(id: 29, name: "Sydney Sweetnie", profileImage: .sg1, accountType: .member, progress: 76.0),
            .init(id: 30, name: "Thomas Taylor", profileImage: .f1, accountType: .coach, progress: 56.0),
            .init(id: 31, name: "Uma Underwood", profileImage: .f2, accountType: .parent, progress: 76.0),
            .init(id: 32, name: "Victor Vance", profileImage: .sg1, accountType: .member, progress: 56.0),
            .init(id: 33, name: "Wendy Walker", profileImage: .f1, accountType: .parent, progress: 32.0),
            .init(id: 34, name: "Xander Xavier", profileImage: .f2, accountType: .coach, progress: 76.0),
            .init(id: 35, name: "Yasmine York", profileImage: .sg1, accountType: .member, progress: 56.0),
            .init(id: 36, name: "Zachary Zane", profileImage: .f1, accountType: .parent, progress: 76.0)
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
