
import SwiftUI
import RealmSwift
struct StepListView: View {

    @State var groupName :String
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
                            ForEach(steps.stepList) { step in
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
    var groupName: String

    init(groupName: String) {
        self.groupName = groupName
    }

    func fetchSteps() {
        stepList = getStepList(groupName: groupName)
    }
}

//StepListViewで@Stateを使用している変数stepListとgroupNameは、初期化時に渡された値で初期化され、その後は別の箇所で値が変更された場合にのみ更新されます。
//
//StepViewから戻ってきたときにstepListの値が変わっていないため、ForEachで表示されるリストも変更されずにそのままになっている可能性があります。
//
//そのため、StepListViewで新しいStepが追加された場合には、リストが自動的に更新されるように、stepListの変更を検知してビューを再描画する必要があります。
//
//以下は、変更を検知するために、stepListの値を@ObservedObjectでラップする方法です。
