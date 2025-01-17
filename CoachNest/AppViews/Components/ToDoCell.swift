//
//  ToDoCell.swift
//  CoachNest
//
//  Created by ios on 27/12/24.
//

import SwiftUI

struct ToDoCell: View {
    
    var action: AddAction
    
    var body: some View {
        VStack(spacing: 16) {
            // Task name
            VStack{
                HStack(spacing: 5){
                    Image(.checklist)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .scaledToFill()
                    Text(action.actionTitle)
                        .customFont(.semiBold, 16)
                        .lineLimit(1)
                    Spacer()
                    Image(.rightArrow)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .scaledToFill()
                } .frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(uiImage: action.assignedTo.profileImage ?? .sg1)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .scaledToFill()
                        .clipShape(.circle)
                    Text(action.assignedTo.name)
                        .customFont(.regular, 15)
                        .lineLimit(1)
                       
                } .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack{
                    Image(.scheduled)
                        .resizable()
                        .foregroundStyle(.blue)
                        .frame(width: 20, height: 20)
                    Text(action.dueOnDate.formattedDate(customFormat:"MMM dd, yyyy"))
                        .customFont(.regular, 14)
                        .lineLimit(1)
                        .padding(.trailing, 10)
                    Image(.link)
                        .resizable()
                        .foregroundStyle(.blue)
                        .frame(width: 20, height: 20)
                    Text("\(action.attachedDocs)")
                        .customFont(.regular, 14)
                        .lineLimit(1)
                } .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .background(.darkGreyBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
    }
}
