//
//  ScheduleView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 23/12/24.
//

import SwiftUI

struct CalendarGridView: View {
    @Binding var selectedDate: Date
    @Binding var currentMonth: Date
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    private let calendar = Calendar.current
    private let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    private var firstDayOfMonth: Date {
        let components = calendar.dateComponents([.year, .month], from: currentMonth)
        return calendar.date(from: components)!
    }
    private var daysInMonth: [Date?] {
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        let offsetDays = firstWeekday - 1
        var days: [Date?] = Array(repeating: nil, count: offsetDays)
        let daysInMonth = calendar.range(of: .day, in: .month, for: currentMonth)!
        for day in 1...daysInMonth.count {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
                days.append(date)
            }
        }
        let remainingDays = 42 - days.count
        days.append(contentsOf: Array(repeating: nil, count: remainingDays))
        return days
    }
    
    var body: some View {
        VStack(spacing: 8) {
            
            // Top navigation
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .tint(.primary)
                }
                Spacer()
                Text(monthYearString())
                    .customFont(.medium, 14)
                    .foregroundStyle(.primary)
                Spacer()
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .tint(.primary)
                }
            }.padding(.horizontal, 8)
            
            // Weekday labels
            HStack {
                ForEach(weekDays, id: \.self) { day in
                    Text(day.prefix(3)) // Use abbreviated day names
                        .customFont(.medium, 12)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.gray)
                }
            }
            
            // Days grid
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(0..<daysInMonth.count, id: \.self) { index in
                    if let date = daysInMonth[index] {
                        DayCell(
                            date: date,
                            isSelected: calendar.isDate(selectedDate, inSameDayAs: date),
                            isHavingEvent: false
                        )
                        .onTapGesture {
                            selectedDate = date
                        }
                    } else {
                        Color.clear
                            .frame(height: 30) // Adjust height for padding days
                    }
                }
            }
        }
        .padding(8)
        .background(Color.darkGreyBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private func monthYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }
    
    private func changeMonth(by value: Int) {
        currentMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) ?? Date()
    }
}

struct DayCell: View {
    let date: Date
    let isSelected: Bool
    let isHavingEvent: Bool
    
    var body: some View {
        VStack(spacing: 2) {
            Text("\(Calendar.current.component(.day, from: date))")
                .customFont(.medium, 14) // Smaller font size
                .frame(width: 30, height: 30) // Reduced size
                .background(backgroundColor)
                .foregroundStyle(foregroundColor)
                .clipShape(Circle())
        }
    }
    
    private var foregroundColor: Color {
        if isSelected {
            return .white
        } else {
            return isHavingEvent ? .primaryTheme : .primary
        }
    }
    
    private var backgroundColor: Color {
        if isSelected {
            return .primaryTheme
        } else {
            return isHavingEvent ? .primaryTheme.opacity(0.4) : .clear
        }
    }
}
