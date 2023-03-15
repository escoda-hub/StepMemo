
import SwiftUI
import RealmSwift

struct StepListView: View {

    @State var groupName :String
    @State var stepList = [Step]()
    
    init(groupName: String, stepList: [Step] = []) {
        self.groupName = groupName
        self.stepList = getStepList(groupName: groupName)
    }
    
    var body: some View {
            ZStack {
                VStack {
                    Text(groupName)
                    VStack {
                           if stepList.isEmpty {
                               Text("No steps found")
                           } else {
                               List{
                                   ForEach(stepList) { step in
                                       NavigationLink(
                                           destination: StepView(groupName:$groupName,stepData: step),
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
                .onAppear(){
                    stepList = getStepList(groupName: groupName)
                    print("hi")
                }
                VStack {

                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            addStep(name: groupName)
                            stepList = getStepList(groupName: groupName)
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
                stepList = getStepList(groupName: groupName)
            }
            .navigationBarTitleDisplayMode(.inline)//ナビゲーションバーのタイトルの表示モードを設定
    }
}
