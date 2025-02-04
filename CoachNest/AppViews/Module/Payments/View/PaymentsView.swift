//
//  PaymentsView.swift
//  CoachNest
//
//  Created by Rahul Pathania on 04/02/25.
//

import SwiftUI

struct PaymentsView: View {
    
    //MARK: - Variables -
    
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = PaymentsViewModel()
    @StateObject var speechManager: SpeechManager
    @Environment(\.colorScheme) var colorScheme
    @State var searchedText = ""
    @State var isRecording: Bool = false
    @State var selectedSegment = 0
    @State var isInvoiceDetailPresented: Bool = false
    
    
    var body: some View {
        ZStack{
            VStack{
                topNavView
                segmentMenuView
                ScrollView{
                    detailBasedOnSegment
                }.scrollIndicators(.hidden)
                .padding(.horizontal)
            }
        }
        .background(.backgroundTheme)
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $isInvoiceDetailPresented) {
            InvoiceDetailView()
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
            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    HStack{
                        Text(Constants.PaymentViewTitle.payments)
                            .customFont(.medium, 18)
                    }
                }
            searchView
            Divider()
        }
        .background(.darkGreyBackground)
    }
    var searchView: some View{
        HStack{
            Image(.searchIcon)
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.leading)
            
            TextField("Search here...", text: $searchedText)
                .customFont(.regular, 14)
            Spacer()
            Image(.micIcon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 15, height: 20)
                .foregroundColor(isRecording ? .red : .gray)
                .padding(.trailing)
                .onTapGesture {
                    if isRecording{
                        searchedText = ""
                        speechManager.stopVoiceSearch()
                    }else{
                        speechManager.startVoiceSearch { voiceText in
                            searchedText = voiceText
                            if !voiceText.isEmpty{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                                    print(voiceText)
                                    speechManager.stopVoiceSearch()
                                    isRecording = false
                                }
                            }
                        }
                    }
                    isRecording.toggle()
                }
        }
        .frame(height: 45)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(colorScheme == .dark ? .lightGrey.opacity(0.1) : .lightGrey)
        .clipShape(.rect(cornerRadius: 18))
        .padding([.horizontal, .bottom])
    }
    var segmentMenuView: some View{
        VStack{
            Picker("Select Option",  selection: $viewModel.selectedSegment) {
                ForEach(PaymentSegmentType.allCases){ segment in
                    Text(segment.rawValue).tag(segment)
                }
            }
            .pickerStyle(.segmented)
            .frame(height: 44)
        }
        .padding([.horizontal, .vertical])
}
    var detailBasedOnSegment: some View{
    switch viewModel.selectedSegment {
    case .all:
        ForEach(viewModel.invoice){ invoice in
            PaymentView(invoice: invoice)
                .onTapGesture {
                    isInvoiceDetailPresented = true
                }
        }
    case .due:
        ForEach(viewModel.due){ invoice in
            PaymentView(invoice: invoice)
                .onTapGesture {
                    isInvoiceDetailPresented = true
                }
        }
    case .paid:
        ForEach(viewModel.paid){ invoice in
            PaymentView(invoice: invoice)
                .onTapGesture {
                    isInvoiceDetailPresented = true
                }
        }
    }
}
}



#Preview {
    PaymentsView(speechManager: SpeechManager())
}
