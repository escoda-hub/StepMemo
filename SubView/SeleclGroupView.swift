import SwiftUI
import RealmSwift

struct SeleclGroupView: View {

    @Binding var selectedGroup :String
    
    @Environment(\.presentationMode) var presentation
    @ObservedResults(Group.self) var groups

    var body: some View {
        VStack {
            Text(selectedGroup)
            List {
                ForEach(0..<groups.count) { index in
                    HStack {
                        Text("\(groups[index].name)")
                            .padding(.horizontal)
                        Spacer()
                        Image(systemName: groups[index].name == selectedGroup ? "checkmark" : "")
                            .padding(.horizontal)
                            .foregroundColor(.blue)
                    }
                    .contentShape(RoundedRectangle(cornerRadius: 5)) 
                    .onTapGesture {
                        selectedGroup = groups[index].name
                        self.presentation.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct SeleclGroupView_Previews: PreviewProvider {
    
    @State static var selectedGroup =  "hipho"
    static var previews: some View {
        SeleclGroupView(selectedGroup: $selectedGroup)
    }
}
