import SwiftUI

struct SeleclGroupView: View {

    @State var selectedGroup :String

    @Environment(\.presentationMode) var presentation

    private let group = ["hiphop", "house", "ballet"]//load from DB
    
    var body: some View {
        VStack {
            Text(selectedGroup)
            List {
                ForEach(0..<group.count) { index in
                    HStack {
                        Text("\(group[index])")
                            .padding(.horizontal)
                        Spacer()
                        Image(systemName: group[index] == selectedGroup ? "checkmark" : "")
                            .padding(.horizontal)
                            .foregroundColor(.blue)
                    }
                    .contentShape(RoundedRectangle(cornerRadius: 5)) 
                    .onTapGesture {
                        self.presentation.wrappedValue.dismiss()
                    }
                }
            }
            Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Back to MainView.")
                }
            )
        }
    }
}

struct SeleclGroupView_Previews: PreviewProvider {
    static var previews: some View {
        SeleclGroupView(selectedGroup: "hiphop")
    }
}
