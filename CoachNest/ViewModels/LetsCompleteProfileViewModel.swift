//
//  LetsCompleteProfileViewModel.swift
//  CoachNest
//
//  Created by ios on 23/12/24.
//

import Foundation


class LetsCompleteProfileViewModel: ObservableObject {
 
    @Published var firstName = Field(
        title: Constants.TextField.Title.firstName,
        placeholder: Constants.TextField.Placeholder.firstName
    )
    @Published var lastName = Field(
        title: Constants.TextField.Title.lastName,
        placeholder: Constants.TextField.Placeholder.lastName
    )
    @Published var mobileNumber = Field(
        title: Constants.TextField.Title.email,
        placeholder: Constants.TextField.Placeholder.email
    )
    @Published var emergencyContactName = Field(
        title: Constants.TextField.Title.password,
        placeholder: Constants.TextField.Placeholder.password
    )
    @Published var emergencyContactNumber = Field(
        title: Constants.TextField.Title.password,
        placeholder: Constants.TextField.Placeholder.password
    )
    @Published var allergies = Field(
        title: Constants.TextField.Title.password,
        placeholder: Constants.TextField.Placeholder.password
    )
    @Published var anyInjury = Field(
        title: Constants.TextField.Title.password,
        placeholder: Constants.TextField.Placeholder.password
    )
   
    
    
    func isValidateForm() -> Bool {
        firstName.error = firstName.value.isEmpty ? .emptyFirstName : nil
        lastName.error = lastName.value.isEmpty ? .emptyLastName : nil
        mobileNumber.error = mobileNumber.value.isEmpty ? .emptyMobile : nil
        emergencyContactName.error = emergencyContactName.value.isEmpty ? .emptyFirstName : nil
        emergencyContactNumber.error = emergencyContactNumber.value.isEmpty ? .emptyMobile : nil
        
        // Return true if all fields have no errors
        return [firstName.error, lastName.error, mobileNumber.error, emergencyContactName.error, emergencyContactName.error ].allSatisfy { $0 == nil }
    }
    
    func validateFirstName() {
        firstName.error = firstName.value.isEmpty ? .emptyFirstName : nil
    }
    
    func validateLastName() {
        lastName.error = lastName.value.isEmpty ? .emptyLastName : nil
    }
    
    func validateMobileNumber() {
        mobileNumber.error = mobileNumber.value.isEmpty ? .emptyMobile : nil
    }
}
