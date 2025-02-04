//
//  BusinessActivityView.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 18/12/24.
//

import SwiftUI

// MARK: - EnrollmentData Model
struct BusinessActivityData: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
}

struct BusinessActivityView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: BusinessActivityViewModel
    @State private var newActivity: String = ""
    @State private var isActivityViewPresented: Bool = false
    @State private var selectedEnrollmentId: Int? = nil
    
    var body: some View {
        ZStack {
            VStack {
                // MARK: - Back Button Section
                VStack {
                    HStack {
                        Image(.arrowBack)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                router.authNavigateBack()
                            }
                        Spacer()
                    }
                    HStack {
                        Text(Constants.BusinessActivityViewTitle.businessActivity)
                            .customFont(.semiBold, 24)
                        Spacer()
                    }.padding(.top, 12)
                }.padding(.horizontal, 20)
                
                // MARK: - List Stack
                ScrollView {
                    ForEach(viewModel.getAllActivities()) { activity in
                        ZStack {
                            VStack(spacing: 10){
                                HStack(alignment: .top, spacing: 12) {
                                    Image(selectedEnrollmentId == activity.id ? .selectedRadio : .unSelectedRadio)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    Text(activity.title)
                                        .customFont(.regular, 16)
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                                
                                Divider()
                                    .padding(.leading, 20)
                                  
                            }
                            
                        }
                        .onTapGesture {
                           onTapActivity(activity.id)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .padding(.all, 0)
                .scrollIndicators(.never)
                .background(.backgroundTheme)
                
                Spacer()
                
                // MARK: - Next Button
                VStack{
                    CustomButton(
                        title: Constants.EnrollmentTypeViewTitle.next,
                        action: {
                            router.navigate(to: .ageGroupView)
                            HapticFeedbackHelper.mediumImpact()
                        }
                    )
                }.padding(.horizontal, 20)
            }
        }
        .background(.backgroundTheme)
        .overlay(
            Button(action: {
                print("Add new tapped")
                isActivityViewPresented = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.primaryTheme)
            }
            .padding(.trailing, 30)
            .padding(.bottom, 90),
           alignment: .bottomTrailing
        )  
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isActivityViewPresented) {
            AddActivityView()
                .presentationDetents([.height(200)])
                .presentationDragIndicator(.visible)
                .presentationContentInteraction(.scrolls)
        }
    }

    
    // Function to toggle selection
    private func onTapActivity(_ id: Int) {
        if selectedEnrollmentId != id {
            selectedEnrollmentId = id
        }
    }
}

#Preview {
    BusinessActivityView()
        .environmentObject(BusinessActivityViewModel())
}
