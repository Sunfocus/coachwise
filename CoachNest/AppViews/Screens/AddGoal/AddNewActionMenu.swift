//
//  AddNewAction.swift
//  CoachNest
//
//  Created by ios on 30/12/24.
//

import SwiftUI

struct AddNewActionMenu: View {
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("New action")
                        .customFont(.semiBold, 24)
                    Spacer()
                    Image(.greyCloseButton)
                        .resizable()
                        .frame(width: 24, height: 24)
                }.padding()
                
                List{
                    ForEach(ActionListOption.allCases, id: \.self) { menuOption in
                        HStack {
                            Text(menuOption.rawValue)
                                .customFont(.regular, 16)
                            Spacer()
                            Image(.rightArrow)
                                .resizable()
                                .frame(width: 20, height: 20)
                        }.frame(height: 7.0)
                        .padding(15)
                        .onTapGesture {
                            switch menuOption{
                            case .todo:
                                print("To do menu button tapped")
                            case .inProgress:
                                print("inProgress menu button tapped")
                            case .completed:
                                print("completed menu button tapped")
                            }
                               }
                    }
                    
                }.ignoresSafeArea()
                    
                
               
            }
        }
    }
}

#Preview {
    AddNewActionMenu()
}
