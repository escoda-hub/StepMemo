
import SwiftUI

struct StepListView: View {

    @State var group: Group
    @ObservedObject var steps: StepListViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var step: Step
    @State var isStepDataActive = false
    @State var isPresented = false
    
    let deviceWidth = DisplayData.deviceWidth
    let height = DisplayData.height
    
    init(group: Group,step:Step = Step()) {
        self.group = group
        self.steps = StepListViewModel(groupName:group.name,groupId: group.id)
        self.step = step
        steps.groupName = group.name
        steps.groupId = group.id
        steps.fetchSteps()
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                Text(group.name)
                VStack {
                    if steps.stepList.isEmpty {
                        VStack{
                            Spacer()
                            Text("No steps found ...")
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
                                                    .foregroundColor(.black)
                                                    .font(.title2)
                                                Spacer()
                                            }
                                            HStack{
                                                Spacer()
                                                Text("\(step.stepDetails.count)move")
                                                    .foregroundColor(.black)
                                                    .font(.subheadline)
                                            }
              
                                        }
                                        .padding()
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                }
                                .frame(height: 50)
                            }
                        }
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
                        VStack {
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                        }
                        .navigationDestination(for: Route.self) { route in
                            coordinator(route)
                        }
                        .frame(width: 60, height: 60)
                        .background(BackgroundColor_MainView.createStepBtn)
                        .cornerRadius(30.0)
                        .shadow(color: .gray, radius: 3, x: 3, y: 3)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
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
                            .foregroundColor(.black)
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
