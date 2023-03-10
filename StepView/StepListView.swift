
import SwiftUI
import RealmSwift

struct StepListView: View {

    @State var ViewTitle :String

    var body: some View {

//        NavigationView{
            ZStack {
                VStack {
                    Text(ViewTitle)
                    List {
                        Section (
                        )
                        {
                            ForEach(0 ..< getStep(groupName: ViewTitle).count) { index in
                              NavigationLink(destination: StepView(groupName: "group_1", stepTitle: "step_1")) {
                                    Text(getStep(groupName: ViewTitle)[index].title)
                                }
                             }
                            Spacer(minLength: 10)
                        }
                    }
                    .onAppear(){
                        getStep(groupName: ViewTitle)
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
