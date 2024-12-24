//
//  JoinGroupView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 20/12/24.
//

import SwiftUI

struct JoinGroupView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var selectionTypeViewModel: SelectionTypeViewModel
    
    @State private var teamId = Field(
        title: Constants.TextField.Title.enterTeamIdFromLink,
        placeholder: Constants.TextField.Placeholder.enterTeamId
    )
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    // MARK: - Join Group Image
                    Image(.joinGroup)
                        .resizable()
                        .frame(width: 223, height: 215)
                        .padding(.top, 25)
                }
                .padding(.horizontal, 20)
                
                VStack {
                    // MARK: - Join Group Text
                    VStack(spacing: 8) {
                        Text(Constants.JoinGroupViewTitle.joinGroup)
                            .customFont(.medium, 24)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        Text(Constants.JoinGroupViewTitle.joinGroupInstructionMessage)
                            .customFont(.regular, 14)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
                    
                    // MARK: - Join Group TextField & Example Id
                    VStack {
                        CustomTextField(field: $teamId)
                            .onChange(of: teamId.value) { oldValue, newValue in
                                if teamId.value == ""{
                                    teamId.error = .emptyTeamId
                                }else{
                                    teamId.error = nil
                                }
                            }
                        HStack {
                            Text(Constants.JoinGroupViewTitle.exampleId)
                                .customFont(.regular, 14)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                    }.padding(.top, 25)
                }
                .padding(.top, 15)
                .padding(.horizontal, 20)
                // MARK: - Almost There View
                VStack(spacing: 2) {
                    Text(Constants.JoinGroupViewTitle.almostThere)
                        .customFont(.semiBold, 20)
                        .foregroundStyle(.primaryTheme)
                    Text(Constants.JoinGroupViewTitle.registerUsingTheSameLink)
                        .customFont(.regular, 14)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity,alignment: .center)
                }.padding(.top, 25)
                .padding(.horizontal, 20)
                
                Spacer()
                // MARK: - Next Button
                VStack{
                    CustomButton(
                        title: Constants.JoinGroupViewTitle.join,
                        action: {
                            router.navigate(to: .dateOfBirthView)
                            switch selectionTypeViewModel.selectedType {
                            case .coach:
                                router.setRoot(to: .dashboard)
                                router.isUserLoggedIn = true
                            case .parent:
                                router.setRoot(to: .dashboard)
                                router.isUserLoggedIn = true
                            case .member:
                                router.navigate(to: .letsCompleteProfile)
                            }
                        }
                    )
                }.padding(.horizontal, 20)
            }
        }.background(.backgroundTheme)
            .ignoresSafeArea(.keyboard)
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: {
                        router.authNavigateBack()
                    })
                }
            }
    }
}

#Preview {
    JoinGroupView()
}
