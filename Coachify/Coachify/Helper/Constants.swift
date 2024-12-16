//
//  Constant.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 13/12/24.
//

import Foundation

struct Constants {
    
    struct SignUpViewTitle {
        static let createAccount = "Create an Account"
        static let joinUs = "Join us and unlock endless possibilities."
        static let agreeTo = "I agree to the "
        static let termsOfService = "Terms of Service"
        static let and = " and "
        static let privacyPolicy = "Privacy Policy"
        static let signUpButtonText = "Sign up for free!"
        static let or = "Or"
        static let alreadyHaveAnAccount = "Already have an account?"
        static let logIn = "Login"
    }
    
    struct LogInViewTitle {
        static let welcomeBack = "Hey Welcome back"
        static let logInContinue = "Log in to continue managing your tasks effortlessly."
        static let forgotPassword = "Forgot Password?"
        static let dontHaveAccount = "Don't have an account with us?"
        static let signUp = "Sign up"
    }
    
    //MARK: - Forgot Passsword View
        struct ForgotPasswordViewTitle {
            static let forgotPassword = "Forgot Password"
            static let subheading = "Please enter your email address to reset your password."
            static let otpToVerify = "Enter your email address and we'll email you a OTP to verify the email address"
            static let sendOtp =  "Send OTP"
        }
    
    //MARK: - Email Verification View
    struct EmailVerificationTitle {
        static let emailVerification = "Email Verification"
        static let subheading = "Please Enter The 4 Digit Code Sent To bill.sanders@example.com"
        static let resendOtp = "Resend Otp"
        static let verify = "Verify"
        
    }
    
    struct TextField {
        struct Title {
            static let firstName = "First Name"
            static let lastName = "Last Name"
            static let email = "Email Address"
            static let password = "Password"
        }
        
        struct Placeholder {
            static let firstName = "Enter first name"
            static let lastName = "Enter last name"
            static let email = "Enter email address"
            static let password = "Enter password"
        }
    }
}

