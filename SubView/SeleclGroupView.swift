import SwiftUI
import RealmSwift

struct SeleclGroupView: View {

    @Binding var selectedGroup :String
    @Environment(\.presentationMode) var presentation
    @State var stepData:Step
    
    var body: some View {
        VStack {
            Text(selectedGroup)
            List {
                ForEach(getGroup()!, id: \.self) { groups in
                    HStack {
                        Text("\(groups.name)")
                            .padding(.horizontal)
                        Spacer()
                        Image(systemName: groups.name == selectedGroup ? "checkmark" : "")
                            .padding(.horizontal)
                            .foregroundColor(.blue)
                    }
                    .contentShape(RoundedRectangle(cornerRadius: 5))
                    .onTapGesture {
                        let oldGroupName = selectedGroup
                        let newGroupName = groups.name
                        changeGroup(oldGroupName: oldGroupName, newGroupName: newGroupName,step_id: stepData.id)
                        selectedGroup = groups.name
                        self.presentation.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

//struct SeleclGroupView_Previews: PreviewProvider {
//
//    @State static var selectedGroup =  "hipho"
//    static var previews: some View {
//        SeleclGroupView(selectedGroup: $selectedGroup)
//    }
//}
