
import SwiftUI
import RealmSwift

struct StepSummary {
    let title : String
    let update : String
}



struct StepListView: View {

    @State var ViewTitle :String
    @ObservedResults(Step.self) var steps
    @ObservedResults(Group.self) var groups
    
    var body: some View {

        NavigationView{
            ZStack {
                VStack {
                    Text(ViewTitle)
                    List {
                        Section (
                            header: HStack{
                                Image(systemName: "rectangle.3.group")
                                    .resizable()
                                    .frame(width:25,height:18)
                                Text("Group")
                                    .font(.title)
                            }
                        )
                        {
                            ForEach(0 ..< getStep(groupName: ViewTitle).count) { index in
                                NavigationLink(destination: StepView(step: stepListData[0])) {
                                    Text(getStep(groupName: ViewTitle)[index].title)
//                                    Text(steps[index].updated_at)
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
        }
    }
}

struct StepListView_Previews: PreviewProvider {
    static var previews: some View {
        StepListView(ViewTitle:"title sample")
    }
}

//グループ名の取得
func getStep(groupName:String)->Results<Step> {
    
    let realm = try! Realm()
    let groupData = realm.objects(Step.self).filter("group.name == %@", groupName)
    
    return groupData

}
