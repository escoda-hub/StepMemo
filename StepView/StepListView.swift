
import SwiftUI
import RealmSwift

struct StepListView: View {

    @State var groupName :String
    @State var stepList :[Step] = []
    
    var body: some View {
            ZStack {
                VStack {
                    Text(groupName)
                    VStack {
                        if stepList.isEmpty {
                            Text("No steps found")
                        } else {
                            List{
                                ForEach(0..<stepList.count, id: \.self) { index in
                                    NavigationLink(
                                        destination: InformationView(stepData: stepList[index]),
                                        label: {
                                            Text("\(stepList[index].title)")
                                                .padding()
                                        }
                                    )
                                }
                            }
                        }
                    }
                    .onAppear(){
                        stepList = getStep(groupName: groupName)
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            addStep(name: groupName)
                            stepList = getStep(groupName: groupName)
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
            .navigationBarTitleDisplayMode(.inline)//ナビゲーションバーのタイトルの表示モードを設定
    }
}
