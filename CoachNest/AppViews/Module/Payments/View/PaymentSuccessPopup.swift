//
//  PaymentSuccessPopup.swift
//  CoachNest
//
//  Created by Rahul Pathania on 05/02/25.
//

import SwiftUI

struct PaymentSuccessPopup: View {
    var isSuccess: Bool
    var onDismiss: (Bool) -> Void
    var paymentSuccess = Constants.PaymentViewTitle.paymentSuccess
    var paymentSuccessDesc = Constants.PaymentViewTitle.paymentSuccessDesc
    var paymentFailed = Constants.PaymentViewTitle.paymentFailed
    var paymentFailedDesc = Constants.PaymentViewTitle.paymentFailedDesc
    var backToPayments = Constants.PaymentViewTitle.backToPayments
    var tryAnotherMethod = Constants.PaymentViewTitle.tryAnotherMethod
    
    var body: some View {
        VStack(spacing: 10) {
            Image(isSuccess ? .paymentSuccessful : .paymentFailed)
                .resizable()
                .frame(width: 70, height: 70)
                .foregroundColor(.green)
            
            Text(isSuccess ? paymentSuccess : paymentFailed)
                .customFont(.medium, 20)
            
            Text(isSuccess ? paymentSuccessDesc : paymentFailedDesc)
                .customFont(.regular, 16)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            
            Divider()
            
            Button(action: {
                onDismiss(isSuccess)
            }) {
                Text(isSuccess ? backToPayments : tryAnotherMethod)
                    .customFont(.regular, 16)
                    .foregroundColor(.red)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(.darkGreyBackground)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 60)
    }
}
