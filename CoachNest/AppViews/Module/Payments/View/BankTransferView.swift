//
//  BankTransferView.swift
//  CoachNest
//
//  Created by Rahul Pathania on 05/02/25.
//

import SwiftUI

struct BankTransferView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            VStack(){
                topHeaderView
                thankYouBankDetailView
                Spacer()
            }
        } .background(.backgroundTheme)
    }
    
    //MARK: - Subviews
    var topHeaderView: some View{
        VStack{
            HStack {
                Image(.greyCloseButton)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    HStack{
                        Text(Constants.PaymentViewTitle.bankTransfer)
                            .customFont(.medium, 18)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
        .padding( .bottom)
        
    }
    var thankYouBankDetailView: some View{
        VStack{
            Text(Constants.PaymentViewTitle.thankyou)
                .customFont(.medium, 24)
                .padding(.bottom)
            Text(Constants.PaymentViewTitle.hereIsBankDetailInfo)
                .customFont(.regular, 16)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            
            Text(Constants.PaymentViewTitle.bankAccount)
                .customFont(.medium, 18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, -2)
            HStack(spacing: 15){
                Image(.bankTransfer)
                    .resizable()
                    .frame(width: 28, height: 28)
                VStack{
                    Text("ICICI Bank")
                        .customFont(.medium, 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Account no: 645364756453")
                        .customFont(.regular, 14)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(.copyAccount)
                        .resizable()
                        .frame(width: 20, height: 20)
                }

            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                    .background(.darkGreyBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
            
            
        }.padding()
    }
}

#Preview {
    BankTransferView()
}
