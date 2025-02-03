//
//  EditProfilePopupMenuView.swift
//  CoachNest
//
//  Created by Rahul Pathania on 31/01/25.
//

import SwiftUI


struct MenuList: Identifiable, Hashable{
    let menuName: String
    let menuImage: UIImage
    let id = UUID()
}

struct EditProfilePopupMenuView: View {
    
    let menuList: [MenuList] = [
        MenuList(menuName: "Message", menuImage: .messageGrey),
        MenuList(menuName: "Mark as inactive", menuImage: .inactive),
        MenuList(menuName: "Change user permission", menuImage: .user),
        MenuList(menuName: "Edit Profile Details", menuImage: .editProfileBlue),
        MenuList(menuName: "Delete Profile/Account", menuImage: .delete)
    ]
    
    @Environment(\.dismiss) var dismiss
    @State var isEditProfilePresented: Bool = false
    
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 0){
                HStack{
                    Image(.cooper)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Bailey Cooper")
                        .customFont(.medium, 16)
                    Spacer()
                    Image(.greyCloseButton)
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                        .onTapGesture {
                            dismiss()
                        }
                }.padding([.horizontal,.top])
                
                List(menuList){ menu in
                    HStack{
                        Text(menu.menuName)
                            .customFont(.regular, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image(uiImage: menu.menuImage)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }.frame(maxWidth: .infinity)
                        .frame(height: 38)
                        .contentShape(Rectangle())
                    .onTapGesture {
                        handleTap(for: menu.menuName)
                    }
                    
                }.listStyle(.insetGrouped)
            }
        }.background(.backgroundTheme)
            .fullScreenCover(isPresented: $isEditProfilePresented) {
                EditProfile()
            }
    }
    
    private func handleTap(for menuItem: String) {
            switch menuItem {
            case "Message":
                print("Navigate to Message Screen")
            case "Mark as inactive":
                print("Show Mark as Inactive Confirmation")
            case "Change user permission":
                print("Open User Permission Settings")
            case "Edit Profile Details":
                print("Navigate to Edit Profile Screen")
                isEditProfilePresented = true
            case "Delete Profile/Account":
                print("Show Delete Account Confirmation")
            default:
                break
            }
        }
}

#Preview {
    EditProfilePopupMenuView()
}
