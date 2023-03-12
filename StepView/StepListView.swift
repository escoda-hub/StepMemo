
import SwiftUI
import RealmSwift

struct StepListView: View {

    @State var groupName :String
    @State var stepList :[String] = []
    
    var body: some View {
            ZStack {
                VStack {
                    Text(groupName)
                    VStack {
                        List{
                            ForEach(stepList.indices, id: \.self) { index in
                                NavigationLink(
                                    destination:  StepView(groupName: groupName, stepTitle: stepList[index]),
                                    label: {
                                        Text("\(stepList[index])")
                                            .padding()
                                    })
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                        .onAppear {
                            stepList = getStepName(groupName: groupName)
                        }
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
    }
}
//ステップリストの取得
func getStep(groupName:String)->Array<Step> {
    
    let realm = try! Realm()
    let groupData = realm.objects(Group.self).filter("name == %@",groupName).first!//type is List
    
    return Array(groupData.steps)//type is Array<Step>

}
