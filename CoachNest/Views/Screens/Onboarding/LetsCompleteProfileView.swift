//
//  LetsCompleteProfileView.swift
//  CoachNest
//
//  Created by ios on 20/12/24.
//

import SwiftUI

struct LetsCompleteProfileView: View {
    //MARK: - @State variables
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var mobileNumber = ""
    @State private var emergencyContact = ""
    @State private var emergencyContactNumber = ""
    @State private var allergies = ""
    @State private var anyInjury = ""
    
    //MARK: - View Modifiers -
    @FocusState private var focusedField: Field?
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
                        CustomTextField(title: Constants.TextField.Title.firstName,
                                        placeholder: Constants.TextField.Placeholder.firstName,
                                        text: $firstName,
                                        buttonType: .next,
                                        onSubmit: {
                            focusedField = .lastName
                                        })
                        .focused($focusedField, equals: .firstName)
                        
                        CustomTextField(title: Constants.TextField.Title.lastName,
                                        placeholder: Constants.TextField.Placeholder.lastName,
                                        text: $lastName,
                                        buttonType: .next,
                                        onSubmit: {
                            focusedField = .emergencyContact
                                        })
                        .focused($focusedField, equals: .lastName)
                        
                        CustomTextField(title: Constants.TextField.Title.mobileNumber,
                                        placeholder: Constants.TextField.Placeholder.mobileNumber,
                                        text: $mobileNumber,
                                        buttonType: .next,
                                        keyboardType: .numberPad,
                                        onSubmit: {
                            focusedField = .emergencyContact
                                        })
                        .focused($focusedField, equals: .mobileNumber)
                        
                        CustomTextField(title: Constants.TextField.Title.emergencyContact,
                                        placeholder: Constants.TextField.Placeholder.emergencyContact,
                                        text: $emergencyContact,
                                        buttonType: .next,
                                        onSubmit: {
                            focusedField = .emergencyContactNumber
                            print("Final field submitted")
                        })
                        .focused($focusedField, equals: .emergencyContact)
                        
                        CustomTextField(title: Constants.TextField.Title.emergencyMobileNumber,
                                        placeholder: Constants.TextField.Placeholder.emergencyMobileNumber,
                                        text: $emergencyContact,
                                        buttonType: .next,
                                        keyboardType: .numberPad,
                                        onSubmit: {
                            focusedField = .emergencyContactNumber
                            print("Final field submitted")
                        })
                        .focused($focusedField, equals: .emergencyContact)
                        
                        CustomTextField(title: Constants.TextField.Title.allergies,
                                        placeholder: Constants.TextField.Placeholder.allergies,
                                        text: $emergencyContactNumber,
                                        buttonType: .next,
                                        onSubmit: {
                            focusedField = .anyInjury
                            print("Final field submitted")
                        })
                        .focused($focusedField, equals: .allergies)
                        
                        
                        CustomTextField(title: Constants.TextField.Title.anyInjury,
                                        placeholder: Constants.TextField.Placeholder.anyInjuries,
                                        text: $emergencyContact,
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
                                router.navigate(to: .enrollmentType)
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
