//
//  PaymentsViewModel.swift
//  CoachNest
//
//  Created by Rahul Pathania on 04/02/25.
//

import SwiftUI

enum PaymentSegmentType: String, CaseIterable, Identifiable {
    case all = "All"
    case due = "Due"
    case paid = "Paid"
    var id: String { self.rawValue }
}
                             

class PaymentsViewModel: ObservableObject{
    
    @Published var selectedSegment: PaymentSegmentType = .all
    @Published var selectedPaymentMethod: PaymentType = PaymentType(paymentImage: .stripe,
                                                paymentName: "Stripe")
    @Published var invoice: [Invoice] = [
        
        Invoice(invoiceName: "Melbourne Dance School",
                invoiceNumber: "#124354323655",
                coachName: "Ralph Edwards",
                amount: "$25.99",
                dueOnDate: "10 Dec, 2024",
                paymentStatus: .overdue),
        
        Invoice(invoiceName: "Tennis Lesson",
                invoiceNumber: "#124354323655",
                coachName: "Ralph Edwards",
                amount: "$252.99",
                dueOnDate: "10 Dec, 2024",
                paymentStatus: .notPaid),
        
        Invoice(invoiceName: "Melbourne Dance School",
                invoiceNumber: "#124354323655",
                coachName: "Ralph Edwards",
                amount: "$25.99",
                dueOnDate: "10 Dec, 2024",
                paymentStatus: .notPaid),
        
        Invoice(invoiceName: "Tennis Lesson",
                invoiceNumber: "#124354323655",
                coachName: "Ralph Edwards",
                amount: "$252.99",
                dueOnDate: "10 Dec, 2024",
                paymentStatus: .paid),
        
        Invoice(invoiceName: "Vegas Drama School",
                invoiceNumber: "#124354323655",
                coachName: "Ralph Edwards",
                amount: "$325.99",
                dueOnDate: "10 Dec, 2024",
                paymentStatus: .notPaid),
        
        Invoice(invoiceName: "Vegas Drama School",
                invoiceNumber: "#124354323655",
                coachName: "Ralph Edwards",
                amount: "$325.99",
                dueOnDate: "10 Dec, 2024",
                paymentStatus: .notPaid)
    ]
    
     var paid: [Invoice]{
        return invoice.filter { $0.paymentStatus == .paid }
    }
   
    var due: [Invoice] {
        return invoice.filter { $0.paymentStatus == .overdue }
    }
    
    let paymentType: [PaymentType] = [PaymentType(paymentImage: .stripe,
                                                  paymentName: "Stripe"),
                                      PaymentType(paymentImage: .applePay,
                                                  paymentName: "Apple pay"),
                                      PaymentType(paymentImage: .paypal,
                                                  paymentName: "Paypal"),
                                      PaymentType(paymentImage: .bankTransfer,
                                                  paymentName: "Bank Transfer")
    ]
}
