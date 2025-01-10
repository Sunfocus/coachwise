//
//  ScheduleView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 23/12/24.
//

import SwiftUI


struct CalendarGridView: View {
    @Binding var selectedDate: Date
//    let onDateSelected: () -> Void
    @Binding var currentMonth: Date // Bind current month to this view
//    @Binding var selectedDateForNote: Date
//    let onDateSelectedForNote: () -> Void
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    private let calendar = Calendar.current
    private let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private var firstDayOfMonth: Date {
        let components = calendar.dateComponents([.year, .month], from: currentMonth)
        return calendar.date(from: components)!
    }
    private var lastDayOfMonth: Date {
        calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfMonth)!
    }
    private var daysInMonth: [Date?] {
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        let offsetDays = firstWeekday - 1
        var days: [Date?] = Array(repeating: nil, count: offsetDays)
        let daysInMonth = calendar.range(of: .day, in: .month, for: currentMonth)!
        // Add the days of the current month
        for day in 1...daysInMonth.count {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
                days.append(date)
            }
        }
        // Add remaining days to complete the last week
        let remainingDays = 42 - days.count
        days.append(contentsOf: Array(repeating: nil, count: remainingDays))
        return days
    }
    
    var body: some View {
        VStack {
            
            //topview
            HStack {
                Button(action: {
                    changeMonth(by: -1)
                }) {
                    Image(systemName: "chevron.left")
                        .tint(.primary)
                }
                Spacer()
                Text(monthYearString())
                    .customFont(.medium, 16)
                    .foregroundStyle(.primary)
                Spacer()
                Button(action: {
                    changeMonth(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                        .tint(.primary)
                }
            }.padding(5)
            //weekdays
            HStack {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .customFont(.medium, 14)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.gray)
                }
            }
            
            LazyVGrid(columns: columns) {
                ForEach(0..<daysInMonth.count, id: \.self) { index in
                    if let date = daysInMonth[index] {
                        DayCell(date: date,
                                isSelected: calendar.isDate(selectedDate, inSameDayAs: date),
                                isHavingEvent: false)
                        .onTapGesture {
                            selectedDate = date
                        }
                    } else {
                        // Empty cell for padding days
                        Color.clear
                            .frame(width: 5, height: 5)
                    }
                }
            }.padding(.bottom)
        }
        .padding()
        .background(.darkGreyBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private func monthYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }
    

    // Method to navigate to previous or next month
    private func changeMonth(by value: Int) {
        currentMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) ?? Date()
    }
}


struct DayCell: View {
    let date: Date
    let isSelected: Bool
    let isHavingEvent: Bool
    var body: some View {
        VStack(spacing: 3) {
            Text("\(Calendar.current.component(.day, from: date))")
                .customFont(.medium, 20)
                .frame(width: 40, height: 40)
                .background(backgroundColor)
                .foregroundStyle(foregroundColor)
                .clipShape(.rect(cornerRadius: 20))
        }
    }
    
    private var foregroundColor: Color {
        if isSelected {
            return .white
        } else {
            if isHavingEvent {
                return .primaryTheme
            } else {
                return .primary
            }
        }
    }
    
    private var backgroundColor: Color {
        if isSelected {
            return .primaryTheme
        } else {
            if isHavingEvent {
                return .primaryTheme.opacity(0.4)
            } else {
                return .clear
            }
        }
    }
}
