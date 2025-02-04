//
//  ProfileView.swift
//  CoachNest
//
//  Created by ios on 20/01/25.
//

import SwiftUI

struct ProfileView: View {
    
    //MARK: - Variables -
    @State var isEventFilterViewPresented: Bool = false
    @State var isPaymentFilterViewPresented: Bool = false
    @State var isEditProfileMenuPresented: Bool = false
    @FocusState var isFocused: Bool
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ProfileViewModel()
    @StateObject var paymentViewModel = PaymentsViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                topNavView
                profileCardView
                scrollableSegmentControl
                detailViewBasedOnSegment
            }
        }
        .background(.backgroundTheme)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isPaymentFilterViewPresented) {
            FilterView(isComingFrom: .addNewGoal, filterOptions: Constants.eventFilterOptions)
                .presentationDetents([.height(370)])
                .presentationDragIndicator(.visible)
                .presentationContentInteraction(.scrolls)
        }
        .sheet(isPresented: $isEditProfileMenuPresented) {
            EditProfilePopupMenuView()
                .presentationDetents([.height(400)])
                .presentationDragIndicator(.visible)
                .presentationContentInteraction(.scrolls)
        }
    }
    
    //MARK: - Subviews -
    var topNavView: some View{
        VStack{
            HStack {
                Image(.arrowBack)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        //back button tapped
                        router.dashboardNavigateBack()
                    }
                Spacer()
                Image(.more)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        isEditProfileMenuPresented = true
                    }
                
            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    HStack{
                        Text(Constants.ProfileViewTitle.profile)
                            .customFont(.medium, 18)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
    }
    var profileCardView: some View{
        VStack{
            Image(.cooper)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            HStack{
                Image(.linkPink)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 16, height: 16)
                
                Text(Constants.ProfileViewTitle.member)
                    .customFont(.medium, 12)
                    .foregroundStyle(.pinkAccent)
            }.padding(5)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.pinkAccent, lineWidth: 1)
                }
            Text("Bessie Cooper")
                .customFont(.medium, 18)
                .foregroundStyle(.primary)
            
            Text("bill.sanders@example.com")
                .customFont(.medium, 16)
            
            
        }.frame(maxWidth: .infinity)
            .padding()
            .background(.darkGreyBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            .padding([.horizontal,.top])
    }
    var pickerSegmentView: some View{
        VStack{
            Picker("Select Option", selection: $viewModel.selectedSegment) {
                Text("Details").tag(0)
                Text("Events").tag(1)
                Text("Evaluations").tag(2)
            }
            .pickerStyle(.segmented)
            .frame(height: 44)
        }
        .padding([.horizontal, .top])
    }
    var scrollableSegmentControl: some View{
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 16) {
                            ForEach(ProfileDetailsSegmentType.allCases) { segment in
                                Text(segment.rawValue)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(viewModel.selectedSegment == segment ? Color.primaryTheme : .white)
                                    .foregroundColor(viewModel.selectedSegment == segment ? .white : .black)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        viewModel.selectedSegment = segment
                                    }
                            }
                        }
                        .padding(.horizontal)
                        .background(.backgroundTheme)
                    }
                    .frame(height: 50)
    }
    var detailViewBasedOnSegment: some View{
        VStack{
            switch viewModel.selectedSegment{
            case .details:
                profileDetailView
            case .events:
                eventDetailView
            case .evaluations:
                evaluationsView
            case .payments:
                paymentInvoiceView
            case .notes:
                notesAndBioView
            }
        }.animation(.easeIn(duration: 0.3), value: viewModel.selectedSegment)
            .keyboardToolbar()
    }
    //-------------------------------------------------------
    
    //Profile detail views
    var profileDetailView: some View{
        VStack(spacing: 0){
            ScrollView{
                personalDetailView
                emergencyContactView
                medicalView
                parent_GuardianView
            }.scrollIndicators(.hidden)
        }
    }
    var personalDetailView: some View{
        VStack(alignment: .leading, spacing: 10){
            Text(Constants.ProfileViewTitle.personalDetails)
                .customFont(.medium, 17)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 15){
                
                //Date of birth section
                VStack(spacing: 5){
                    Text(Constants.ProfileViewTitle.dateOfBirth)
                        .customFont(.medium, 16)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 5){
                        Text("01/09/2003")
                            .customFont(.medium, 15)
                        Text("(19 years)")
                            .foregroundStyle(.gray)
                            .customFont(.medium, 15)
                        Spacer()
                    }
                }
                //Phone Number section
                VStack(spacing: 5){
                    Text(Constants.ProfileViewTitle.phoneNumber)
                        .customFont(.medium, 16)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 5){
                        Image(.phoneCall)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 16)
                        Text("(625) 555-0129")
                            .customFont(.medium, 15)
                        Spacer()
                    }
                }
                
            }
            .padding()
            .background(.darkGreyBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .padding()
    }
    var emergencyContactView: some View{
        VStack(alignment: .leading, spacing: 10){
            Text(Constants.ProfileViewTitle.emergencyContacts)
                .customFont(.medium, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 15){
                
                //date of birth section
                VStack(spacing: 5){
                    Text(Constants.ProfileViewTitle.name)
                        .customFont(.medium, 16)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 5){
                        Text("Christopher Wallace Smith Sr.")
                            .customFont(.medium, 15)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                
                HStack{
                    VStack(spacing: 5){
                        Text(Constants.ProfileViewTitle.mobile)
                            .customFont(.medium, 16)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 5){
                            Image(.phoneCall)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 16, height: 16)
                            Text("(625) 555-0129")
                                .customFont(.medium, 15)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    
                    VStack(spacing: 5){
                        Text(Constants.ProfileViewTitle.relationship)
                            .customFont(.medium, 16)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Father")
                            .customFont(.medium, 15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(.darkGreyBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .padding()
    }
    var medicalView: some View{
        VStack(alignment: .leading, spacing: 10){
            Text(Constants.ProfileViewTitle.medical)
                .customFont(.medium, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 15){
                HStack{
                    VStack(spacing: 5){
                        Text(Constants.ProfileViewTitle.allergies)
                            .customFont(.medium, 16)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                       
                            Text("Nuts")
                                .customFont(.medium, 15)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    
                    VStack(spacing: 5){
                        Text(Constants.ProfileViewTitle.injuries)
                            .customFont(.medium, 16)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Pattelar Tendittis")
                            .customFont(.medium, 15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }.frame(maxWidth: .infinity)
                }
            }.padding()
                .background(.darkGreyBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }.padding()
        
    }
    var parent_GuardianView: some View{
        VStack(alignment: .leading, spacing: 10){
            
            HStack{
                Text(Constants.ProfileViewTitle.parent_Guardian)
                    .customFont(.medium, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
//                Button(action:{
//                    // open contacts for adding parent or guardian
//                })
//                {
//                    Text(Constants.ProfileViewTitle.addParent)
//                        .customFont(.medium, 15)
//                        .tint(.primaryTheme)
//                        .frame(maxWidth: .infinity, alignment: .trailing)
//                }
            }
            
            
            VStack(alignment: .leading, spacing: 15){
               
                    ForEach(0..<1){ ind in
                            HStack{
                                Image(.f1)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 33 ,height: 33)
                                    .clipShape(.circle)
                                Text("Savver Mayer")
                                    .customFont(.medium, 16)
                                Spacer()
                                Image(.rightArrow)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                            }.frame(maxWidth: .infinity)
                        
                    }
            }.padding()
                .background(.darkGreyBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }.padding()
        
        //end
    }
    //-------------------------------------------------------
    
    //Event Detail Views
    var eventDetailView: some View{
        ScrollView{
            VStack(spacing: 15){
                attendenceView
                sessionsView
            }.padding()
        }
    }
    var attendenceView: some View{
        VStack{
            HStack{
                VStack{
                    Text(Constants.ProfileViewTitle.statistics)
                        .customFont(.regular, 16)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(Constants.ProfileViewTitle.attendance)
                        .customFont(.medium, 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                YearPickerView()
            }
            
            AttendanceChartView(data: sampleData)
            
        }
        .padding()
        .background(.darkGreyBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    var sessionsView: some View{
        VStack{
            HStack{
                Text(Constants.ProfileViewTitle.sessions)
                    .customFont(.medium, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button(action:{
                    isEventFilterViewPresented = true
                })
                {
                    Image(.filterList)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            ForEach(0..<1){ value in
                SessionRowView(
                    title: "Tennis U17 - Tuesday",
                    date: "23-Jan-2025",
                    location: "Vermonth South",
                    status: .attended
                ) {
                    print("Event tapped")
                }
                
                SessionRowView(
                    title: "Tennis U17 - Tuesday",
                    date: "23-Jan-2025",
                    location: "Vermonth South",
                    status: .missed
                ) {
                    print("Event tapped")
                }
                
                SessionRowView(
                    title: "Tennis U17 - Tuesday",
                    date: "23-Jan-2025",
                    location: "Vermonth South",
                    status: .cancelled
                ) {
                    print("Event tapped")
                }
                
                SessionRowView(
                    title: "Tennis U17 - Tuesday",
                    date: "23-Jan-2025",
                    location: "Vermonth South",
                    status: .scheduled
                ) {
                    print("Event tapped")
                }
            }
        }
    }
    //-------------------------------------------------------
    
    //Evaluation View
    var evaluationsView: some View{
        ScrollView{
            ForEach(0..<1){ index in
                EvaluationView(image: .chartBar,
                               name: "Competition",
                               description: "Track and record match results")
                EvaluationView(image: .tickWithTheme,
                               name: "Tests",
                               description: "Manage various forms of evaluations such as fitness tests.")
                EvaluationView(image: .feedback,
                               name: "Reflection & Feedback",
                               description: "Record reflections after events and receive coach feedback.")
                 
            }
        }
        .safeAreaPadding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
        .scrollIndicators(.hidden)
    }
    //-------------------------------------------------------
    
    //Payment and Invoice View
    var paymentInvoiceView: some View{
        VStack{
            HStack{
                Text(Constants.ProfileViewTitle.invoices)
                    .customFont(.medium, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Button(action:{
                    isPaymentFilterViewPresented = true
                })
                {
                    Image(.filterList)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }.padding([.horizontal,.top])
            
            ScrollView{
                ForEach(paymentViewModel.invoice){ invoice in
                    PaymentView(invoice: invoice)
                }
            }.scrollIndicators(.hidden)
            
            .padding(.horizontal)
        }
        
    }
    //-------------------------------------------------------
    
    //Notes and Bio View
    var notesAndBioView: some View{
        ScrollView{
            VStack{
                coachingNotesView
                memberBioView
            }.padding()
            Spacer()
            
            CustomButton(
                title: Constants.save,
                action: {
                    dismiss()
                }
            ).padding([.horizontal, .bottom])
        }
    }
    var coachingNotesView: some View{
        VStack(spacing: 6){
            Text(Constants.ProfileViewTitle.coachingNotes)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack{
                TextField(Constants.ProfileViewTitle.enterYourNotes, text: $viewModel.enterNotes, axis: .vertical)
                    .customFont(.regular, 14)
                    .tint(.primary)
                    .lineLimit(4, reservesSpace: true)
                    .textFieldStyle(.plain)
                    .keyboardType(.alphabet)
                    .onChange(of: viewModel.enterNotes) { old, newValue in
                        if newValue.count > 100 {
                            viewModel.enterNotes = String(newValue.prefix(500))  // Trim extra characters
                        }
                    }
                    
            }
            .padding()
            .background(.darkGreyBackground)
            .cornerRadius(8)
        }
    }
    var memberBioView: some View{
        VStack(spacing: 6){
            Text(Constants.ProfileViewTitle.MemberBio)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack{
                TextField(Constants.ProfileViewTitle.enerYourBio, text: $viewModel.enterBio, axis: .vertical)
                    .customFont(.regular, 14)
                    .tint(.primary)
                    .lineLimit(4, reservesSpace: true)
                    .textFieldStyle(.plain)
                    .keyboardType(.alphabet)
                    .onChange(of: viewModel.enterNotes) { old, newValue in
                        if newValue.count > 100 {
                            viewModel.enterNotes = String(newValue.prefix(400))  // Trim extra characters
                        }
                    }
                   
            }
            .padding()
            .background(.darkGreyBackground)
            .cornerRadius(8)
        }
    }
    //-------------------------------------------------------
}

#Preview {
    ProfileView(isEventFilterViewPresented: false)
}

//Reusable Views
enum EventStatus: String{
    case attended = "Attended"
    case missed = "Missed"
    case cancelled = "Cancelled"
    case scheduled = "Scheduled"
}

struct YearPickerView: View {
    let years = Array(2000...2090) // Year range
    @State private var selectedYear = Calendar.current.component(.year, from: Date())

    var body: some View {
        HStack {
            Spacer()
            Picker("Select Year", selection: $selectedYear) {
                ForEach(years, id: \.self) { segment in
                    Text(String(segment)).tag(segment)
                }
            }
            .pickerStyle(.menu)
            
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue.opacity(0.1))
            )
            .tint(.blue)
        }
    }
}
struct SessionRowView: View {
    let title: String
    let date: String
    let location: String
    let status: EventStatus
    let onTap: () -> Void
    
    var statusForegroundColor: Color {
        switch status {
        case .attended:
            return .greenAccent
        case .missed:
            return .red
        case .cancelled:
            return .black
        case .scheduled:
            return .blueAccent
        }
    }
    var statusBackgroundColor: Color {
        switch status {
        case .attended:
            return .pastelGreen
        case .missed:
            return .pastelRed
        case .cancelled:
            return .lightGrey
        case .scheduled:
            return .blueAccent.opacity(0.1)
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .customFont(.semiBold, 16)
                Text(date)
                    .customFont(.regular, 14)
                    .foregroundStyle(.primary.opacity(0.8))
                Text(location)
                    .customFont(.regular, 14)
                    .foregroundStyle(.primary.opacity(0.8))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Text(status.rawValue)
                .customFont(.semiBold, 13)
                .padding(8)
                .background(statusBackgroundColor)
                .foregroundStyle(statusForegroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Image(.rightArrow)
                .resizable()
                .frame(width: 18, height: 18)
        }
        .padding()
        .background(.darkGreyBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .onTapGesture {
            onTap()
        }
    }
}
struct EvaluationView: View {
    
    var image : UIImage
    var name: String
    var description: String
    
    
    var body: some View {
        VStack{
            HStack(alignment: .top){
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 32, height: 32, alignment: .top)
                HStack(alignment: .center){
                    VStack(){
                    Text(name)
                        .customFont(.medium, 17)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(description)
                        .customFont(.regular, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                    Image(.rightArrow)
                        .resizable()
                        .frame(width: 18, height: 18)
                }
            }.padding()
                .background(.darkGreyBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }.frame(maxWidth: .infinity)
            .padding(.horizontal)
        
    }
}
struct PaymentView: View {
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
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(invoice.invoiceName)
                    .customFont(.medium, 18)
                Text("Invoice No: \(invoice.invoiceNumber)")
                    .customFont(.regular, 14)
                    .foregroundStyle(.primary.opacity(0.5))
                //coach name and due date section
                HStack{
                    Image(.cooper)
                        .resizable()
                        .frame(width: 18, height: 18)
                    Text(invoice.coachName)
                        .customFont(.regular, 15)
                        .foregroundStyle(.primary)
                    
                    Spacer()
                    Text("Due on: \(invoice.dueOnDate)")
                        .customFont(.regular, 14)
                        .foregroundStyle(.primary.opacity(0.5))
                }.padding(.bottom, 5)
                
                // Payment Amount and status
                HStack{
                    Text(invoice.amount)
                        .customFont(.medium, 20)
                        .foregroundStyle(.primary)
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
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
           
        }
        .padding()
        .background(.darkGreyBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
//-------------------------------------------------------




