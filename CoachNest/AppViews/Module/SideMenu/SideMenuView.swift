//
//  SideMenuView.swift
//  DripJobsTeams
//
//  Created by Zeeshan Suleman on 28/02/2023.
//

import SwiftUI

enum SideMenuRowType: Int, CaseIterable {
    case profile = 0
    case payments
    case directory
    case evaluations
    case documents
    case actions
    case settings
    case subscription
    case share
    case help
    case logOut
    
    var title: String{
        switch self {
        case .profile:
            return "Profile"
        case .payments:
            return "Payments"
        case .directory:
            return "Directory"
        case .evaluations:
            return "Evaluations"
        case .documents:
            return "Documents"
        case .actions:
            return "Actions"
        case .settings:
            return "Settings"
        case .subscription:
            return "Subscription"
        case .share:
            return "Share"
        case .help:
            return "Help"
        case .logOut:
            return "Log out"
        }
    }
    
    var iconName:UIImage {
        switch self {
        case .profile:
            return .profile
        case .payments:
            return .directory
        case .directory:
            return .directory
        case .evaluations:
            return .evaluations
        case .documents:
            return .documents
        case .actions:
            return .action
        case .settings:
            return .settings
        case .subscription:
            return .subscription
        case .share:
            return .share
        case .help:
            return .help
        case .logOut:
            return .logOut
        }
    }
}

struct SideMenuView: View {
    
    @Binding var activeTab: Tab
    @Binding var presentSideMenu: Bool
    @EnvironmentObject var router: Router
    @State var isSwitchProfilePresented = false
    
    var body: some View {
        HStack {
            ZStack{
                VStack(alignment: .leading, spacing: 0) {
                    ProfileImageView()
                        .padding(.bottom, 30)
                    
                    ForEach(SideMenuRowType.allCases, id: \.self){ row in
                        RowView(
                            isSelected: false,
                            image: row.iconName,
                            title: row.title
                        ) {
                            switch row{
                                
                            case .profile:
                                router.navigate(to: .profileView)
                            case .payments:
                                router.navigate(to: .profileView)
                            case .directory:
                                router.navigate(to: .profileView)
                            case .evaluations:
                                router.navigate(to: .profileView)
                            case .documents:
                                router.navigate(to: .profileView)
                            case .actions:
                                router.navigate(to: .profileView)
                            case .settings:
                                router.navigate(to: .profileView)
                            case .subscription:
                                router.navigate(to: .profileView)
                            case .share:
                                router.navigate(to: .profileView)
                            case .help:
                                router.navigate(to: .profileView)
                            case .logOut:
                                router.navigate(to: .profileView)
                            }
                            presentSideMenu.toggle()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 60)
                .frame(width: 270)
                .background(
                    Color.white
                )
            }
            
            
            Spacer()
        }
        .background(.clear)
        .fullScreenCover(isPresented: $isSwitchProfilePresented) {
            SwitchProfileView()
        }
    }
    
    func ProfileImageView() -> some View{
        VStack(alignment: .center){
            HStack{
                Spacer()
                Image(.sg1)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 48, height: 48)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.purple.opacity(0.5), lineWidth: 1)
                    )
                    .cornerRadius(24)
                Spacer()
            }
            
            VStack(spacing: 5) {
                Text("Bessie Cooper")
                    .customFont(.semiBold,14)
                    .foregroundColor(.black)
                
                Text(verbatim: "bill.sanders@example.com") // Changes "verbatim" the color of the text disable as a link
                    .customFont(.medium, 12)
                    .foregroundStyle(.gray)
            }
            
            Text("Glen Waverley Cricket Club")
                .customFont(.bold,14)
                .foregroundColor(.black)
                .padding(.top, 4)
            
            Button(action: {
                print("On Tap Switch")
                isSwitchProfilePresented = true
            }, label: {
                Image(.refresh)
                    .resizable()
                    .frame(width: 16, height: 16)
                Text("Switch")
                    .customFont(.medium, 12)
                    .foregroundStyle(.white)
            })
            .frame(width: 106, height: 26)
            .background(.pinkAccent)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
    func RowView(
        isSelected: Bool,
        image: UIImage,
        title: String,
        hideDivider: Bool = false,
        action: @escaping (()->())
    ) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? .purple : .white)
                        .frame(width: 5)
                    
                    ZStack{
                        Image(uiImage: image)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? .black : .black)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .customFont(.regular, 17)
                        .foregroundColor(isSelected ? .black : .black)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? .purple.opacity(0.5) : .white, .white], startPoint: .leading, endPoint: .trailing)
        )
    }
}

