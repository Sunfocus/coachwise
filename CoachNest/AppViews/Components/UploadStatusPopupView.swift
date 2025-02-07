//
//  UploadStatusPopupView.swift
//  CoachNest
//
//  Created by Rahul Pathania on 07/02/25.
//

import SwiftUI

struct UploadStatusPopupView: View {
    let isSuccess: Bool
    let title: String
    let message: String
    let primaryButtonTitle: String?
    let primaryAction: (() -> Void)?
    let secondaryButtonTitle: String?
    let secondaryAction: (() -> Void)?

    var body: some View {
        VStack(spacing: 2) {
            VStack{
                Image(isSuccess ? .paymentSuccessful : .paymentFailed)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Text(title)
                    .customFont(.medium, 22)
                    .padding(.bottom, 2)
                
                Text(message)
                    .customFont(.regular, 16)
                    .multilineTextAlignment(.center)
            }.padding()

            Divider()

            HStack {
                if let primaryButtonTitle = primaryButtonTitle, let primaryAction = primaryAction {
                    Button(action: primaryAction) {
                        Text(primaryButtonTitle)
                            .customFont(.medium, 16)
                            .tint(.primaryTheme)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                

                if let secondaryButtonTitle = secondaryButtonTitle, let secondaryAction = secondaryAction {
                    
                    Rectangle()
                        .frame(width: 1, height: 20)
                        .foregroundColor(.gray.opacity(0.3))
                    
                    Button(action: secondaryAction) {
                        Text(secondaryButtonTitle)
                            .customFont(.medium, 16)
                            .frame(maxWidth: .infinity)
                    }
                   
                }
            }.padding()
        }
        .background(Color.white.opacity(1))
        .clipShape(.rect(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .frame(maxWidth: 300)
    }
}

#Preview {
    UploadStatusPopupView(isSuccess: true,  title: "Thankyou", message: "Your upload was successful :)", primaryButtonTitle: "Try again", primaryAction: {
        
    }, secondaryButtonTitle: "Contact Us", secondaryAction: {
        
    })
}

