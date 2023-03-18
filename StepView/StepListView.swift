
import SwiftUI

struct StepListView: View {

    @State var group: Group
    @ObservedObject var steps: StepListViewModel
    @State var deviceWidth:Double
    @State var height:Double
    @State var step: Step
    @State var isStepDataActive = false
    @State var isPresented = false
    
    init(group: Group, deviceWidth: Double, height: Double,step:Step = Step()) {
        self.group = group
        self.deviceWidth = deviceWidth
        self.height = height
        self.steps = StepListViewModel(groupName: group.name)
        self.step = step
        steps.groupName = group.name
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
                                NavigationLink(
                                    destination: StepView(stepData: step),
                                    label: {
                                        VStack{
                                            Text("\(step.title)")
                                        }
                                        .padding()
                                    }
                                )
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            VStack {
                Spacer()
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { // このボタンをタップすると FirstView に遷移する。
                            let newStep = addStep(name: steps.groupName, deviceWidth: deviceWidth, height: height)
                            steps.groupName = group.name
                            steps.fetchSteps()
                            step = newStep
                            print(step)
                            isPresented = true
                        }) {
                            Text("Go To the FirstView")
                        }
                        NavigationLink(destination: StepData(stepData: $step),
                                       isActive: $isPresented) {
                            EmptyView()
                        }
//                        NavigationLink {
//                            StepData(stepData: step)
//                        } label: {
//                            VStack {
//                                Image(systemName: "pencil")
//                                    .foregroundColor(.white)
//                                    .font(.system(size: 24))
//                                Text("Step: \(step.id)")
//                            }
//                            .onTapGesture(){
//                                let newStep = addStep(name: steps.groupName, deviceWidth: deviceWidth, height: height)
//                                steps.groupName = group.name
//                                steps.fetchSteps()
//                                step = newStep
//                                print(step)
//                            }
//                        }
  
                        
//                        .frame(width: 60, height: 60)
                        .frame(width: 200, height: 200)
                        .background(Color.orange)
                        .cornerRadius(30.0)
                        .shadow(color: .gray, radius: 3, x: 3, y: 3)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
                    }
                }
            }
        }
        .onAppear(){
            if steps.stepList.isEmpty {
                //ステップがないときに、デフォルトのステップを一つ生成する
                step = addStep(name: steps.groupName, deviceWidth: deviceWidth, height: height)
            }else{
                
            }
            steps.groupName = group.name
            steps.fetchSteps()
        }
    }
}

class StepListViewModel: ObservableObject {
    @Published var stepList = [Step]()
    @Published var groupName: String

    init(groupName: String) {
        self.groupName = groupName
    }

    func fetchSteps() {
        stepList = getStepList(groupName: groupName)
    }
}
