
import SwiftUI

struct StepListView: View {

    @State var group: Group
    @ObservedObject var steps: StepListViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var step: Step
    @State var isStepDataActive = false
    @State var isPresented = false
    @State  private var isDarkMode = true

    init(group: Group,step:Step = Step()) {
        self.group = group
        self.steps = StepListViewModel(groupName:group.name,groupId: group.id)
        self.step = step
        steps.groupName = group.name
        steps.groupId = group.id
        steps.fetchSteps()
    }

    var body: some View {
        
        let deviceWidth = DisplayData.deviceWidth
        let height = DisplayData.height
        let isDarkMode = appEnvironment.isDark
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDarkMode ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDarkMode ? 0 : 1)
            VStack {
                Text(group.name)
                    .foregroundColor(isDarkMode ? .white : .black)
                VStack {
                    if steps.stepList.isEmpty {
                        VStack{
                            Spacer()
                            Text("No steps found ...")
                                .foregroundColor(isDarkMode ? .white : .black)
                            Spacer()
                        }
                    } else {
                        List {
                            ForEach(steps.stepList) { step in
                                HStack {
                                    Button(action: {
                                        appEnvironment.path.append(Route.stepView(step))
                                    }){
                                        VStack {
                                            HStack{
                                                Text("\(step.title)")
                                                    .foregroundColor(isDarkMode ? .white : .black)
                                                    .font(.title2)
                                                Spacer()
                                            }
                                            HStack{
                                                Spacer()
                                                Text("\(step.stepDetails.count)move")
                                                    .foregroundColor(.gray)
                                                    .font(.subheadline)
                                            }
                                        }
                                        .padding()
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                                .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                                .frame(height: 40)
                            }
                            .listRowSeparatorTint(isDarkMode ? .white : .gray)
                            Spacer(minLength: 10)
                                .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                        }
                        .scrollDisabled(false)
                        .scrollContentBackground(.hidden)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newStep = addStep(name: steps.groupName, deviceWidth: deviceWidth, height: height)
                        steps.fetchSteps()//refrexh
                        appEnvironment.path.append(Route.stepView(newStep))
                    }){
                        BtnCreate(isDarkMode: isDarkMode, size: 30)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0.0, trailing: 30.0))
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    appEnvironment.path.append(Route.walkthroughView)
                }){
                    VStack {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(isDarkMode ? .white : .black)
                    }
                }
            }
        }
        .onAppear(){
            steps.groupName = group.name
            steps.fetchSteps()
        }
    }
}

class StepListViewModel: ObservableObject {
    @Published var stepList = [Step]()
    @Published var groupName: String
    @Published var groupId: String

    init(groupName: String,groupId: String) {
        self.groupName = groupName
        self.groupId = groupId
    }

    func fetchSteps() {
        stepList = getStepList(mode:.groupID,group_id: groupId)
    }
}
