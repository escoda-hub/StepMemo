
import SwiftUI
import RealmSwift

struct StepListView: View {

    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var group: Group
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
                                HStack{
                                    Button(action: {
                                        appEnvironment.path.append(Route.stepView(step))
                                    }){
                                        HStack{
                                            Text(step.title.isEmpty ? "no name":"\(step.title)")
                                                    .font(.title2)
                                                    .foregroundColor(step.title.isEmpty ? .gray :isDarkMode ? .white : .black)
                                                Spacer()
                                                Text("\(step.stepDetails.count)")
                                                    .foregroundColor(.gray)
                                                    .font(.subheadline)
                                                Image(systemName: "chevron.forward")
                                                    .foregroundColor(isDarkMode ? .white : .black)
                                            }
                                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                Button(role: .destructive) {
                                                    deleteStep(step_id: step.id)
                                                } label: {
                                                    Image(systemName: "trash.fill")
                                                }
                                            }
                                    }
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
                        BtnCreate(size: 30)
                    }
                }
                AdMobBannerView().frame(width:DisplayData.deviceWidth, height: 50)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    appEnvironment.path.append(Route.informationView)
                }){
                    VStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(isDarkMode ? .white : .black)
                    }
                }
            }
        }
    }
}
