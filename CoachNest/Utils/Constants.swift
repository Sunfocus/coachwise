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
    
    // MARK: - Create New Password View
    struct CreateNewPasswordViewTitle {
        static let createNewPassword = "Create New Password"
        static let enterNewPasswordMessage = "Enter a new password, not less than 8 characters and not be your previous password"
        static let submit =  "Submit"
    }
    
    // MARK: - EnrollmentTypeView
    struct EnrollmentTypeViewTitle {
        static let getStarted = "Let’s get started!"
        static let type1 = "I am a coach / teacher who wants to manage my classes, events and students  effectively"
        static let type2 = "I am a parent / guardian who has been invited to join CoachNest"
        static let type3 = "I am a member / customer enrolled in a class and invited to join CoachNest"
        static let next = "Next"
    }
    
    struct JoiningEntryViewTitle {
        static let joiningAsClubOrSchool = "Your club/school"
        static let joinExistingClub = "Join existing club or school"
        static let inviteCode = "You will require an invite code to join."
        static let createNewClub = "Create new club or school"
        static let headCoachOfClub = "You will be the head coach of your club/School. You will be able to invite others."
        static let next = "Next"
    }
    
    struct BusinessNameViewTitle {
        static let whatIsBusinessName = "What is the name of your business ?"
        static let recognizeBusinessMessage = "This could be your club name, school name, or anything else that will help your members recognize your business."
        static let exampleBusinessName = "Eg: “Melbourne Tennis Club” "
    }
    
    struct AgeGroupViewTitle {
        static let whatAgeGroup = "What age groups do you work with?"
        static let mixed = "Mixed"
        static let mixedAgeMembers = "Members are of all ages with or without registered parents/guardians"
        static let childrenOrYouth = "Children/Youth"
        static let childrenAgeMembers = "Members are up to 17 years and parents/guardians are involved"
        static let adults = "Adults"
        static let adultsAgeMembers = "Members are all aged 18 and over"
    }
    
    struct BringContactsViewTitle {
        static let letsBringInContacts = "Awesome! \n Let’s bring in your contacts"
        static let addMemberCoaches = "Add new contacts"
        static let addMemberCoachesSubheading = "Add your members and coaches"
        static let importContactList = "Import contact list"
        static let importContactListSubheading = "Bring in your contact list from CSV file."
        static let shareLink = "Share link"
        static let shareLinkSubheading = "Invite your members and coaches via link"
    }
    
    
    
    struct BusinessActivityViewTitle {
        static let businessActivity = "What activity does your business engage in?"
        
        struct ActivityType {
            static let athletics = "Athletics"
            static let afl = "AFL"
            static let badminton = "Badminton"
            static let baseball = "Baseball"
            static let basketball = "Basketball"
            static let cricket = "Cricket"
            static let cycling = "Cycling"
            static let dancing = "Dancing"
            static let esports = "Esports"
            static let football = "Football"
            static let golf = "Golf"
            static let gymnastics = "Gymnastics"
            static let hockey = "Hockey"
            static let martialArts = "Martial Arts"
            static let netball = "Netball"
            static let rugby = "Rugby"
            static let singing = "Singing"
            static let swimming = "Swimming"
            static let tennis = "Tennis"
            static let volleyball = "Volleyball"
            static let volunteering = "Volunteering"
        }
    }
    
    struct TextField {
        struct Title {
            static let firstName = "First Name"
            static let lastName = "Last Name"
            static let email = "Email Address"
            static let password = "Password"
            static let confirmPassword = "Confirm Password"
            static let yourBusinesName = "Your business name"
        }
        
        struct Placeholder {
            static let firstName = "Enter first name"
            static let lastName = "Enter last name"
            static let email = "Enter email address"
            static let password = "Enter password"
            static let confirmPassword = "Confirm Password"
            static let yourBusinesName = "Enter business name"
        }
    }
}

