//
//  ActionDetailView.swift
//  CoachNest
//
//  Created by ios on 02/01/25.
//

import SwiftUI
import PhotosUI

struct ActionDetailView: View {
    
    //MARK: - Variables -
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var addActionViewModel: AddActionViewModel
    @State private var images: [UIImage] = []
    @State private var photosPickerItems: [PhotosPickerItem] = []
    @State private var status: StatusOption = .todo
    @State private var selectedSegment = 0
    @EnvironmentObject var router: Router
    var actionId: UUID
    @State private var action: AddAction?
    
    
    var body: some View {
        ZStack{
//            if colorScheme != .dark{
//                Color.lightGrey
//                    .ignoresSafeArea()
//            }
            
            VStack{
                topNavView
                pickerView
                VStack{
                    switch selectedSegment{
                    case 0:
                        goalInfoView
                    case 1:
                        attachmentsView
                    default:
                        EmptyView()
                    }
                    Spacer()
                }
                .padding()
                .safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                .scrollIndicators(.hidden)
                
                // MARK: - Add Goal Button
                CustomButton(
                    title: (Constants.AddActionViewTitle.addAction),
                    action: {
                        addActionViewModel.updateActionStatus(byId: actionId, status: status)
                        router.dashboardNavigateBack()
                    })
                .padding(.horizontal)
            }
        }.background(.backgroundTheme)
        .onAppear{
            action = addActionViewModel.getAction(byId: actionId)
            status = action?.status ?? .todo
            
            if let dataArray = action?.attachedImages {
                for data in dataArray {
                    if let image = UIImage(data: data) {
                        images.append(image)
                    }
                }
            }
        }
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
        .navigationBarBackButtonHidden()
    }
    
    //MARK: - Subviews -
    private var pickerView: some View{
        VStack{
            Picker("Select Option", selection: $selectedSegment) {
                Text("Details").tag(0)
                Text("Attachments").tag(1)
            }
            .pickerStyle(.segmented)
            .frame(height: 44)
        }
        .padding([.horizontal, .vertical])
    }
    private var topNavView: some View{
        VStack{
            HStack {
                Image(.arrowBack)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        //back button tapped
                        router.dashboardNavigateBack()
                    }
                Spacer()
                
                Image(.more)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        //more button tapped
                    }
                
                
            }.padding([.horizontal, .vertical], 15)
                .overlay {
                    HStack{
                        Text(action?.actionTitle ?? "Practice Backhand")
                            .customFont(.semiBold, 16)
                    }
                }
            Divider()
        }
        .background(.darkGreyBackground)
    }
    private var goalInfoView: some View{
        ScrollView{
            VStack(spacing: 30){
                //Goal Name and Status Section
                VStack{
                    HStack{
                        VStack{
                            Text("Goal name")
                                .customFont(.semiBold, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(action?.actionTitle ?? "Practice Backhand")
                                .customFont(.regular, 14)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer()
                    }
                }
                //Due data and assigned date
                VStack(){
                    HStack(spacing: 20){
                        VStack(spacing: 5){
                            Text("Due Date")
                                .customFont(.semiBold, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(action?.dueOnDate.formattedDate(customFormat:"MMM dd, yyyy") ?? "12 Dec, 24")
                                .customFont(.regular, 14)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer()
                        VStack(spacing: 5){
                            Text("Date assigned")
                                .customFont(.semiBold, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(action?.updatedDate.formattedDate(customFormat:"MMM dd, yyyy") ?? "12 Dec, 24")
                                .customFont(.regular, 14)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    Divider()
                }
                
                //Goal From and Assigned to Section
                VStack(){
                    HStack(spacing: 20){
                        VStack(spacing: 5){
                            Text("Created by")
                                .customFont(.semiBold, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack{
                                Image(uiImage: action?.assignedBy.profileImage ?? .sg1)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(.circle)
                                    .frame(width: 22, height: 22)
                                
                                Text(action?.assignedBy.name ?? "Kathy Murphy")
                                    .customFont(.regular, 14)
                                    .lineLimit(1)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                        }
                        Spacer()
                        VStack(spacing: 5){
                            HStack{
                                Text("Assigned to")
                                    .customFont(.semiBold, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            HStack{
                                Image(uiImage: action?.assignedTo.profileImage ?? .sg1)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(.circle)
                                    .frame(width: 22, height: 22)
                                
                                Text(action?.assignedTo.name ?? "Max Collins")
                                    .customFont(.regular, 14)
                                    .lineLimit(1)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    Divider()
                }
                
                //Status Section
                VStack(spacing: 5){
                    
                    //Status selection Section
                    VStack(spacing: 5){
                        
                        Text("Status")
                            .customFont(.semiBold, 16)
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
                        }//label End
                       
                    }
                    Divider()
                        .padding(.top)
                }
               
                
                
                //Description Section
                VStack(alignment: .leading, spacing: 10){
                    Text(Constants.GoalInfoViewTitle.description)
                        .customFont(.semiBold, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text( action?.description ?? "fsfsdfs sfsdf fdsfdsfsd fdsfsdf fdsfs dsfsdf fdsf dsfdsf dsfds fdsf")
                        .customFont(.regular, 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.padding()
                .background(.darkGreyBackground)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .cornerRadius(12)
        }
    }
    private var attachmentsView: some View {
        //Upload photo/video Section
        
        VStack{
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
//                                Image(.closeBtn) // Replace with your close button image name
//                                    .resizable()
//                                    .frame(width: 18, height: 18)
//                                    .offset(x: 44, y: -44)
//                                    .onTapGesture {
//                                        // Remove the tapped image from the array
//                                        images.remove(at: index)
//                                        HapticFeedbackHelper.lightImpact()
//                                    }
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
        }
        
        
    }
}

#Preview {
    ActionDetailView(actionId: UUID())
        .environmentObject(AddGoalViewModel())
        .environmentObject(AddActionViewModel())
}
