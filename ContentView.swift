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
    @State private var showingModal = false
    @State var searchText = ""
    @State var step :Step
    
    let deviceWidth = DisplayData.deviceWidth
    let height = DisplayData.height
    
    init(step: Step = Step()) {
        self.step = Step()
    }
    
    var body: some View {
        
        NavigationStack(path: $appEnvironment.path)  {
            ZStack {
                BackgroundColor_MainView.background.ignoresSafeArea()
                VStack{
                    HStack{
                        Button(action: {
                            appEnvironment.path.append(Route.filterView("all"))
                        }){
//                            VStack {
//                                Spacer()
//                                Image(systemName: "list.bullet")
//                                    .resizable()
//                                    .frame(width: 30,height: 30)
//                                Spacer()
//                                Text("全て")
//                                    .font(.title3)
//                                Spacer()
//                            }
//                            .padding()
//                            .contentShape(RoundedRectangle(cornerRadius: 0))
//                            .frame(width: 100,height:150,alignment:.center)
//                            .background(BackgroundColor_MainView.allBtn)
//                            .foregroundColor(.black)
//                            .cornerRadius(CGFloat(15))
                            VStack {
                                VStack {
                                    Image(systemName: "list.bullet")
                                        .foregroundColor(.black)
                                        .font(.system(size: 40))
                                }
                                .frame(width: 100, height: 100)
                                .background(BackgroundColor_MainView.allBtn)
                                .cornerRadius(50.0)
//                                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                Text("全て")
                                    .font(.callout)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Button(action: {
                            appEnvironment.path.append(Route.filterView("rescent"))
                        }){
//                            VStack {
//                                Spacer()
//                                Image(systemName: "calendar")
//                                    .resizable()
//                                    .frame(width: 30,height: 30)
//                                Spacer()
//                                Text("最近")
//                                    .font(.title3)
//                                Spacer()
//                            }
//                            .padding()
//                            .frame(width: 100,height:150,alignment:.center)
//                            .background(BackgroundColor_MainView.rescentBtn)
//                            .foregroundColor(.black)
//                            .cornerRadius(CGFloat(15))
//                            .contentShape(RoundedRectangle(cornerRadius: 0))
                            VStack {
                                VStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.black)
                                        .font(.system(size: 40))
                                }
                                .frame(width: 100, height: 100)
                                .background(BackgroundColor_MainView.rescentBtn)
                                .cornerRadius(50.0)
//                                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                Text("最近")
                                    .font(.callout)
                                    .foregroundColor(.white)
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
                                .background(BackgroundColor_MainView.favoriteBtn)
                                .cornerRadius(50.0)
//                                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                Text("好き")
                                    .font(.callout)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.vertical)
                    .padding(.top)
                    Spacer()

                    ZStack {
                        List {
                            Section (
                                header: HStack{
                                    Image(systemName: "rectangle.3.group")
                                        .resizable()
                                        .frame(width:25,height:18)
                                        .foregroundColor(.white)
                                    Text("Group")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            )
                            {
                                if let groups = getGroup() {
                                    ForEach(groups, id: \.id) { group in
                                        HStack{
                                            Button(action: {
                                                appEnvironment.path.append(Route.stepListView(group))
                                            }){
                                                VStack {
                                                    if group.name == "-" {
                                                        Text(group.name)
                                                            .foregroundColor(.white)
                                                    }else{
                                                        Text(group.name)
                                                            .foregroundColor(.white)
                                                            .swipeActions(edge: .trailing) {
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
                                                .foregroundColor(.white)
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(.white)
                                        }
                                        .listRowBackground(BackgroundColor_MainView.list)
                                    }
                                }
//                                Spacer(minLength: 10)
                            }
                        }
//                        .border(.white)
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
                                    VStack {
                                        Image(systemName: "pencil")
                                            .foregroundColor(.black)
                                            .font(.system(size: 30))
                                    }
                                    .frame(width: 60, height: 60)
                                    .background(BackgroundColor_MainView.createStepBtn)
                                    .cornerRadius(30.0)
//                                    .shadow(color: .gray, radius: 3, x: 3, y: 3)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0.0, trailing: 30.0))
                                }
                            }
                        }//List + button
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                            Button(action: {
                                appEnvironment.path.append(Route.informationView)
                            }){
                                VStack {
                                    Image(systemName: "info.circle")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                            Button(action: {
                                self.showingModal.toggle()
                            }) {
                                HStack{
                                    Image(systemName: "rectangle.3.group")
                                    Text("add group")
                                }
                                .foregroundColor(.white)
                            }.sheet(isPresented: $showingModal,onDismiss: {
                                //                                genre = getGroup()
                            }) {
                                EditGroupView()
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
                addGroup(groupname: defaultGroup)
            }
        }
    }//body
}//content view
