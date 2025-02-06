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

import SwiftUI

enum PaymentType: CaseIterable, Identifiable {
    case stripe
    case applePay
    case paypal
    case bankTransfer

    var id: String { name }

    var name: String {
        switch self {
        case .stripe: return "Stripe"
        case .applePay: return "Apple Pay"
        case .paypal: return "PayPal"
        case .bankTransfer: return "Bank Transfer"
        }
    }

    var image: Image {
        switch self {
        case .stripe: return Image("stripe") // Use asset image
        case .applePay: return Image("applePay")
        case .paypal: return Image("paypal")
        case .bankTransfer: return Image("bankTransfer")
        }
    }
}

                             

class PaymentsViewModel: ObservableObject{
    
    @Published var selectedSegment: PaymentSegmentType = .all
    @Published var selectedPaymentMethod: PaymentType = .stripe
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
}
