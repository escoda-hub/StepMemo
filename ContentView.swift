import SwiftUI
import RealmSwift

struct ContentView: View {

    @State private var showingModal = false
    @State var searchText = ""
    @State var nickName = ""

    var body: some View {
        let genre = ["House", "Hiphop","d","e","f","g","h","i"]
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
                                       height:60,
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
                                       height:60,
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
                                       height:60,
                                       alignment:.center
                                )
                                .background(Color(0xF7B733, alpha: 1.0))
                                .foregroundColor(.black)
                                .cornerRadius(CGFloat(15))
                                Spacer()
                            }// VStack for 3 btn
//                            .border(.red)
                            .frame(height: 270)
//                            .padding(.top)
                            ZStack {
                                List {
                                    Section (
                                        header: HStack{
                                            Image(systemName: "rectangle.3.group")
                                                .resizable()
                                                .frame(width:25,height:18)
                                            Text("Group")
                                                .font(.title)
                                        }.frame(
                                            width: screenSizeWidth,
                                            height: 44.0
                                        )
                                        .background(Color(0x354B5E, alpha: 1.0))
                                        .foregroundColor(.white)
                                    ){
                                        ForEach(genre, id: \.self) { genre in
                                            NavigationLink(destination: StepListView(ViewTitle:genre)) {
                                                Text(genre)
                                            }
                                        }
                                    }
                                }
//                                .border(.red)
                                .scrollContentBackground(.hidden)
                                .background(Color(0xDFDCE3, alpha: 1.0))
                                .padding(.horizontal)
                                .padding(.bottom)
                                .listStyle(.plain)
                                VStack {
                                    Spacer()
                                    HStack { // --- 2
                                        Spacer()
                                        Button(action: {
                                            print("Tapped!!") // --- 3
                                        }, label: {
                                            Image(systemName: "pencil")
                                                .foregroundColor(.white)
                                                .font(.system(size: 24)) // --- 4
                                        })
                                            .frame(width: 60, height: 60)
                                            .background(Color.orange)
                                            .cornerRadius(30.0)
                                            .shadow(color: .gray, radius: 3, x: 3, y: 3)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0)) // --- 5
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
                            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
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
                            ToolbarItem(placement: .bottomBar) {
                                Spacer()
                            }
                    }//Vstack
            }//ZStack
//            .border(.red)
        }//navigation stack
//        .border(.red)
    }//body
}//content view

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


