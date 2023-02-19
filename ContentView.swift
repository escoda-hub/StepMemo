import SwiftUI
import RealmSwift

struct ContentView: View {

    @State private var showingModal = false
    @State var searchText = ""
    @State var nickName = ""
    
    var body: some View {
        let genre = ["House", "Hiphop"]
        let screenSizeWidth = UIScreen.main.bounds.width
        
        NavigationStack {
            ZStack {
                Color(0xDFDCE3, alpha: 1.0).ignoresSafeArea()
                VStack{
                            VStack(){ // VStack for 3 btn
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
                                    .foregroundColor(.black)
                                }
                                .frame(width: screenSizeWidth-200,
                                       height:70,
                                       alignment:.center
                                )
                                .background(Color(0x4ABDAC, alpha: 1.0))
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
                                    .foregroundColor(.black)
                                }
                                .frame(width: screenSizeWidth-200,
                                       height:70,
                                       alignment:.center
                                )
                                .background(Color(0xFC4A1A, alpha: 1.0))
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
                                .background(Color(0xF7B733, alpha: 1.0))
                                .foregroundColor(.black)
                                .cornerRadius(CGFloat(15))
                                Spacer()
                            }// VStack for 3 btn
                            .padding()
                            List {
                                Section {
                                    ForEach(genre, id: \.self) { genre in
                                        NavigationLink(destination: StepListView(ViewTitle:genre)) {
                                            Text(genre)
                                        }
                                    }
                                } header: {
                                    HStack {
                                        Image(systemName: "rectangle.3.group")
                                            .resizable()
                                            .frame(width:25,height:18)
                                        Text("Group")
                                            .font(.title)
                                    }
                                }
                            }
                            
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
                            ToolbarItem(placement: .bottomBar) {
                                NavigationLink(destination: InformationView()){
                                    HStack{
                                        Image(systemName: "figure.socialdance")
                                        Text("add step")
                                    }
                                    .foregroundColor(.black)
                                }
                            }
                            ToolbarItem(placement: .bottomBar) {
                                Button(action: {
                                    self.showingModal.toggle()
                                }) {
                                    HStack{
                                        Image(systemName: "rectangle.3.group")
                                        Text("add group")
                                    }
                                    .foregroundColor(.black)
                                }.sheet(isPresented: $showingModal) {
                                    EditGroupView()
                                }
                            }
                    }
            }//toolbar
        }//navigation view
    }//body
}//content view

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
