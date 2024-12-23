//
//  LoginViewModel.swift
//  CoachNest
//
//  Created by ios on 23/12/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email = Field(
        title: Constants.TextField.Title.email,
        placeholder: Constants.TextField.Placeholder.email
    )
    @Published var password = Field(
        title: Constants.TextField.Title.password,
        placeholder: Constants.TextField.Placeholder.password
    )
    
    func isValidateForm() -> Bool {
        email.error = email.value.isEmpty ? .emptyEmail : (ValidationUtils.isValidEmail(email.value) ? nil : .invalidEmail)
        password.error = password.value.isEmpty ? .emptyPassword : (ValidationUtils.isPasswordStrong(password.value) ? nil : .weakPassword)
        // Return true if all fields have no errors
        return [email.error, password.error].allSatisfy { $0 == nil }
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

