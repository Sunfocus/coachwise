//
//  SignupViewModel.swift
//  CoachNest
//
//  Created by ios on 23/12/24.
//

import SwiftUI

enum ValidationError: String {
    case emptyField = "This field cannot be empty."
    case emptyEmail = "Email cannot be empty."
    case emptyMobile = "Contact no cannot be empty."
    case invalidEmail = "Invalid email address."
    case weakPassword = "Password is too weak."
    case emptyPassword = "Password cannot be empty."
    case validPassword = "Password must include uppercase, lowercase, and a number."
    case emptyFirstName = "First name cannot be empty."
    case emptyLastName = "Last name cannot be empty."
    case invalidMobileNumber = "Invalid Contact number"
    case emptyTeamId = "Team Id cannot be empty"
}

struct Field {
    var title: String
    var placeholder: String
    var value: String = ""
    var error: ValidationError?
}

class SignupViewModel: ObservableObject {
    
    @Published var firstName = Field(
        title: Constants.TextField.Title.firstName,
        placeholder: Constants.TextField.Placeholder.firstName
    )
    @Published var lastName = Field(
        title: Constants.TextField.Title.lastName,
        placeholder: Constants.TextField.Placeholder.lastName
    )
    @Published var email = Field(
        title: Constants.TextField.Title.email,
        placeholder: Constants.TextField.Placeholder.email
    )
    @Published var password = Field(
        title: Constants.TextField.Title.password,
        placeholder: Constants.TextField.Placeholder.password
    )
   
    
    
    func isValidateForm() -> Bool {
        firstName.error = firstName.value.isEmpty ? .emptyFirstName : nil
        lastName.error = lastName.value.isEmpty ? .emptyLastName : nil
        email.error = email.value.isEmpty ? .emptyEmail : (ValidationUtils.isValidEmail(email.value) ? nil : .invalidEmail)
        password.error = password.value.isEmpty ? .emptyPassword : (ValidationUtils.isPasswordStrong(password.value) ? nil : .weakPassword)
        // Return true if all fields have no errors
        return [firstName.error, lastName.error, email.error, password.error].allSatisfy { $0 == nil }
    }

    
    func validateFirstName() {
        firstName.error = firstName.value.isEmpty ? .emptyFirstName : nil
    }
    
    func validateLastName() {
        lastName.error = lastName.value.isEmpty ? .emptyLastName : nil
    }
    
    func validateEmail() {
        if email.value.isEmpty {
            email.error = .emptyEmail
        } else if !ValidationUtils.isValidEmail(email.value) {
            email.error = .invalidEmail
        } else {
            email.error = nil
        }
    }
    
    func validatePassword() {
        if password.value.isEmpty {
            password.error = .emptyPassword
        } else if !ValidationUtils.isPasswordStrong(password.value) {
            password.error = .validPassword
        } else {
            password.error = nil
        }
    }
}
