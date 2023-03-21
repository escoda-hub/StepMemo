
import SwiftUI
import RealmSwift

struct StepListView: View {

    @State var group: Group
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var step: Step
    @State var isStepDataActive = false
    @State var isPresented = false
    @State  private var isDarkMode = true
    

    init(group: Group,step:Step = Step()) {
        self.group = group
        self.step = step
    }

    var body: some View {
        
        let deviceWidth = DisplayData.deviceWidth
        let height = DisplayData.height
        let isDarkMode = appEnvironment.isDark
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDarkMode ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDarkMode ? 0 : 1)
            VStack {
                Text(group.name)
                    .foregroundColor(isDarkMode ? .white : .black)
                VStack {
                    if getStepLists(mode:.groupID,groupID: group.id).isEmpty {
                        VStack{
                            Spacer()
                            Text("No steps found ...")
                                .foregroundColor(isDarkMode ? .white : .black)
                            Spacer()
                        }
                    } else {
                        List {
                            ForEach(getStepLists(mode:.groupID,groupID: group.id).freeze(), id: \.id) { step in
                                HStack {
                                    Button(action: {
                                        appEnvironment.path.append(Route.stepView(step))
                                    }){
                                        VStack {
                                            HStack{
                                                Text("\(step.title)")
                                                    .font(.title2)
                                                    .foregroundColor(isDarkMode ? .white : .black)
                                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                        Button(role: .destructive) {
                                                            deleteStep(step_id: step.id)
//                                                            appEnvironment.reload = true
                                                        } label: {
                                                            Image(systemName: "trash.fill")
                                                        }
                                                    }
                                            }
                                        }
                                        .padding()
                                }
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(isDarkMode ? .white : .black)
                                }
                            }
                            .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                            .frame(height: 40)
                        }
                            .listRowSeparatorTint(isDarkMode ? .white : .gray)
                            Spacer(minLength: 10)
                                .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                    }
                }
                .scrollDisabled(false)
                .scrollContentBackground(.hidden)
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationBarTitleDisplayMode(.inline)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newStep = addStepFromId(groupID: group.id, deviceWidth: deviceWidth, height: height)
                        appEnvironment.path.append(Route.stepView(newStep))
                    }){
                        BtnCreate(isDarkMode: isDarkMode, size: 30)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0.0, trailing: 30.0))
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    appEnvironment.path.append(Route.walkthroughView)
                }){
                    VStack {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(isDarkMode ? .white : .black)
                    }
                }
            }
        }
    }
}
