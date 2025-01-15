//
//  MemoriesView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 23/12/24.
//

import SwiftUI

struct MemoriesView: View {
    
    //MARK: - Variables -
    @Environment(\.presentSideMenu) var presentSideMenu
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var router: Router
    
    
    var body: some View {
        ZStack{
            VStack{
                topHeaderView
                Spacer()
            }
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
                Text("Memories")
                    .customFont(.semiBold, 24)
                Spacer()
                Image(.bell)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        router.navigate(to: .notificationView)
                    }
                    .padding(.trailing, 12)
                Image(.filterList)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                       
                    }
            }.padding([.horizontal, .vertical], 15)
            Divider()
        }
        .background(.darkGreyBackground)
    }
}

#Preview {
    MemoriesView()
}
