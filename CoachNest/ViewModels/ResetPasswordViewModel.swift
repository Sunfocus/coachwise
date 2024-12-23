//
//  ResetPasswordViewModel.swift
//  CoachNest
//
//  Created by ios on 23/12/24.
//

import Foundation

class ResetPasswordViewModel: ObservableObject {
    
    @Published var password = Field(
        title: Constants.TextField.Title.password,
        placeholder: Constants.TextField.Placeholder.password
    )
    @Published var confirmPassword = Field(
        title: Constants.TextField.Title.password,
        placeholder: Constants.TextField.Placeholder.password
    )
   
    
    
    func isValidateForm() -> Bool {
        password.error = password.value.isEmpty ? .emptyPassword : (ValidationUtils.isPasswordStrong(password.value) ? nil : .weakPassword)
        confirmPassword.error = confirmPassword.value.isEmpty ? .emptyPassword : (ValidationUtils.isPasswordStrong(confirmPassword.value) ? nil : .weakPassword)
        // Return true if all fields have no errors
        return [ password.error, confirmPassword.error].allSatisfy { $0 == nil }
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
    
    func validateConfirmPassword() {
        if confirmPassword.value.isEmpty {
            confirmPassword.error = .emptyPassword
        } else if !ValidationUtils.isPasswordStrong(password.value) {
            confirmPassword.error = .validPassword
        } else {
            confirmPassword.error = nil
        }
    }
}
