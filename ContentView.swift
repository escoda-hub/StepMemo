import SwiftUI
import RealmSwift

struct ContentView: View {

    @ObservedResults(Group.self) var groups
    @ObservedResults(Step.self) var steps
    
    @State private var showingModal = false
    @State var searchText = ""

    var body: some View {
        let screenSizeWidth = UIScreen.main.bounds.width
        
        NavigationStack {
                ZStack {
                    Color(0xDFDCE3, alpha: 1.0).ignoresSafeArea()
                    VStack{
                        Spacer()
                        HStack{
                            NavigationLink(destination: StepListView(groupName:"全て")) {
                                VStack {
                                    Spacer()
                                    Image(systemName: "list.bullet")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                    Spacer()
                                    Text("全て")
                                        .font(.title3)
                                    Spacer()
                                }
                                .padding()
                            }
                            .frame(width: 100,
                                   height:150,
                                   alignment:.center
                            )
                            .background(Color(0x4ABDAC, alpha: 1))
                            .foregroundColor(.black)
                            .cornerRadius(CGFloat(15))
                            NavigationLink(destination: StepListView(groupName:"最近")) {
                                VStack {
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                    Spacer()
                                    Text("最近")
                                        .font(.title3)
                                    Spacer()
                                }
                                .padding()
                            }
                            .frame(width: 100,
                                   height:150,
                                   alignment:.center
                            )
                            .background(Color(0xFC4A1A, alpha: 0.8))
                            .foregroundColor(.black)
                            .cornerRadius(CGFloat(15))
                            NavigationLink(destination: StepListView(groupName:"お気に入り")) {
                                VStack {
                                    Spacer()
                                    Image(systemName: "heart")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                    Spacer()
                                    Text("好き")
                                        .font(.title3)
                                    Spacer()
                                }
                                .padding()
                            }
                            .frame(width: 100,
                                   height:150,
                                   alignment:.center
                            )
                            .background(Color(0xF7B733, alpha: 0.9))
                            .foregroundColor(.black)
                            .cornerRadius(CGFloat(15))
                        }
                        .padding(.vertical)
                        .padding(.top)
                        ZStack {
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
                                    ForEach(getGroup()!, id: \.self) { groups in
                                        NavigationLink(destination: StepListView(groupName:groups.name)) {
                                            Text(groups.name)
                                        }
                                    }
                                    .onDelete { indexSet in
                                        deleteGroup(indexSet: indexSet)
//                                        print(type(of: indexSet))//IndexSet
//                                        let realm = try! Realm()
//                                        let groupsToDelete = indexSet.map { getGroup()![$0] }
//                                        try! realm.write {
//                                            groupsToDelete.forEach { group in
//                                                // 削除するGroupオブジェクトからStepオブジェクトを取得し、削除する
//                                                let stepsToDelete = group.steps
//                                                stepsToDelete.forEach { step in
//                                                    // 削除するStepオブジェクトからStepDetailオブジェクトを取得し、削除する
//                                                    let stepDetailToDelete = step.stepDetails
//                                                    realm.delete(stepDetailToDelete)
//                                                }
//                                                realm.delete(stepsToDelete)
//                                            }
//                                            realm.delete(groupsToDelete)
//                                        }
                                    }
                                    Spacer(minLength: 10)
                                }
                            }
                            .scrollDisabled(false)
                            .scrollContentBackground(.hidden)
                            .background(Color(0xDFDCE3, alpha: 1.0))
                            .padding(.horizontal)
                            .padding(.bottom)
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        print(Realm.Configuration.defaultConfiguration.fileURL!)
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
                        }//List + button
                        Button("deleteALL Button") {
                            print(Realm.Configuration.defaultConfiguration.fileURL!)
                            deleteAll()
                        }
                        .disabled(false)
                        Button("add stepdata Button") {
                            print(Realm.Configuration.defaultConfiguration.fileURL!)
                            setStepData()
                        }
                        .disabled(false)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){
                            HStack {
                                Image(systemName: "magnifyingglass") //検索アイコン
                                TextField("Search ...", text: $searchText)
                            }
                            .frame(width: screenSizeWidth - 100)
                            .background(Color(.systemGray6))
                            .cornerRadius(CGFloat(10))
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: InformationView()){
                                Image(systemName: "info.circle")
                                    .foregroundColor(.black)
                            }
                        }
                        ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                            Button(action: {
                                self.showingModal.toggle()
                            }) {
                                HStack{
                                    Image(systemName: "rectangle.3.group")
                                    Text("add group")
                                }
                                .foregroundColor(.black)
                            }.sheet(isPresented: $showingModal,onDismiss: {
//                                genre = getGroup()
                            }) {
                                EditGroupView()
                            }
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Spacer()
                        }
                    }//Vstack
                }//ZStack
        }//navigation stack
    }//body
}//content view

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//グループ名の取得
func deleteAll() {

    let realm = try! Realm()
    try! realm.write {
      realm.deleteAll()
    }
}

func setStepData() {
    let group = Group()
    group.name = "group_1"

    let step = Step()
    step.title = "step_1"
    step.created_at = Date()
    step.updated_at = Date()
    step.favorite = true

    let stepDetail_1 = StepDetail()
    stepDetail_1.step_id = step.id
    stepDetail_1.imagename = "g1_s1_1"
    stepDetail_1.memo = "memomemomemo_1"
    stepDetail_1.L_x = 100
    stepDetail_1.L_y = 100
    stepDetail_1.L_angle = 100
    stepDetail_1.L_mode = 2
    stepDetail_1.R_x = 300
    stepDetail_1.R_y = 200
    stepDetail_1.R_angle = 50
    stepDetail_1.R_mode = 1
    stepDetail_1.Order = 1
    
    let stepDetail_2 = StepDetail()
    stepDetail_2.step_id = step.id
    stepDetail_2.imagename = "g1_s1_2"
    stepDetail_2.memo = "memomemomemo_2"
    stepDetail_2.L_x = 120
    stepDetail_2.L_y = 120
    stepDetail_2.L_angle = 10
    stepDetail_2.L_mode = 1
    stepDetail_2.R_x = 320
    stepDetail_2.R_y = 220
    stepDetail_2.R_angle = 20
    stepDetail_2.R_mode = 2
    stepDetail_2.Order = 2
    
    let stepDetail_3 = StepDetail()
    stepDetail_3.step_id = step.id
    stepDetail_3.imagename = "g1_s1_3"
    stepDetail_3.memo = "memomemomemo_2"
    stepDetail_3.L_x = 80
    stepDetail_3.L_y = 90
    stepDetail_3.L_angle = 80
    stepDetail_3.L_mode = 2
    stepDetail_3.R_x = 300
    stepDetail_3.R_y = 290
    stepDetail_3.R_angle = 50
    stepDetail_3.R_mode = 3
    stepDetail_3.Order = 3
    
    step.stepDetails.append(stepDetail_1)
    step.stepDetails.append(stepDetail_2)
    step.stepDetails.append(stepDetail_3)
    group.steps.append(step)


    let realm = try! Realm()

    do{
      try realm.write{
          realm.add(group)
      }
    }catch {
      print("Error \(error)")
    }
}
