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
    
    // MARK: - Join or Create Club View
    struct JoiningEntryViewTitle {
        static let joiningAsClubOrSchool = "Your club/school"
        static let joinExistingClub = "Join existing club or school"
        static let inviteCode = "You will require an invite code to join."
        static let createNewClub = "Create new club or school"
        static let headCoachOfClub = "You will be the head coach of your club/School. You will be able to invite others."
        static let next = "Next"
       
    }
    
    // MARK: - Date of Birth View
    struct DateOfBirthView {
        static let enterDob = "Enter you date of birth"
        static let dobMessage = "This will allow us to provide better privacy controls and ensure safety of your data."
        static let dob = "Date of Birth"
        static let next = "Next"
    }
    
    // MARK: - BusinessName View
    struct BusinessNameViewTitle {
        static let whatIsBusinessName = "What is the name of your business ?"
        static let recognizeBusinessMessage = "This could be your club name, school name, or anything else that will help your members recognize your business."
        static let exampleBusinessName = "Eg: “Melbourne Tennis Club” "
    }
    
    // MARK: - AgeGroupView
    struct AgeGroupViewTitle {
        static let whatAgeGroup = "What age groups do you work with?"
        static let mixed = "Mixed"
        static let mixedAgeMembers = "Members are of all ages with or without registered parents/guardians"
        static let childrenOrYouth = "Children/Youth"
        static let childrenAgeMembers = "Members are up to 17 years and parents/guardians are involved"
        static let adults = "Adults"
        static let adultsAgeMembers = "Members are all aged 18 and over"
    }
    
    // MARK: - BringContactsView
    struct BringContactsViewTitle {
        static let letsBringInContacts = "Awesome! \nLet’s bring in your contacts"
        static let addMemberCoaches = "Add new contacts"
        static let addMemberCoachesSubheading = "Add your members and coaches"
        static let importContactList = "Import contact list"
        static let importContactListSubheading = "Bring in your contact list from CSV file."
        static let shareLink = "Share link"
        static let shareLinkSubheading = "Invite your members and coaches via link"
        static let skipForNow = "Skip for now, I’ll do this later"
        static let skip = "Skip"
        static let done = "Done"
    }
    
    // MARK: - LetsCompleteProfile
    struct LetsCompleteProfile {
        static let letsCompleteProfile = "Let’s complete your profile!"
        static let skip = "Skip"
        static let done = "Done"
    }
    
    // MARK: - JoinGroupViewTitle
    struct JoinGroupViewTitle {
        static let joinGroup = "Join your group!"
        static let joinGroupInstructionMessage = "Click the link in your email invite or paste the team code below that was shared in that email."
        static let exampleId = "Eg: “1pdsh2134”"
        static let join = "Join"
        static let almostThere = "Almost there!"
        static let registerUsingTheSameLink = "Please register using the same email address to get started!"
    }
    
    // MARK: - JoinGroupViewTitle
    struct AddYourGoalsViewTitle {
        static let noGoals = "No Goals"
        static let addGoal = "Add Goal"
        static let editGoal = "Edit Goal"
        static let tapAdd = "Tap \"+\" to add your first goal."
        static let exampleId = "Eg: “1pdsh2134”"
    }
    
    // MARK: - AddScheduleEventViewTitle
    struct AddScheduleEventViewTitle {
        static let noSchedule = "No Schedule"
        static let tapAdd = "Tap \"+\" to add your first event."
        static let addEvent = "Add Event"
        static let eventName = "Event Name"
        static let eventType = "Event Type"
        static let recurrance = "Recurrance"
        static let on = "On"
        static let startTime = "Start time"
        static let endTime = "End time"
        static let from = "From"
        static let to = "To"
        static let venue = "Venue"
        static let locationDetails = "Location Details"
        static let memberLimit = "Member Limit"
        static let coaches = "Coaches"
        static let runsEvery = "Runs every"
    }
    
    // MARK: - AddVenueViewTitle
    struct AddVenueViewTitle{
        static let addVenue = "Add Venue"
        static let venueName = "Venue Name"
        static let address = "Address"
        static let meetingName = "Meeting Name"
        static let onlineLink = "Online Link"
        static let manageVenues = "Manage Venues"
        
    }
    
    // MARK: - AddEventTypeViewTitle
    struct AddEventTypeViewTitle{
        static let addEventType = "Add Event Type"
        static let eventType = "Event Type"
        static let plusEventType = "+ Event Type"
        static let clickToUploadDoc = "Click to Upload Document"
    }
    
    
    
    
    
    // MARK: - No Messages Available
    struct AddYourMessageViewTitle {
        static let noMessage = "It’s quiet in here..."
        static let startConversation = "Start your first conversation!"
        static let editGoal = "Edit Goal"
        static let tapAdd = "Tap \"+\" to add your first goal."
        static let exampleId = "Eg: “1pdsh2134”"
    }
    
    // MARK: - AddMembersViewTitle
    struct AddMemberViewTitle {
        static let addMember = "Add Member"
        static let next = "Next"
        static let done = "Done"
        static let search = "Search"
    }
    
    // MARK: - GoalInfoViewTitle
    struct GoalInfoViewTitle {
        static let goalName = "Goal name"
        static let description = "Description"
        static let reminder = "Reminder"
        static let goalStatus = "Goal Status"
        static let working = "Working on it"
        static let completed = "Completed"
        static let dueOn = "Due on"
        static let goalFor = "Goal for"
        static let goalFrom = "Goal from"
        static let markAsComplete = "Mark as complete!"
        
    }
    
    
    // MARK: - AddActionViewTitle
    struct AddActionViewTitle {
        static let addNewAction = "Add new action"
        static let uploadDocs = "Upload"
        static let actionTitle = "Action title"
        static let dueDate = "Due date"
        static let members = "Members"
        static let uploadPhotoVideo = "Upload photo videos or documents"
        static let maxSizeLimit = "(Max. File size: 25 MB)"
        static let addAction = "Add action"
        static let status = "Status"
    }
    
    // MARK: - BusinessActivity View
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
            static let enterTeamIdFromLink = "Enter Team ID in your invite link"
            static let mobileNumber = "Mobile No."
            static let emergencyContact = "Emergency Contact Name"
            static let emergencyMobileNumber = "Emergency Mobile No."
            static let allergies = "Allergies"
            static let anyInjury = "Any Injuries"
            static let goal = "Goal"
            static let whoIsThisGoalFor = "Who is this goal for?"
            static let recipients = "Recipients"
            static let selectedRecipients = "(This will send a push notification to the selected recipients)"
            static let description = "Description"
            static let message = "Message"
            static let dueOn = "Due on"
            static let reminder = "Reminder"
            static let addCoach = "Add Coach"
            
        }
        
        struct Placeholder {
            static let firstName = "Enter first name"
            static let lastName = "Enter last name"
            static let email = "Enter email address"
            static let password = "Enter password"
            static let confirmPassword = "Confirm Password"
            static let yourBusinesName = "Enter business name"
            static let mobileNumber = "Enter mobile no."
            static let emergencyContact = "Enter emergency contact name"
            static let emergencyMobileNumber = "Enter emergency contact no."
            static let allergies = "Enter your allergies"
            static let anyInjuries = "Enter your injuries"
            static let enterTeamId = "Enter Team ID"
            static let goalName = "Enter goal name"
            static let addNotesHere = "Add your notes here!"
            static let acionTitle = "Enter action title"
            static let actionDescription = "Briefly describe the action"
            static let goalDescription = "Briefly describe the goal"
            static let writeMessage = "Write your message here"
            //Add event
            static let eventType = "Select event type"
            static let venueType = "Select venue"
            static let eventName = "Enter event name"
            static let selectNumber = "Select Number"
            static let locationDetails = "Enter nearby landmarks"
            
        }
    }
    
    static let applyFilter = "Apply Filter"
    static let addSchedule = "Add Schedule"
    static let addVenue = "Add Venue"
    static let notifications = "Notifications"
    static let coachNotification = "Coach Notification"
    static let save = "Save"
    
    static let filterOptions = [
            RadioButtonOption(title: "All (default)"),
            RadioButtonOption(title: "Goals assigned to me"),
            RadioButtonOption(title: "Goals assigned by me")
        ]
    
    static let chatContactFilterOptions = [
        RadioButtonOption(title: "All (default)"),
        RadioButtonOption(title: "Individual"),
        RadioButtonOption(title: "Group"),
        RadioButtonOption(title: "Admin"),
        RadioButtonOption(title: "Coach"),
        RadioButtonOption(title: "Student"),
        RadioButtonOption(title: "Parent")
    ]
}

