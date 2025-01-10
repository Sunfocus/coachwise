//
//  ScheduleView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 23/12/24.
//

import SwiftUI

struct ScheduleView: View {
    //MARK: - Variables -
    @Environment(\.presentSideMenu) var presentSideMenu
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var router: Router
    @State private var addScheduleViewIsPresented: Bool = true
    @State private var scheduleModelHasData: Bool = true
    @State private var selectedSegment = 0
    @State private var selectedDate: Date = Date()
    @State private var currentWeek: [Date] = []
    @State private var today: Date = Date()
    
    var body: some View {
        ZStack{
            VStack{
                topHeaderView
                if scheduleModelHasData{
                    scheduleView

                }else{
                    noScheduleToView
                }
                
            }
        }.background(.backgroundTheme)
            .overlay(
                addScheduleButtonView
                    .padding(.trailing, 30)
                    .padding(.bottom, 40),
                   alignment: .bottomTrailing
            )
    }
    
    //MARK: - Subviews -
    var topHeaderView: some View {
        //Tab Name menu icon filter and notification toggle Section
        VStack(spacing: 0){
            //Tab Name menu icon filter and notification toggle Section
            HStack {
                Image(.menuIcon)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        //Open sidemenu
                        presentSideMenu.wrappedValue.toggle()
                    }
                Text("Schedule")
                    .customFont(.semiBold, 24)
                Spacer()
                Image(.bell)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        router.navigate(to: .notificationView)
                    }
                    .padding(.trailing, 12)
                Image(.filterList)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                       
                    }
            }.padding([.horizontal, .vertical], 15)
            Divider()
        }
        .background(.darkGreyBackground)
    }
    var addScheduleButtonView: some View {
        Button(action: {
            print("Add new tapped")
            addScheduleViewIsPresented = true
           // router.navigate(to: .addGoalView(userType: .coach, goalId: UUID(), comingFrom: .addNewGoal))
        }) {
            Circle()
                .foregroundStyle(.primaryTheme)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(.white)
                }
        }
       
    }
    var noScheduleToView: some View{
            //MARK: - No schedule to view Section -
            VStack{
                Spacer()
                Image(.addSchedule)
                    .resizable()
                    .frame(width: 64, height: 64)
                Text(Constants.AddYourScheduleViewTitle.noSchedule)
                    .customFont(.medium, 16)
                    .foregroundStyle(.primaryTheme)
                Text(Constants.AddYourScheduleViewTitle.tapAdd)
                    .customFont(.regular, 14)
                Spacer()
            }
            .frame(maxWidth: .infinity)
    }
    var scheduleView: some View{
        VStack{
            pickerView
            switch selectedSegment{
            case 0:
                dateSelectView
            case 1:
                calenderSelectView
            default:
                dateSelectView
            }
            ScrollView{
                HStack {
                    Text("Schedule")
                        .customFont(.medium, 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text("View All")
                        .customFont(.medium, 14)
                        .onTapGesture {
                            print("View All Schedule Tapped")
                        }
                } .padding(.horizontal, 18)
                .background(.backgroundTheme)
                scheduledEventList
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 18)
                    .background(.backgroundTheme)
            }.scrollIndicators(.hidden)
               
        }
    }
    var pickerView: some View{
            VStack{
                Picker("Select Option", selection: $selectedSegment) {
                    Text("Week").tag(0)
                    Text("Month").tag(1)
                }
                .pickerStyle(.segmented)
                .frame(height: 44)
            }
            .padding([.horizontal, .top])
        }
    var dateSelectView: some View{
        // Calendar Navigation
        VStack{
            HStack {
                Button(action: previousWeek) {
                    Image(.rightArrow)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .scaleEffect(x: -1, y: 1)
                        .tint(.primary)
                }
                Spacer()
                Text(todayText)
                    .customFont(.medium, 16)
                Spacer()
                Button(action: nextWeek) {
                    Image(.rightArrow)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(.primary)
                }
            }
            .padding([.horizontal, .top])
            
            // Horizontal Calendar
            if currentWeek.count == 7 {
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(currentWeek, id: \.self) { date in
                                VStack{
                                    Text(shortDay(for: date))
                                        .font(.caption)
                                        .foregroundColor(Calendar.current.isDate(selectedDate, inSameDayAs: date) ? .primaryTheme : colorScheme == .dark ? .white : .black.opacity(0.8))
                                    Text(day(for: date))
                                        .fontWeight(.semibold)
                                        .frame(width: 35, height: 35)
                                        .background(Calendar.current.isDate(selectedDate, inSameDayAs: date) ? .primaryTheme : Color.clear)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .strokeBorder(
                                                    Calendar.current.isDate(selectedDate, inSameDayAs: date) ? Color.clear : colorScheme == .dark ? .white : .black.opacity(0.8),
                                                    lineWidth: 1
                                                )
                                                .padding(2)
                                        )
                                        .foregroundColor(Calendar.current.isDate(selectedDate, inSameDayAs: date) ? .white : colorScheme == .dark ? .white : .black.opacity(0.8))
                                }
                                .frame(width: geometry.size.width / 7 - 6)
                                .onTapGesture {
                                    selectedDate = date
                                }
                            }
                        }
                    }
                    .scrollDisabled(true)
                    .padding(.horizontal, 22)
                }
                .frame(height: 70)
            }
        }
        .background(.darkGreyBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding()
        
        
        .onAppear {
            generateCurrentWeek()
        }
    }
    var calenderSelectView: some View{
            CalendarGridView(selectedDate: $selectedDate, currentMonth: $selectedDate)
            .padding()
    }
    var scheduledEventList: some View {
        ForEach(0..<3){_ in 
            scheduleRow
                .padding(.bottom, 2)
                .padding(.horizontal, 3)
        }
    }
    var scheduleRow: some View {
        VStack(spacing: 5) {
            // Time row
            HStack(spacing: 5) {
                Image(.clock)
                    .resizable()
                    .frame(width: 12, height: 12)
                Text("6:00 PM - 6:45 PM")
                    .customFont(.regular, 12)
                Spacer()
                Text("Attendance")
                    .customFont(.regular, 12)
            }
            
            // Event name
            HStack{
                Text("Junior Squad")
                    .customFont(.semiBold, 14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.pastelGreen)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.green, lineWidth: 1)
                    )
                    .overlay {
                        Text("12")
                            .customFont(.medium, 10)
                            .foregroundStyle(.green)
                    }
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.pastelRed)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.red, lineWidth: 1)
                    )
                    .overlay {
                        Text("3")
                            .customFont(.medium, 10)
                            .foregroundStyle(.red)
                    }
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.gray.tertiary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .overlay {
                        Text("9")
                            .customFont(.medium, 10)
                            .foregroundStyle(.black)
                    }

            }
        
                
                
                // Members and date row
                HStack(spacing: 5) {
                    ScheduleMemberView(memberImages: ["sg1", "f1", "f2"])
                    Image(.noMessages)
                        .resizable()
                        .frame(width: 15, height: 15)
                    Spacer()
                   
                }
            }.padding(10)
            .background(.darkGreyBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}


// MARK: - Helper Methods
extension ScheduleView {
    private func generateCurrentWeek() {
        currentWeek = getWeekDates(from: today)
    }

    private func previousWeek() {
        today = Calendar.current.date(byAdding: .day, value: -7, to: today) ?? Date()
        currentWeek = getWeekDates(from: today)
        setDefaultSelectedDate()
    }

    private func nextWeek() {
        today = Calendar.current.date(byAdding: .day, value: 7, to: today) ?? Date()
        currentWeek = getWeekDates(from: today)
        setDefaultSelectedDate()
    }

    private func getWeekDates(from date: Date) -> [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }

    private func shortDay(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }

    private func day(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    private func setDefaultSelectedDate() {
        if currentWeek.contains(where: { Calendar.current.isDate($0, inSameDayAs: today) }) {
            selectedDate = today
        } else {
            selectedDate = currentWeek.first ?? Date()
        }
    }

    private var todayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return Calendar.current.isDate(selectedDate, inSameDayAs: today) ? "Today" : formatter.string(from: selectedDate)
    }
}

#Preview {
    ScheduleView()
        .environmentObject(Router())
}
