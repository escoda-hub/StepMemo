import SwiftUI
import RealmSwift

struct SeleclGroupView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @Binding var stepData:Step
    @Binding var selectedGroup:String
    @Binding var isShow : Bool
    
    var body: some View {
        VStack {
            Text("グループ選択")
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
                        isShow = false
                    }
                }
            }
        }
        .onAppear(){
            selectedGroup = getGroupName(group_id: stepData.group_id)
        }
    }
}
