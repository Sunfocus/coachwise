//
//  AttendanceChartView.swift
//  CoachNest
//
//  Created by Rahul Pathania on 30/01/25.
//

import SwiftUI
import Charts

struct AttendanceRecord: Identifiable {
    let id = UUID()
    let month: String
    let category: String // "Attended", "Missed", "Canceled"
    let count: Int
}

// Sample Data
let sampleData: [AttendanceRecord] = [
    AttendanceRecord(month: "Jul", category: "Attended", count: 12),
    AttendanceRecord(month: "Jul", category: "Missed", count: 7),
    AttendanceRecord(month: "Jul", category: "Cancelled", count: 5),

    AttendanceRecord(month: "Aug", category: "Attended", count: 10),
    AttendanceRecord(month: "Aug", category: "Missed", count: 6),
    AttendanceRecord(month: "Aug", category: "Cancelled", count: 4),

    AttendanceRecord(month: "Sep", category: "Attended", count: 8),
    AttendanceRecord(month: "Sep", category: "Missed", count: 7),
    AttendanceRecord(month: "Sep", category: "Cancelled", count: 6),

    AttendanceRecord(month: "Oct", category: "Attended", count: 11),
    AttendanceRecord(month: "Oct", category: "Missed", count: 6),
    AttendanceRecord(month: "Oct", category: "Cancelled", count: 5),

    AttendanceRecord(month: "Nov", category: "Attended", count: 15),
    AttendanceRecord(month: "Nov", category: "Missed", count: 8),
    AttendanceRecord(month: "Nov", category: "Cancelled", count: 6),

    AttendanceRecord(month: "Dec", category: "Attended", count: 9),
    AttendanceRecord(month: "Dec", category: "Missed", count: 5),
    AttendanceRecord(month: "Dec", category: "Cancelled", count: 4)
]


struct AttendanceChartView: View {
    var data: [AttendanceRecord]

    var body: some View {
        VStack {

            Chart(data) { record in
                BarMark(
                    x: .value("Month", record.month),
                    y: .value("Count", record.count)
                )
                .foregroundStyle(by: .value("Category", record.category))
            }
            .chartLegend(position: .bottom)
            .frame(height: 100)
            .padding()
        }
    }
}
