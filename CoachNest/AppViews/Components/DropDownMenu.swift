//
//  DropDownMenu.swift
//  CoachNest
//
//  Created by ios on 13/01/25.
//

import SwiftUI

// MARK: - Drop Down Menu
struct DropDownMenu: View {
    let placeholder: String
    let options: [String]
    @Binding var selectedOption: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                HStack {
                    Text(selectedOption.isEmpty ? placeholder : selectedOption)
                        .foregroundColor(selectedOption.isEmpty ? Color.gray.opacity(0.6) : .primary)
                        .customFont(.regular, 14)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .padding(.trailing, 0)
                }
                .frame(height: 48)
                .padding(.horizontal)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
                .tint(.primary)
                
            }
        }
    }
}
