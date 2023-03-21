import SwiftUI
import RealmSwift

struct SeleclGroupView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @Binding var stepData:Step
    @Binding var selectedGroup:String
    @Binding var isShow : Bool
    @State  private var isDarkMode = true
    
    var body: some View {
        
        let isDarkMode = appEnvironment.isDark
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDarkMode ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDarkMode ? 0 : 1)
            VStack {
//                Spacer()

                List {
                    HStack {
                        Spacer()
                        Text("グループ選択")
                        Spacer()
                    }
                    .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                    .foregroundColor(isDarkMode ? .white : .black)
                    .frame(height: 20)
                    ForEach(getGroup()!, id: \.self) { groups in
                        HStack {
                            Text("\(groups.name)")
                                .padding(.horizontal)
                            Spacer()
                            Image(systemName: groups.name == selectedGroup ? "checkmark" : "")
                                .padding(.horizontal)
                                .foregroundColor(.blue)
                        }
                        .foregroundColor(isDarkMode ? .white : .black)
                        .contentShape(RoundedRectangle(cornerRadius: 5))
                        .onTapGesture {
                            let oldGroupName = selectedGroup
                            let newGroupName = groups.name
                            changeGroup(oldGroupName: oldGroupName, newGroupName: newGroupName,step_id: stepData.id)
                            selectedGroup = groups.name
                            isShow = false
                        }
                        .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                        .frame(height: 20)
                    }
                }
                .listRowSeparatorTint(isDarkMode ? .white : .gray)
//                Spacer()
            }
            .scrollDisabled(false)
            .scrollContentBackground(.hidden)
            .onAppear(){
                selectedGroup = getGroupName(group_id: stepData.group_id)
        }
        }
    }
}
