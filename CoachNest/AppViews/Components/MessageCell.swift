//
//  ChatListingDetailView.swift
//  CoachNest
//
//  Created by ios on 06/01/25.
//

import SwiftUI

struct MessageCell: View {
    
    var body: some View {
        HStack{
            Image(.f2)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 3){
                Text("Ashley Jane")
                    .customFont(.semiBold, 15)
                    .lineLimit(1)
                Text("Thanks a bunch! Have a great day! 😊")
                    .customFont(.regular, 14)
                    .foregroundStyle(.primary.opacity(0.5))
                    .lineLimit(1)
                
            }
            Spacer()
            VStack(spacing: 7){
                Text("10:25")
                    .customFont(.medium, 12)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                Text("3")
                    .customFont(.semiBold, 12)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
                    .background(Circle().fill(Color.primaryTheme))
            }
        }
        .padding(.horizontal) // Keep padding horizontal only
               .frame(maxWidth: .infinity, minHeight: 60)
               .background(.darkGreyBackground) // Apply background directly
        Divider()
            .padding(.leading)
        
    }
    
    
}

#Preview {
    MessageCell()
}
