import SwiftUI
import RealmSwift

struct SeleclGroupView: View {

    @Environment(\.presentationMode) var presentation
    @State var stepData:Step
    @State var selectedGroup = ""
    
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
                        print(oldGroupName)
                        print(newGroupName)
                        print(stepData.id)
                        changeGroup(oldGroupName: oldGroupName, newGroupName: newGroupName,step_id: stepData.id)
                        selectedGroup = groups.name
                        self.presentation.wrappedValue.dismiss()
                    }
                }
            }
        }
        .onAppear(){
            selectedGroup = getGroupName(group_id: stepData.group_id)
        }
    }
}
