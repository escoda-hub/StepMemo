
import SwiftUI
import RealmSwift

struct StepListView: View {

    @State var ViewTitle :String
    @State private var steps = [Step]()
    
    var body: some View {

//        NavigationView{
            ZStack {
                VStack {
                    Text(ViewTitle)
//                    List {
//                        Section (
//                        )
//                        {
//                            ForEach(0 ..< getStep(groupName: ViewTitle).count) { index in
//                              NavigationLink(destination: StepView(groupName: "group_1", stepTitle: "step_1")) {
//                                    Text(getStep(groupName: ViewTitle)[index].title)
//                                }
//                             }
//                            Spacer(minLength: 10)
//                        }
//                    }
//                    .border(.red)
//                    .onAppear(){
//                        getStep(groupName: ViewTitle)
//                    }
                    let navigationLinks = getStep(groupName: ViewTitle).map { step in
                        NavigationLink(destination: StepView(groupName: "group_1", stepTitle: "step_1")) {
                            Text(step.title)
                        }
                    }
                    List {
                        Section {
                            ForEach(getStep(groupName: ViewTitle).indices, id: \.self) { index in
                                navigationLinks[index]
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .onAppear {
                        steps = getStep(groupName: ViewTitle)
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            print("Tapped!!")
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
//        }
    }
}

struct StepListView_Previews: PreviewProvider {
    static var previews: some View {
        StepListView(ViewTitle:"title sample")
    }
}

//ステップリストの取得
func getStep(groupName:String)->Array<Step> {
    
    let realm = try! Realm()
    let groupData = realm.objects(Group.self).filter("name == %@",groupName).first!//type is List
    
    return Array(groupData.steps)//type is Array<Step>

}
