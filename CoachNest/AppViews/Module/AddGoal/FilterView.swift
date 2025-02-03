//
//  GoalFilterView.swift
//  CoachNest
//
//  Created by ios on 03/01/25.
//

import SwiftUI

struct FilterView: View {
    
    //MARK: - Variables -
    @State private var selectedOptionIndex = 0
    @EnvironmentObject private var router: Router
    @Environment(\.dismiss) var dismiss
    var isComingFrom: ComingFrom = .addNewGoal
    var filterOptions: [RadioButtonOption] = []
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                HStack{
                    Text("Filters")
                        .customFont(.semiBold, 24)
                    Spacer()
                    Image(.greyCloseButton)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            dismiss()
                        }
                }.padding()
                
                if isComingFrom == .chat{
                    Text("Filter by Roles")
                        .customFont(.medium, 16)
                        .padding(.leading)
                }
                
                RadioButtonListView(selectedIndex: $selectedOptionIndex, options: filterOptions)
                    .padding(.horizontal)
                
                CustomButton(
                    title: Constants.applyFilter,
                    action: {
                        dismiss()
                    }
                ).padding()
                Spacer()
            }
        }
    }
}

#Preview {
    FilterView( filterOptions: Constants.goalFilterOptions)
}
