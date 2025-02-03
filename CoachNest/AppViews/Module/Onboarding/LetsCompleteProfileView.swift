//
//  LetsCompleteProfileView.swift
//  CoachNest
//
//  Created by ios on 20/12/24.
//

import SwiftUI

struct LetsCompleteProfileView: View {
    
    //MARK: - View Modifiers -
    @FocusState private var focusedField: Field?
    @StateObject private var letsCompleteProfileViewModel = LetsCompleteProfileViewModel()
    @EnvironmentObject var router: Router
    //MARK: - Variables -
    enum Field: Hashable {
        case mobileNumber, firstName, lastName, emergencyContact, emergencyContactNumber, allergies, anyInjury
    }
    
    var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    Image(.arrowBack)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            router.authNavigateBack()
                        }
                    Spacer()
                    
                    Text(Constants.LetsCompleteProfile.skip)
                        .customFont(.semiBold, 16)
                        .foregroundStyle(.pinkAccent)
                        .onTapGesture {
                            print("skip tapped")
                        }
                }.padding(.horizontal)
                
                
                Text(Constants.LetsCompleteProfile.letsCompleteProfile)
                    .customFont(.semiBold, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 20)
               
                Spacer()
                
                ScrollView {
                    VStack(spacing: 10) {
                        CustomTextField(field: $letsCompleteProfileViewModel.firstName,
                                        buttonType: .next,
                                        onSubmit: {
                            focusedField = .lastName
                                        })
                        .focused($focusedField, equals: .firstName)
                        .onChange(of: letsCompleteProfileViewModel.firstName.value) { oldValue, newValue in
                            letsCompleteProfileViewModel.validateFirstName()
                        }
                        
                        CustomTextField(field: $letsCompleteProfileViewModel.lastName,
                                        buttonType: .next,
                                        onSubmit: {
                            focusedField = .emergencyContact
                                        })
                        .focused($focusedField, equals: .lastName)
                        .onChange(of: letsCompleteProfileViewModel.lastName.value) { oldValue, newValue in
                            letsCompleteProfileViewModel.validateLastName()
                        }
                        
                        CustomTextField(field: $letsCompleteProfileViewModel.mobileNumber,
                                        buttonType: .next,
                                        keyboardType: .numberPad,
                                        onSubmit: {
                            focusedField = .emergencyContact
                                        })
                        .focused($focusedField, equals: .mobileNumber)
                        .onChange(of: letsCompleteProfileViewModel.mobileNumber.value) { oldValue, newValue in
                            letsCompleteProfileViewModel.validateMobileNumber()
                        }
                        
                        CustomTextField(field: $letsCompleteProfileViewModel.emergencyContactName,
                                        buttonType: .next,
                                        onSubmit: {
                            focusedField = .emergencyContactNumber
                            print("Final field submitted")
                        })
                        .focused($focusedField, equals: .emergencyContact)
                        .onChange(of: letsCompleteProfileViewModel.emergencyContactName.value) { oldValue, newValue in
                            letsCompleteProfileViewModel.validateFirstName()
                        }
                        
                        CustomTextField(field: $letsCompleteProfileViewModel.emergencyContactNumber,
                                        buttonType: .next,
                                        keyboardType: .numberPad,
                                        onSubmit: {
                            focusedField = .emergencyContactNumber
                            print("Final field submitted")
                        })
                        .focused($focusedField, equals: .emergencyContact)
                        .onChange(of: letsCompleteProfileViewModel.emergencyContactNumber.value) { oldValue, newValue in
                            letsCompleteProfileViewModel.validateFirstName()
                        }
                        
                        CustomTextField(field: $letsCompleteProfileViewModel.anyInjury,
                                        buttonType: .next,
                                        onSubmit: {
                            focusedField = .anyInjury
                            print("Final field submitted")
                        })
                        .focused($focusedField, equals: .allergies)
                        
                        
                        CustomTextField(field: $letsCompleteProfileViewModel.allergies,
                                        buttonType: .done,
                                        onSubmit: {
                            print("Final field submitted")
                        })
                        .focused($focusedField, equals: .anyInjury)
                    }.padding(.horizontal, 1)
                   
                    // MARK: - Sign Up Button
                    VStack{
                        CustomButton(
                            title: Constants.SignUpViewTitle.signUpButtonText,
                            action: {
                                HapticFeedbackHelper.mediumImpact()
                                print("On Tap SignUp")
                                router.setRoot(to: .dashboard)
                                router.isUserLoggedIn = true
                            }
                        )
                    }.padding(.top, 25)
                  
                }.scrollIndicators(.hidden)
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
        }.background(.backgroundTheme)
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
    }
}

#Preview {
    LetsCompleteProfileView()
}
