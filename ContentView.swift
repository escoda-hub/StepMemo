import SwiftUI
import RealmSwift

@ViewBuilder
 func coordinator(_ route: Route) -> some View {
    switch route {
        case let .filterView(text):
            StepListView_Condition(title:text)
        case let .stepView(stepData):
            StepView(stepData: stepData)
        case let .informationView:
            InformationView()
        case let .walkthroughView:
            WalkthroughView()
        case let .stepListView(group):
            StepListView(group:group)
        case let .mainView:
            ContentView()
        case let .termsOfServiceView:
            TermsOfServiceView()
        case let .termsOfServiceView:
            TermsOfServiceView()
        case let .privacyPolicyView:
            PrivacyPolicyView()
        case let .noticeView:
            NoticeView()
    }
}

struct ContentView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var searchText = ""
    @State  private var isDarkMode = true
    @State var showGroupAddView = false
    
    let deviceWidth = DisplayData.deviceWidth
    let height = DisplayData.height

    var body: some View {
        
        NavigationStack(path: $appEnvironment.path)  {
            ZStack {
                ComponentColor.background_dark.ignoresSafeArea()
                    .opacity(isDarkMode ? 1 : 0)
                ComponentColor.background_light.ignoresSafeArea()
                    .opacity(isDarkMode ? 0 : 1)
                VStack{
//                    Text(colorScheme == .dark ? "Dark" : "Light")
                    HStack{
                        Button(action: {
                            appEnvironment.path.append(Route.filterView("all"))
                        }){
                            VStack {
                                VStack {
                                    Image(systemName: "list.bullet")
                                        .foregroundColor(.black)
                                        .font(.system(size: 40))
                                }
                                .frame(width: 100, height: 100)
                                .background(ComponentColor.allBtn)
                                .cornerRadius(50.0)
//                                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                Text("全て")
                                    .font(.callout)
                                    .foregroundColor(isDarkMode ? .white : .black)
                            }
                        }
                        
                        Button(action: {
                            appEnvironment.path.append(Route.filterView("rescent"))
                        }){
                            VStack {
                                VStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.black)
                                        .font(.system(size: 40))
                                }
                                .frame(width: 100, height: 100)
                                .background(ComponentColor.rescentBtn)
                                .cornerRadius(50.0)
//                                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                Text("最近")
                                    .font(.callout)
                                    .foregroundColor(isDarkMode ? .white : .black)
                            }
                        }

                        Button(action: {
                            appEnvironment.path.append(Route.filterView("favorite"))
                        }){
                            VStack {
                                VStack {
                                    Image(systemName: "heart")
                                        .foregroundColor(.black)
                                        .font(.system(size: 40))
                                }
                                .frame(width: 100, height: 100)
                                .background(ComponentColor.favoriteBtn)
                                .cornerRadius(50.0)
//                                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                Text("好き")
                                    .font(.callout)
                                    .foregroundColor(isDarkMode ? .white : .black)
                            }
                        }
                    }
                    .padding(.vertical)
                    .padding(.top)
                    Spacer()

                    ZStack {
                        List {
                            Section (
                                header:
                                    HStack{
                                        Spacer()
                                        Image(systemName: "rectangle.3.group")
                                            .resizable()
                                            .frame(width:20,height:15)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                        Text("Group")
                                            .font(.title3)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                        Spacer()
                                    }
                            )
                            {
                                if let groups = getGroup() { //Results<Group>
                                    ForEach(groups.freeze(), id: \.id) { group in
                                        HStack{
                                            Button(action: {
                                                appEnvironment.path.append(Route.stepListView(group))
                                            }){
                                                VStack {
                                                    if group.name == "-" {
                                                        Text(group.name)
                                                            .foregroundColor(isDarkMode ? .white : .black)
                                                    }else{
                                                        Text(group.name)
                                                            .foregroundColor(isDarkMode ? .white : .black)
                                                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                                Button(role: .destructive) {
                                                                    deleteGroup(groupName: group.name)
                                                                } label: {
                                                                    Image(systemName: "trash.fill")
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                            Spacer()
                                            Text("\(group.steps.count)")
                                                .foregroundColor(.gray)
                                                .font(.subheadline)
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(isDarkMode ? .white : .black)
                                        }
                                        .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                                        .frame(height: 20)
                                    }
                                    .listRowSeparatorTint(isDarkMode ? .white : .gray)
                                    Spacer(minLength: 10)
                                        .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                                }
                            }
                        }
                        .scrollDisabled(false)
                        .scrollContentBackground(.hidden)
                        .padding(.horizontal)
                        .padding(.bottom)
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    let newStep = addStep(name: "-", deviceWidth: deviceWidth, height: height)
                                    appEnvironment.path.append(Route.stepView(newStep))
                                }){
//                                    BtnCreate(isDarkMode: isDarkMode, size: 30)
                                    VStack {
                                        Image(systemName: "pencil.tip")
                                            .foregroundColor(isDarkMode ? .black : .white)
                                            .font(.system(size: CGFloat(30)))
                                    }
                                    .frame(width: CGFloat(30) * 2, height: CGFloat(30) * 2)
                                    .background(isDarkMode ? ComponentColor.createStepBtn_dark :  ComponentColor.createStepBtn_light)
                                    .cornerRadius(CGFloat(30))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0.0, trailing: 30.0))
                                }
                            }
                        }//List + button
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                isDarkMode.toggle()
                                appEnvironment.isDark = isDarkMode
                            }){
                                VStack {
                                    Image(systemName: isDarkMode ?  "sun.min":"moon")
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                appEnvironment.path.append(Route.informationView)
                            }){
                                VStack {
                                    Image(systemName: "info.circle")
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                            }
                        }
                        ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                            HStack{
                                Image(systemName: "plus.circle")
                                Text("グループを追加")
                            }
                            .foregroundColor(isDarkMode ? .white : .black)
                            .onTapGesture {
                                showGroupAddView = true
                            }
                            .sheet(isPresented: $showGroupAddView) {
                                EditGroupView(showGroupAddView: $showGroupAddView)
                                    .presentationDetents([.medium])
                            }
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Spacer()
                        }
                    }//Vstack
                    Button("deleteALL Button") {
                        print(Realm.Configuration.defaultConfiguration.fileURL!)
                        deleteAll()
                    }
                    .disabled(false)
                    .opacity(system.env == "local" ? 1 : 0)
                    Button("add stepdata Button") {
                        print(Realm.Configuration.defaultConfiguration.fileURL!)
                        setStepData()
                    }
                    .disabled(false)
                    .opacity(system.env == "local" ? 1 : 0)
                }
            }//ZStack
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Route.self) { route in
                coordinator(route)
            }
        }//navigation stack
        .environmentObject(appEnvironment)
        .onAppear(){
            let defaultGroup = DBsetting.defautlGrouup
            if !checkGroup(groupname: defaultGroup) {
                addNewGroupIfNeeded(groupName: defaultGroup)
            }
            appEnvironment.isDark = isDarkMode
        }
    }//body
}//content view
