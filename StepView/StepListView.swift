
import SwiftUI

struct StepListView: View {

    @State var group: Group
    @ObservedObject var steps: StepListViewModel
    @State var deviceWidth:Double
    @State var height:Double
    @State private var step: Step
    
    init(group: Group, deviceWidth: Double, height: Double,step:Step = Step()) {
        self.group = group
        self.deviceWidth = deviceWidth
        self.height = height
        self.steps = StepListViewModel(groupName: group.name)
        self.step = step
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
                            ForEach(steps.stepList, id: \.id) { step in
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
                HStack {
                    Spacer()
                    VStack {
                        NavigationLink(
                            destination: StepData(stepData: step),
                            label: {
                                Image(systemName: "pencil")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }
                        )
                        .frame(width: 60, height: 60)
                        .background(Color.orange)
                        .cornerRadius(30.0)
                        .shadow(color: .gray, radius: 3, x: 3, y: 3)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
                    }
                }
            }
        }
        .onAppear(){
            steps.groupName = group.name
            steps.fetchSteps()
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
