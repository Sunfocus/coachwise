//
//  InvoiceDetailView.swift
//  CoachNest
//
//  Created by Rahul Pathania on 04/02/25.
//

import SwiftUI

struct InvoiceDetailView: View {
    
    //MARK: - Variables -
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = PaymentsViewModel()
    
    var body: some View {
        ZStack{
            VStack(){
                topHeaderView
                ScrollView{
                    VStack(spacing: 5){
                        invoiceDetailView
                        taxDiscountView
                        paymentMethods
                    }
                }.scrollIndicators(.hidden)
                CustomButton(
                    title: Constants.PaymentViewTitle.payNow,
                    action: {
                        dismiss()
                    }
                ).padding(.bottom)
                    .padding(.horizontal)
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
                        Text(Constants.PaymentViewTitle.invoice)
                            .customFont(.medium, 18)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
        .padding( .bottom)
        
    }
    var invoiceDetailView: some View{
        VStack(spacing: 5){
            Text("\(Constants.PaymentViewTitle.invoiceNo) #898767898790")
                .customFont(.semiBold, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            VStack(spacing: 15){
                
                VStack{
                    Text(Constants.PaymentViewTitle.invoiceName)
                        .customFont(.medium, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("XXXXXXXX")
                        .customFont(.regular, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.primary.opacity(0.8))
                }
                
                VStack{
                    Text(Constants.PaymentViewTitle.invoiceFrequency)
                        .customFont(.medium, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("XXXXXXXX")
                        .customFont(.regular, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.primary.opacity(0.8))
                }
                
                Divider()
                
                VStack{
                    Text(Constants.PaymentViewTitle.description)
                        .customFont(.medium, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(Constants.PaymentViewTitle.dummyDescription)
                        .customFont(.regular, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.primary.opacity(0.8))
                }
                
                Divider()
                
                HStack{
                    VStack{
                        Text(Constants.PaymentViewTitle.dateIssued)
                            .customFont(.medium, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("XXXXXXXX")
                            .customFont(.regular, 15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.primary.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    VStack{
                        Text(Constants.PaymentViewTitle.dueOn)
                            .customFont(.medium, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("XXXXXXXX")
                            .customFont(.regular, 15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.primary.opacity(0.8))
                    }
                    
                }
                
            }.padding()
                .background(.darkGreyBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .padding(.horizontal)
                .padding(.bottom, 5)
        }
    }
    var taxDiscountView: some View{
        VStack(spacing: 8){
            taxView(name: Constants.PaymentViewTitle.tax, amount: "$2.95")
            taxView(name: Constants.PaymentViewTitle.discount, amount: "$2.95")
            taxView(name: Constants.PaymentViewTitle.price, amount: "$2.95")
            taxView(name: Constants.PaymentViewTitle.amountPaid, amount: "$2.95")
            totalAmountView(name: Constants.PaymentViewTitle.totalDue, amount: "$30.00")
        }.padding()
            .background(.darkGreyBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            .padding(.horizontal)
    }
    var paymentMethods: some View{
        VStack(spacing: 5){
            Text(Constants.PaymentViewTitle.paymentMethods)
                .customFont(.medium, 18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 10)
           
            
            
            VStack{
                paymentMode(viewModel: viewModel, payment: viewModel.paymentType[0])
                    .onTapGesture {
                        viewModel.selectedPaymentMethod = viewModel.paymentType[0]
                    }
                Divider()
                paymentMode(viewModel: viewModel, payment: viewModel.paymentType[1])
                    .onTapGesture {
                        viewModel.selectedPaymentMethod = viewModel.paymentType[1]
                    }
                Divider()
                paymentMode(viewModel: viewModel, payment: viewModel.paymentType[2])
                    .onTapGesture {
                        viewModel.selectedPaymentMethod = viewModel.paymentType[2]
                    }
                Divider()
                paymentMode(viewModel: viewModel, payment: viewModel.paymentType[3])
                    .onTapGesture {
                        viewModel.selectedPaymentMethod = viewModel.paymentType[3]
                    }
            }.padding()
                .background(.darkGreyBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .padding(.horizontal)
                .padding(.bottom, 5)
        }
    }
}

#Preview {
    InvoiceDetailView()
}

//MARK: - Reusable Views
struct taxView: View {
    var name: String
    var amount: String
    var body: some View {
        HStack{
            Text(name)
                .customFont(.regular, 14)
            Spacer()
            Text(amount)
                .customFont(.regular, 14)
        }.frame(maxWidth: .infinity)
    }
}
struct totalAmountView: View {
    var name: String
    var amount: String
    var body: some View {
        HStack{
            Text(name)
                .customFont(.semiBold, 16)
            Spacer()
            Text(amount)
                .customFont(.semiBold, 16)
        }.frame(maxWidth: .infinity)
    }
}
struct paymentMode: View {
    
    
    @ObservedObject var viewModel: PaymentsViewModel
    var payment: PaymentType
    
    var body: some View {
        HStack{
            Image(uiImage: payment.paymentImage)
                .resizable()
                .frame(width: 30, height: 39)
            Text(payment.paymentName)
                .customFont(.medium, 15)
            Spacer()
            Image(uiImage: viewModel.selectedPaymentMethod.paymentName == payment.paymentName ? .selectedRadio : .unSelectedRadio )
                .resizable()
                .frame(width: 24, height: 24)
        }.frame(maxWidth: .infinity)
            .frame(height: 34)
            .contentShape(Rectangle())
    }
}

