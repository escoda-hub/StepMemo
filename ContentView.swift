import SwiftUI

struct ContentView: View {

    @State private var showingModal = false
    @State var searchText = ""

    var body: some View {
        let genre = ["House", "Hiphop"]
        let screenSizeWidth = UIScreen.main.bounds.width
        
        VStack{
                NavigationView {
                    VStack(spacing:10){
                        VStack(){
                            Spacer()
                            NavigationLink(destination: StepListView(ViewTitle:"All")) {
                                HStack {
                                    Image(systemName: "shippingbox.circle")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                        .padding()
                                    Text("All")
                                        .font(.title)
                                        .padding()
                                }
                            }
                            .frame(width: screenSizeWidth-200,
                                   height:70,
                                   alignment:.center
                            )
                            .background(Color(0x69af86, alpha: 1.0))
                            .cornerRadius(CGFloat(15))
                            Spacer()
                            NavigationLink(destination: StepListView(ViewTitle:"Resent")) {
                                HStack {
                                    Image(systemName: "calendar.circle")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                        .padding()
                                    Text("Resent")
                                        .font(.title)
                                        .padding()
                                }
                            }
                            .frame(width: screenSizeWidth-200,
                                   height:70,
                                   alignment:.center
                            )
                            .background(Color(0xcccccc, alpha: 1.0))
                            .cornerRadius(CGFloat(15))
                            
                            Spacer()
                            NavigationLink(destination: StepListView(ViewTitle:"Favorite")) {
                                HStack {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                        .padding()
                                    Text("Favorite")
                                        .font(.title)
                                        .padding()
                                }
                            }
                            .frame(width: screenSizeWidth-200,
                                   height:70,
                                   alignment:.center
                            )
                            .background(Color(0xcccccc, alpha: 1.0))
                            .foregroundColor(.black)
                            .cornerRadius(CGFloat(15))
                            
                            Spacer()
                        }
                        
                        List {
                            Section {
                                ForEach(genre, id: \.self) { genre in
                                    NavigationLink(destination: StepListView(ViewTitle:genre)) {
                                        Text(genre)
                                    }
                                }
                            } header: {
                                Text("Group")
                                    .font(.title)
                            }
                        }
//                        .navigationBarTitle("home")
//                        .navigationBarHidden(true)
                        .toolbar {
                            /// ナビゲーションバー左
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
                                }
                            }
                            
                            /// ボトムバー
                            ToolbarItem(placement: .bottomBar) {
                                NavigationLink(destination: InformationView()){
                                    HStack{
                                        Image(systemName: "plus")
                                        Text("add step")
                                    }
                                }
                            }
                            
                            ToolbarItem(placement: .bottomBar) {
                                Button(action: {
                                    self.showingModal.toggle()
                                }) {
                                    HStack{
                                        Image(systemName: "folder.badge.plus")
                                        Text("add group")
                                    }
                                }.sheet(isPresented: $showingModal) {
                                    EditGroupView()
                                }
                            }
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
