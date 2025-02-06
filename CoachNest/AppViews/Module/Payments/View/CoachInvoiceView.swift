//
//  CoachInvoiceView.swift
//  CoachNest
//
//  Created by Rahul Pathania on 05/02/25.
//

import SwiftUI

struct CoachInvoiceView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = PaymentsViewModel()
    @State var markPaid: Bool = false
    let invoice: Invoice
    var statusForegroundColor: Color {
        switch invoice.paymentStatus{
        case .overdue:
                .red
        case .notPaid:
                .blueAccent
        case .paid:
                .greenAccent
        }
    }
    var statusBackgroundColor: Color {
        switch invoice.paymentStatus{
        case .overdue:
                .pastelRed
        case .notPaid:
                .blueAccent.opacity(0.1)
        case .paid:
                .pastelGreen
        }
    }
    var statusImage: UIImage{
        switch invoice.paymentStatus{
        case .overdue:
                .overdue
        case .notPaid:
                .notPaid
        case .paid:
                .paid
        }
    }
    
    var body: some View {
        ZStack{
            VStack(){
                topHeaderView
                ScrollView{
                    VStack(spacing: 5){
                        invoiceDetailView
                        taxDiscountView
                        markAsPaidView
                    }
                }.scrollIndicators(.hidden)
                CustomButton(
                    title: Constants.PaymentViewTitle.save,
                    action: {
    
                    }
                )
                    .padding(.horizontal)
                
                Button {
                    
                } label: {
                    Text(Constants.PaymentViewTitle.sendInvoiceReminder)
                        .customFont(.regular, 15)
                        .tint(.primary)
                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.primary, lineWidth: 0.6)
                        }
                        .padding(.horizontal)
                }

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
                    HStack{
                        VStack{
                            Text(Constants.PaymentViewTitle.invoiceName)
                                .customFont(.medium, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(invoice.invoiceName)
                                .customFont(.regular, 15)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.primary.opacity(0.8))
                        }
                        
                        Spacer()
                        
                        HStack{
                            Image(uiImage: statusImage)
                                .resizable()
                                .frame(width: 18, height: 18)
                            Text(invoice.paymentStatus.rawValue)
                                .customFont(.semiBold, 12)
                                .foregroundStyle(statusForegroundColor)
                        }.padding(.horizontal, 15)
                            .padding(.vertical, 6)
                            .background(statusBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                   
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
    var markAsPaidView: some View{
        HStack{
            Button {
                markPaid.toggle()
            } label: {
                Image(markPaid ? .checkboxFill : .checkboxEmpty)
                    .resizable()
                    .frame(width: 25 ,height: 25)
            }
            Text("Mark as Paid")
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 10)
    }
}

#Preview {
    CoachInvoiceView(invoice: Invoice(invoiceName: "xxxxxxx", invoiceNumber: "", coachName: "", amount: "", dueOnDate: "", paymentStatus: .notPaid))
}
