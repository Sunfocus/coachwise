//
//  GoalFilterView.swift
//  CoachNest
//
//  Created by ios on 03/01/25.
//

import SwiftUI

struct GoalFilterView: View {
    
    //MARK: - Variables -
    @State private var selectedOptionIndex = 0
    @EnvironmentObject private var router: Router
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            VStack{
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
                
                RadioButtonListView(selectedIndex: $selectedOptionIndex, options: Constants.filterOptions)
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
    GoalFilterView()
}
