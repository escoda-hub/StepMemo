import SwiftUI
import RealmSwift

enum SamplePath:Hashable{
    case filterView(String)
    case stepView(Step)
}

@ViewBuilder
 func coordinator(_ samplePath: SamplePath) -> some View {
    switch samplePath {
    case let .filterView(text):
        StepListView_Condition(title:text)
    case let .stepView(stepData):
        StepView(stepData: stepData)
    }
}
struct ContentView: View {
    
    @State private var showingModal = false
    @State var searchText = ""
    @State var step :Step
    @State private var path: [SamplePath] = []
    
    let deviceWidth = UIScreen.main.bounds.width
    let height = 300.0
    
    init(step: Step = Step()) {
        self.step = Step()
    }
    
    var body: some View {
        
        NavigationStack(path: $path)  {
            ZStack {
                Color(0xDFDCE3, alpha: 1.0).ignoresSafeArea()
                VStack{
                    Spacer()
                    HStack{
                        Button(action: {
                            path.append(SamplePath.filterView("all"))
                        }){
                            VStack {
                                Spacer()
                                Image(systemName: "list.bullet")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                Spacer()
                                Text("全て")
                                    .font(.title3)
                                Spacer()
                            }
                        }
                        .navigationDestination(for: SamplePath.self) { samplePath in
                            coordinator(samplePath)
                        }
                        .padding()
                        .frame(width: 100,height:150,alignment:.center)
                        .background(Color(0x4ABDAC, alpha: 1))
                        .foregroundColor(.black)
                        .cornerRadius(CGFloat(15))
                        
                        Button(action: {
                            path.append(SamplePath.filterView("recent"))
                        }){
                            VStack {
                                Spacer()
                                Image(systemName: "calendar")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                Spacer()
                                Text("最近")
                                    .font(.title3)
                                Spacer()
                            }
                        }
                        .navigationDestination(for: SamplePath.self) { samplePath in
                            coordinator(samplePath)
                        }
                        .padding()
                        .frame(width: 100,height:150,alignment:.center)
                        .background(Color(0xFC4A1A, alpha: 0.8))
                        .foregroundColor(.black)
                        .cornerRadius(CGFloat(15))
                        
                        Button(action: {
                            path.append(SamplePath.filterView("heart"))
                        }){
                            VStack {
                                Spacer()
                                Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                Spacer()
                                Text("好き")
                                    .font(.title3)
                                Spacer()
                            }
                        }
                        .padding()
                        .navigationDestination(for: SamplePath.self) { samplePath in
                            coordinator(samplePath)
                        }
                        .frame(width: 100,height:150,alignment:.center)
                        .background(Color(0xF7B733, alpha: 0.9))
                        .foregroundColor(.black)
                        .cornerRadius(CGFloat(15))
                    }
                    .padding(.vertical)
                    .padding(.top)
                    ZStack {
                        List {
                            Section (
                                header: HStack{
                                    Image(systemName: "rectangle.3.group")
                                        .resizable()
                                        .frame(width:25,height:18)
                                    Text("Group")
                                        .font(.title)
                                }
                            )
                            {
                                if let groups = getGroup() {
                                    ForEach(groups, id: \.id) { group in
                                        NavigationLink(destination: StepListView(group: group,deviceWidth:deviceWidth,height: height)) {
                                            Text(group.name)
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
                                Spacer(minLength: 10)
                            }
                        }
                        .scrollDisabled(false)
                        .scrollContentBackground(.hidden)
                        .background(Color(0xDFDCE3, alpha: 1.0))
                        .padding(.horizontal)
                        .padding(.bottom)
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    let newStep = addStep(name: "-", deviceWidth: deviceWidth, height: height)
                                    path.append(SamplePath.stepView(newStep))
                                }){
                                    VStack {
                                        Image(systemName: "pencil")
                                            .foregroundColor(.white)
                                            .font(.system(size: 30))
                                    }
                                    .navigationDestination(for: SamplePath.self) { stepData in
                                        coordinator(stepData)
                                    }
                                    .frame(width: 60, height: 60)
                                    .background(Color.orange)
                                    .cornerRadius(30.0)
                                    .shadow(color: .gray, radius: 3, x: 3, y: 3)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
                                    
                                }
                            }
                        }//List + button
                        Button("deleteALL Button") {
                            print(Realm.Configuration.defaultConfiguration.fileURL!)
                            deleteAll()
                        }
                        .disabled(false)
                        Button("add stepdata Button") {
                            print(Realm.Configuration.defaultConfiguration.fileURL!)
                            setStepData()
                        }
                        .disabled(false)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){
                            HStack {
                                Image(systemName: "magnifyingglass") //検索アイコン
                                TextField("Search ...", text: $searchText)
                            }
                            .frame(width: deviceWidth - 100)
                            .background(Color(.systemGray6))
                            .cornerRadius(CGFloat(10))
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: InformationView()){
                                Image(systemName: "info.circle")
                                    .foregroundColor(.black)
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
                                .foregroundColor(.black)
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
                }//ZStack
            }//navigation stack
        }//body
    }//content view
}
