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
                                router.navigate(to: .addGoalView(userType: .coach), style: .present)
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
                                Text("19/200")
                                    .customFont(.regular, 13)
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
                            .frame(width: 15, height: 20)
                            .padding(.trailing)
                        
                        
                    }.frame(height: 45)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.lightGrey)
                        .clipShape(.rect(cornerRadius: 18))
                        .padding([.horizontal, .bottom])
                    
                    
                    
                    
                    
                    Divider()
                }.background(.white)
                    .padding( .bottom)
                
                ScrollView{
                    VStack{
                        
                        
                            
                    }
                    
                    Spacer()
                }.padding(.horizontal)
                
            }
        }
    }
}

#Preview {
    AddMemberView()
}
