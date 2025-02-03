//
//  RadioButtonListView.swift
//  CoachNest
//
//  Created by ios on 03/01/25.
//

import SwiftUI

struct RadioButtonOption: Identifiable {
    let id = UUID()
    let title: String
}

struct RadioButtonListView: View {
    // MARK: - Properties
    @Binding var selectedIndex: Int
    let options: [RadioButtonOption]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(options.indices, id: \.self) { index in
                HStack {
                    
                    // Title
                    Text(options[index].title)
                        .customFont(.regular, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    // Radio Button
                    Image(selectedIndex == index ? .selectedRadio : .unSelectedRadio)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .contentShape(Rectangle())
                .padding(.vertical, 4)
                .onTapGesture {
                    selectedIndex = index
                }
            }
        }
    }
}

