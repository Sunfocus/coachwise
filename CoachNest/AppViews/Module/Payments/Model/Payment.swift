//
//  Payment.swift
//  CoachNest
//
//  Created by Rahul Pathania on 04/02/25.
//
import SwiftUI

struct Invoice: Identifiable, Hashable{
    let id = UUID()
    let invoiceName: String
    let invoiceNumber: String
    let coachName: String
    let amount: String
    let dueOnDate: String
    let paymentStatus: PaymentStatus
}

enum PaymentStatus: String {
    case overdue = "Overdue"
    case notPaid = "Not Paid"
    case paid = "Paid"
}
