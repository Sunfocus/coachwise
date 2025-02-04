//
//  EditProfile.swift
//  CoachNest
//
//  Created by Rahul Pathania on 31/01/25.
//

import SwiftUI

struct EditProfile: View {
    
    @StateObject var viewModel = EditProfileViewModel()
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
      
    var body: some View {
        ZStack{
            VStack{
                topHeaderView
                ScrollView{
                    personalDetails
                    emergencyContactView
                    medicalView
                    parent_GuardianView
                    CustomButton(
                        title: Constants.update,
                        action: {
                            dismiss()
                        }
                    ).padding([.horizontal, .bottom])
                }.scrollIndicators(.hidden)
            }
        } .background(.backgroundTheme)
    }
    
    
    //MARK: - Subviews
    var topHeaderView: some View{
        VStack{
            HStack {
                Image(.greyCloseButton)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        dismiss()
                        
                    }
                Spacer()
            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    HStack{
                        Text(Constants.ProfileViewTitle.editProfile)
                            .customFont(.medium, 18)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
        .padding( .bottom)
    }
    var personalDetails: some View{
        VStack{
            Text("Personal Details")
                .customFont(.medium , 22)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            LabelTextFieldView(title: "First Name", value: $viewModel.firstName, placeholder: "First Name")
            LabelTextFieldView(title: "Last Name", value: $viewModel.lastName, placeholder: "Last Name")
            selectDate
            LabelTextFieldView(title: "Phone", value: $viewModel.phone, placeholder: "Phone", keyboardType: .phonePad)
            LabelTextFieldView(title: "Email", value: $viewModel.email, placeholder: "Email", keyboardType: .emailAddress)
        }.padding(.horizontal)
    }
    var selectDate: some View{
        //Due date Section
        VStack(spacing: 6){
            Text(Constants.ProfileViewTitle.dateOfBirth)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(){
                Text("Select Date")
                    .customFont(.regular, 16)
                    .padding(.leading, 10)
                    .foregroundStyle(Color.gray)
                
                Spacer()
                DatePicker("", selection: $viewModel.dueDate, in: Date()..., displayedComponents: .date)
                    .tint(colorScheme == .dark ? .white : .primaryTheme)
                    .labelsHidden()
                    .padding(.trailing, 10)
                
                
            }.frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
            
        }
    }
    var emergencyContactView: some View{
        VStack{
            Text("Emergency Contact")
                .customFont(.medium , 22)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            LabelTextFieldView(title: "Emergency Contact", value: $viewModel.emergencyContact, placeholder: "Emergency Contact", keyboardType: .phonePad)
            LabelTextFieldView(title: "Relationship to Member", value: $viewModel.relationshipToMember, placeholder: "Relationship to Member")
            LabelTextFieldView(title: "Emergency Contact Mobile", value: $viewModel.emergencyContactMobile, placeholder: "Emergency Contact Mobile", keyboardType: .phonePad)
        }.padding(.horizontal)
    }
    var medicalView: some View{
        VStack{
            Text("Medical")
                .customFont(.medium , 22)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            LabelTextFieldView(title: "Allergies", value: $viewModel.allergies, placeholder: "Allergies", keyboardType: .alphabet)
            LabelTextFieldView(title: "Injuries", value: $viewModel.injuries, placeholder: "Injuries")
        }.padding(.horizontal)
    }
    var parent_GuardianView: some View{
        VStack(alignment: .leading, spacing: 10){
            
            HStack{
                Text(Constants.ProfileViewTitle.parent_Guardian)
                    .customFont(.medium, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button(action:{
                    // open contacts for adding parent or guardian
                })
                {
                    Text(Constants.ProfileViewTitle.addParent)
                        .customFont(.medium, 15)
                        .tint(.primaryTheme)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            
            
            VStack(alignment: .leading, spacing: 15){
               
                    ForEach(0..<1){ ind in
                            HStack{
                                Image(.f1)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 33 ,height: 33)
                                    .clipShape(.circle)
                                Text("Savver Mayer")
                                    .customFont(.medium, 16)
                                Spacer()
                                Image(.delete)
                                    .resizable()
                                    .frame(width: 28, height: 28)
                            }.frame(maxWidth: .infinity)
                        
                    }
            }.padding()
                .background(.darkGreyBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }.padding()
        
        //end
    }
}

#Preview {
    EditProfile()
}

//Reusable Views
struct LabelTextFieldView: View {
    
    var title: String
    @Binding var value: String
    var placeholder: String
    var keyboardType: UIKeyboardType = .alphabet
    
    
    var body: some View {
        VStack(spacing: 6){
            Text(title)
                .customFont(.regular, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(placeholder, text: $value)
                .customFont(.regular, 14)
                .frame(height: 48)
                .padding(.horizontal)
                .background(.darkGreyBackground)
                .clipShape(.rect(cornerRadius: 8))
                .tint(.primary)
                .keyboardType(keyboardType)
        }
    }
}
