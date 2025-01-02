//
//  PersonImageView.swift
//  CoachNest
//
//  Created by ios on 25/12/24.
//

import SwiftUI

struct PersonImageView: View {
    
    @Binding var isSelected: Bool
    
    var image: UIImage
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(.circle)
            .overlay {
                Image(.closeBtn)
                    .resizable()
                    .frame(width: 16, height: 16, alignment: .topTrailing)
                     .offset(x: 20, y: -15)
                     .onTapGesture {
                         isSelected.toggle()
                         HapticFeedbackHelper.lightImpact()
                     }
            }
    }
}

#Preview {
    PersonImageView(isSelected: .constant(false), image: .f2)
}
