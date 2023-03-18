import SwiftUI
import RealmSwift

struct ContentView: View {

//    @ObservedResults(Group.self) var groups
//    @ObservedResults(Step.self) var steps
    
    @State private var showingModal = false
    @State var searchText = ""
    
    var body: some View {
        
        let deviceWidth = UIScreen.main.bounds.width
        let height = 300.0
        
        NavigationStack {
                ZStack {
                    Color(0xDFDCE3, alpha: 1.0).ignoresSafeArea()
                    VStack{
                        Spacer()
                        HStack{
                            NavigationLink(destination: Text("all")) {
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
                            .frame(width: 100,height:150,alignment:.center)
                            .background(Color(0x4ABDAC, alpha: 1))
                            .foregroundColor(.black)
                            .cornerRadius(CGFloat(15))
                            NavigationLink(destination: Text("recent")) {
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
                            .frame(width: 100,height:150,alignment:.center)
                            .background(Color(0xFC4A1A, alpha: 0.8))
                            .foregroundColor(.black)
                            .cornerRadius(CGFloat(15))
                            NavigationLink(destination: Text("heart")) {
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
                            .frame(width: 100,height:150,alignment:.center)
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
                                    if let groups = getGroup() {
                                        ForEach(groups, id: \.id) { group in
                                            NavigationLink(destination: StepListView(groupName: group.name,deviceWidth:deviceWidth,height: height)) {
                                                Text(group.name)
                                                    .swipeActions(edge: .trailing) {
                                                        Button(role: .destructive) {
                                                            deleteGroup(groupName: group.name)
                                                        } label: {
                                                            Image(systemName: "trash.fill")
                                                        }
                                                    }
                                            }
                                        }
                                    }
                                    Spacer(minLength: 10)
                                }
                            }
                            .scrollDisabled(false)
                            .scrollContentBackground(.hidden)
                            .background(Color(0xDFDCE3, alpha: 1.0))
                            .padding(.horizontal)
                            .padding(.bottom)
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
                            .frame(width: deviceWidth - 100)
                            .background(Color(.systemGray6))
                            .cornerRadius(CGFloat(10))
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: onDelete()){
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

