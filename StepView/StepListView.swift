
import SwiftUI
import RealmSwift
struct StepListView: View {

    @State var groupName: String
    @ObservedObject var steps: StepListViewModel
    
    init(groupName: String, stepList: [Step] = []) {
        self.groupName = groupName
        self.steps = StepListViewModel(groupName: groupName)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(groupName)
                VStack {
                    if steps.stepList.isEmpty {
                        Text("No steps found")
                    } else {
                        List {
                            ForEach(steps.stepList, id: \.id) { step in
                                NavigationLink(
                                    destination: StepView(groupName: $groupName, stepData: step),
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
                    Button(action: {
                        addStep(name: groupName)
                        steps.fetchSteps()
                    }, label: {
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    })
                    .frame(width: 60, height: 60)
                    .background(Color.orange)
                    .cornerRadius(30.0)
                    .shadow(color: .gray, radius: 3, x: 3, y: 3)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
                }
            }
        }
        .onAppear(){
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

