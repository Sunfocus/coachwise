//
//  AddNewAction.swift
//  CoachNest
//
//  Created by ios on 31/12/24.
//

import SwiftUI
import PhotosUI

struct AddNewAction: View {
    
    //MARK: - Variables -
    @State private var actionTitle: String = ""
    @State private var description: String = ""
    @State private var errorCatchTitle: String = ""
    @State private var errorCatchMember: String = ""
    @State private var errorCatchDescription: String = ""
    @State private var dueDate = Date.now
    @State private var images: [UIImage] = []
    @State private var photosPickerItems: [PhotosPickerItem] = []
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var addActionViewModel: AddActionViewModel
    @State private var status: StatusOption = .todo
    @EnvironmentObject var router: Router
    var member: MemberDetail
    var goalId: UUID
    
    var body: some View {
        
        ZStack{
            
            
            VStack{
                // Heading and dismiss button section
                VStack{
                    HStack {
                        Image(.arrowBack)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                addActionViewModel.resetTitle()
                                router.dashboardNavigateBack()
                            }
                        Spacer()
                    }.padding([.horizontal, .vertical], 15)
                        .overlay {
                            HStack{
                                Text(Constants.AddActionViewTitle.addAction)
                                    .customFont(.medium, 16)
                            }
                        }
                    Divider()
                }
                .background(.darkGreyBackground)
                .padding( .bottom)
                
                ScrollView{
                    
                    VStack(spacing: 20){
                        
                        // Enter Action Name Section
                        VStack(spacing: 6){
                            Text(Constants.AddActionViewTitle.actionTitle)
                                .customFont(.regular, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField(Constants.TextField.Placeholder.acionTitle, text: $addActionViewModel.actionName)
                                .customFont(.regular, 14)
                                .frame(height: 48)
                                .padding(.horizontal)
                                .background(.darkGreyBackground)
                                .clipShape(.rect(cornerRadius: 8))
                                .tint(.black)
                            if !errorCatchTitle.isEmpty{
                                Text(errorCatchTitle)
                                    .customFont(.medium, 12)
                                    .foregroundStyle(.red)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        //Due date Section
                        VStack(spacing: 6){
                            Text(Constants.AddActionViewTitle.dueDate)
                                .customFont(.regular, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(){
                                Text("Select Date")
                                    .customFont(.regular, 16)
                                    .padding(.leading, 10)
                                    .foregroundStyle(Color.gray)
                                
                                Spacer()
                                DatePicker("", selection: $dueDate, in: Date()..., displayedComponents: .date)
                                    .tint(colorScheme == .dark ? .white : .primaryTheme)
                                    .labelsHidden()
                                    .padding(.trailing, 10)
                                
                                
                            }.frame(height: 55)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.darkGreyBackground)
                                .clipShape(.rect(cornerRadius: 8))
                            
                        }
                        
                        //Description Section
                        VStack(spacing: 6){
                            Text(Constants.TextField.Title.description)
                                .customFont(.regular, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            VStack{
                                TextField(Constants.TextField.Placeholder.actionDescription, text: $addActionViewModel.taskDescription, axis: .vertical)
                                    .customFont(.regular, 14)
                                    .tint(.primaryTheme)
                                    .lineLimit(4, reservesSpace: true)
                                    .textFieldStyle(.plain)
                            }
                            .padding()
                            .background(.darkGreyBackground)
                            .cornerRadius(8)
                            
                            if !errorCatchDescription.isEmpty{
                                Text(errorCatchDescription)
                                    .customFont(.medium, 12)
                                    .foregroundStyle(.red)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        //Status selection Section
                        VStack(spacing: 6){
                            
                            Text(Constants.AddActionViewTitle.status)
                                .customFont(.regular, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Menu {
                                ForEach(StatusOption.allCases, id: \.self) { option in
                                    Button(action: {
                                        status = option
                                    }) {
                                        Text(option.rawValue)
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(status.rawValue)
                                        .customFont(.regular, 16)
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 16))
                                        .tint(.gray)
                                }
                                .padding()
                                .frame(height: 50)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            }//labelEnd
                        }
                        .padding(.bottom)
                        
                        //Upload photo/video Section
                        PhotosPicker(
                            selection: $photosPickerItems,
                            maxSelectionCount: 5,
                            matching: .images
                        ) {
                            VStack {
                                Image(.documentUpload)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .padding(.bottom, 12)
                                
                                Text(Constants.AddActionViewTitle.uploadPhotoVideo)
                                    .customFont(.medium, 14)
                                    .foregroundStyle(.primaryTheme)
                                Text(Constants.AddActionViewTitle.maxSizeLimit)
                                    .customFont(.regular, 12)
                            }
                            .frame(height: 130)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                                    .stroke(
                                        style: StrokeStyle(
                                            lineWidth: 1.2,
                                            dash: [7]
                                        )
                                    )
                                    .foregroundColor(.gray)
                            )
                            .padding(.horizontal, 1)
                        }.shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 2) {
                                
                                ForEach(0..<images.count, id: \.self){ index in
                                    ZStack {
                                        ZStack {
                                            // Main image
                                            Image(uiImage: images[index])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 100, height: 100) // Adjust size as needed
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                            
                                            // Close button overlay
                                            Image(.closeBtn) // Replace with your close button image name
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                                .offset(x: 44, y: -44)
                                                .onTapGesture {
                                                    // Remove the tapped image from the array
                                                    images.remove(at: index)
                                                    HapticFeedbackHelper.lightImpact()
                                                }
                                        }
                                        .padding(8)
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.clear, lineWidth: 1)
                                        )
                                    }
                                    .padding(1)
                                }
                                
                            }
                        }.padding(.top)
                        Spacer()
                        
                      
                    }.padding(.horizontal)
                    Spacer()
                }.scrollIndicators(.hidden)
                    .safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                
                // MARK: - Add Goal Button
                CustomButton(
                    title: (Constants.AddActionViewTitle.addAction),
                    action: {
                        
                        if addActionViewModel.isValidateForm() {
                            print("Form is valid")
                            var imageData: [Data] = [] // Ensure the array is initialized

                            Task {
                                // Wait for all items to load their transferable data
                                for item in photosPickerItems {
                                    if let data = try? await item.loadTransferable(type: Data.self) {
                                        imageData.append(data)
                                    }
                                }

                                // After the task completes, use the imageData
                                addActionViewModel.addAction(
                                    action: AddAction(
                                        id: UUID(),
                                        goalId: goalId,
                                        actionTitle: addActionViewModel.actionName,
                                        updatedDate: Date(),
                                        dueOnDate: dueDate,
                                        assignedBy: MemberDetail(id: 007, name: "Rahul Pathania", profileImage: .sg1, accountType: .coach, progress: 0.0),
                                        assignedTo: member,
                                        description: addActionViewModel.taskDescription,
                                        status: status,
                                        attachedDocs: 1,
                                        attachedImages: imageData
                                    )
                                )
                            }

                            router.dashboardNavigateBack()
                        }
                        handleValidationErrors()
                    })
                .padding(.horizontal)
                
            }
        }.background(.backgroundTheme)
        .navigationBarBackButtonHidden()
        .onChange(of: photosPickerItems) { _, _ in
            Task{
                for item in photosPickerItems{
                    if let data = try? await item.loadTransferable(type: Data.self){
                        if let image = UIImage(data: data){
                            images.append(image)
                        }
                    }
                }
            }
        }
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
        
        
    }
    func handleValidationErrors() {
        errorCatchTitle = ""
        errorCatchDescription = ""
        errorCatchMember = ""
        addActionViewModel.getValidationErrors().forEach { error in
            switch error {
            case .emptyActionTitle:
                errorCatchTitle = error.localizedDescription
            case .emptyDescription:
                // Handle the error for empty description
                errorCatchDescription = error.localizedDescription
            }
        }
        
    }
    
}
    
    
   

#Preview {
    AddNewAction(member: MemberDetail(id: 01, name: "Max", profileImage: .sg1, accountType: .coach, progress: 12.6), goalId: UUID())
        .environmentObject(AddActionViewModel())
}
