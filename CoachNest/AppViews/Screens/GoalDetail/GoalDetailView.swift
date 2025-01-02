import SwiftUI
import PhotosUI

struct GoalDetailView: View {
    
    //MARK: - Variables -
    @State private var description: String = ""
    @State private var images: [UIImage] = []
    @State private var photosPickerItems: [PhotosPickerItem] = []
    @State private var selectedSegment = 0
    @State private var goal: GoalDetails?
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var router: Router
    @EnvironmentObject var addGoalViewModel: AddGoalViewModel
    @EnvironmentObject var addActionViewModel: AddActionViewModel
    var goalId: UUID
    var member: MemberDetail
    var buttonTitle: String{
        switch selectedSegment{
        case 0:
            Constants.GoalInfoViewTitle.markAsComplete
        case 1:
            Constants.AddActionViewTitle.addNewAction
        case 2:
            Constants.AddActionViewTitle.uploadDocs
        default:
            Constants.GoalInfoViewTitle.markAsComplete
        }
    }
   


    var body: some View {
        
        ZStack{
            //Background Color
            if colorScheme != .dark{
                Color.lightGrey
                    .ignoresSafeArea()
            }
            VStack{
                topNavView
                pickerView
                    VStack{
                        switch selectedSegment{
                        case 0:
                            goalInfoView
                        case 1:
                            if addActionViewModel.actions.isEmpty{
                                emptyActionView
                            }else{
                                toDoListView
                            }
                        case 2:
                            feedbackListView
                        default:
                            EmptyView()
                        }
                    }
                    .padding()
                .safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                .scrollIndicators(.hidden)
                // MARK: - Login Button
                VStack{
                    CustomButton(
                        title: buttonTitle ,
                        action: {
                            switch selectedSegment{
                            case 0:
                                router.dashboardNavigateBack()
                            case 1:
                                router.navigate(to: .addNewAction(member: member, goalId: goalId))
                            case 2:
                                router.dashboardNavigateBack()
                            default:
                                router.dashboardNavigateBack()
                            }
                        }
                    )
                }
                .padding([.horizontal])
            }
        }.navigationBarBackButtonHidden()
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
            .onAppear{
            goal = addGoalViewModel.getGoal(byID: goalId)
        }
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
    }
    
    //MARK: - Subviews -
    private var pickerView: some View{
        VStack{
            Picker("Select Option", selection: $selectedSegment) {
                Text("Details").tag(0)
                Text("Action").tag(1)
                Text("Feedback").tag(2)
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
                        Text(goal?.goalTitle ?? "")
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
                            Text(goal?.goalTitle ?? "")
                                .customFont(.regular, 14)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer()
                        VStack{
                            Text("Working on it")
                                .customFont(.semiBold, 12)
                                .padding(6.5)
                                .background(.yellowAccent.opacity(0.3))
                                .foregroundStyle(.yellow)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                        }
                    }
                }
                
                //Goal From and Assigned to Section
                VStack(){
                    HStack(spacing: 20){
                        VStack(spacing: 5){
                            Text("Goal from")
                                .customFont(.semiBold, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack{
                                Image(uiImage: goal?.createdBy.profileImage ?? .sg1)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(.circle)
                                    .frame(width: 22, height: 22)
                                
                                Text(goal?.createdBy.name ?? "")
                                    .customFont(.regular, 14)
                                    .lineLimit(1)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                        }
                        Spacer()
                        VStack(spacing: 5){
                            
                            HStack{
                                Text("Goal to")
                                    .customFont(.semiBold, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            HStack{
                                Image(uiImage: member.profileImage ?? .sg1)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(.circle)
                                    .frame(width: 22, height: 22)
                                
                                Text(member.name)
                                    .customFont(.regular, 14)
                                    .lineLimit(1)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    Divider()
                }
                
                //Description Section
                VStack(alignment: .leading, spacing: 10){
                    Text(Constants.GoalInfoViewTitle.description)
                        .customFont(.semiBold, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text( goal?.description ?? "")
                        .customFont(.regular, 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                }
                
                //Due on, reminder, goal status section
                HStack{
                    VStack{
                        Text(Constants.GoalInfoViewTitle.dueOn)
                            .customFont(.semiBold,16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(goal?.dueOnDate.formattedDate(customFormat:"MMM dd, yyyy") ?? "")
                            .customFont(.regular, 14)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack{
                        Text(Constants.GoalInfoViewTitle.reminder)
                            .customFont(.semiBold,16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(goal?.reminder.rawValue ?? "")
                            .customFont(.regular, 14)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack{
                        Text(Constants.GoalInfoViewTitle.goalStatus)
                            .customFont(.semiBold,16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(Int((member.progress)))%")
                            .customFont(.regular, 14)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }.padding()
                .background(.darkGreyBackground)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .cornerRadius(12)
        }
    }
    private var emptyActionView: some View{
        VStack{
            Spacer()
            Image(.doubleTick)
                .resizable()
                .frame(width: 64, height: 64)
            Text("No Actions")
                .customFont(.medium, 16)
                .foregroundStyle(.primaryTheme)
            Text("You have no any actions in “To do” list !")
                .customFont(.regular, 14)
                .foregroundStyle(.primaryTheme)
            Spacer()
        }
    }
    private var toDoListView: some View{
        ScrollView{
            VStack{
                //add new To do Section
                let todoActions = addActionViewModel.getActions(by: .todo)
                let pendingActions = addActionViewModel.getActions(by: .inProgress)
                let completedActions = addActionViewModel.getActions(by: .completed)
                if !todoActions.isEmpty{
                    VStack(spacing: 7){
                        Text("To do")
                            .customFont(.semiBold, 18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(todoActions, id: \.self) { action in
                            ToDoCell(action: action)
                                .onTapGesture {
                                    router.navigate(to: .actionDetailView(actionId: action.id))
                                }
                        }
                    } .padding(.bottom)
                }
                
               
                //In progress Section
                if !pendingActions.isEmpty{
                    VStack(spacing: 7){
                        Text("Pending")
                            .customFont(.semiBold, 18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(pendingActions, id: \.self) { action in
                            ToDoCell(action: action)
                                .onTapGesture {
                                    router.navigate(to: .actionDetailView(actionId: action.id))
                                }
                        }
                    }
                    .padding(.bottom)
                }
                //Completed Section
                if !completedActions.isEmpty{
                    VStack(spacing: 7){
                        Text("Completed")
                            .customFont(.semiBold, 18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(completedActions, id: \.self) { action in
                            ToDoCell(action: action)
                                .onTapGesture {
                                    router.navigate(to: .actionDetailView(actionId: action.id))
                                }
                        }
                    }
                }
            }.shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .padding(.horizontal, 1)
        }
    }
    private var feedbackListView: some View{
        VStack{
            VStack(spacing: 30){
                //Description Section
                VStack(spacing: 6){
                    Text(Constants.TextField.Title.description)
                        .customFont(.regular, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack{
                        TextField(Constants.TextField.Placeholder.addNotesHere, text: $description, axis: .vertical)
                            .customFont(.regular, 14)
                            .tint(.primaryTheme)
                            .lineLimit(4, reservesSpace: true)
                            .textFieldStyle(.plain)
                    }
                    .padding()
                    .background(.darkGreyBackground)
                    .cornerRadius(8)
                }
                
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
            }
            
            
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
        }
    }
    
}

#Preview {
    GoalDetailView( goalId: UUID(), member: MemberDetail(id: 12, name: "dfgdg", profileImage: .sg1, accountType: .coach, progress: 32.0))
        .environmentObject(AddGoalViewModel())
        .environmentObject(AddActionViewModel())
        .environmentObject(Router())
}
