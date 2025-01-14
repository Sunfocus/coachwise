//
//  DummyTextView.swift
//  CoachNest
//
//  Created by ios on 14/01/25.
//

import SwiftUI

struct DummyTextView: View {
    
    @State private var status: StatusOption = .todo
    
    
    var body: some View {
        ZStack{
            VStack{
                statusSelectionView
            }
        }
    }
    
    var statusSelectionView: some View{
        //Status selection Section
            Menu {
                ForEach(StatusOption.allCases, id: \.self) { option in
                    Button(action: {
                        status = option
                    }) {
                        Text(option.rawValue)
                    }
                }
            } label: {
                HStack {
                    Text(status.rawValue)
                        .customFont(.regular, 16)
                        .foregroundStyle(.black)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 16))
                        .tint(.gray)
                }
                .padding()
                .frame(height: 50)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }//label End
    }
    
    
}

#Preview {
    DummyTextView()
}
