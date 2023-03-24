import SwiftUI
import RealmSwift

struct StepView: View{
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    @State var stepData:Step
    @State var stepDisplaySize = StepDisplaySize(minX: 0, maxX: 0, minY: 0, maxY: 0)
    @State var location   = CGPoint(x: 0, y: 0)
    @State var location_L = CGPoint(x: 0, y: 0)
    @State var location_R = CGPoint(x: 0, y: 0)
    @State var angle   = Angle(degrees: 0)
    @State var angle_L = Angle(degrees: 0)
    @State var angle_R = Angle(degrees: 0)
    @State var mode   = 0
    @State var mode_L = 0
    @State var mode_R = 0
    @State var indexSmallView = 1
    @State var showingAlert = false
    @State var showGroupView = false
    @State var showMemoView = false
    @State var groupName = ""
    @State private var isDarkMode = true
    @State private var showingAlert_maxFrame = false
    
    @State private var titleText = ""
    @FocusState var isTitleInputActive: Bool
    @State private var memoText = ""
    @FocusState var isMemoInputActive: Bool
    
    var body: some View {
        
        let deviceWidth = DisplayData.deviceWidth
        let height = DisplayData.height
        let isDarkMode = appEnvironment.isDark
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDarkMode ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDarkMode ? 0 : 1)
            List{
                        HStack {
                            TextField("タイトル", text: $titleText)
                                .focused($isTitleInputActive)
                                .font(.title)
                                .foregroundColor(isDarkMode ? .white : .black)
                                .background(isDarkMode ? ComponentColor_StepView.title_dark : ComponentColor_StepView.title_light)
                                .frame(width: deviceWidth - (deviceWidth/5))
                                .frame(minHeight:40)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .cornerRadius(5)
                                .contentShape(RoundedRectangle(cornerRadius: 20))
                                .padding(.horizontal)
                                .keyboardType(.asciiCapable)
                                .onAppear(){
                                    titleText = stepData.title
                                }
                            FavoriteView(stepData: $stepData)
                        }
                        .listRowBackground(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
                        .listRowSeparatorTint(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
                        GeometryReader { geometry in
                            ZStack {
                                Rectangle()
                                    .ignoresSafeArea(.all)
                                    .foregroundColor(isDarkMode ? ComponentColor_StepView.StepDisplay_dark : ComponentColor_StepView.StepDisplay_light)
                                    .onAppear(){
                                        self.stepDisplaySize.minX = geometry.frame(in: .global).minX
                                        self.stepDisplaySize.maxX = geometry.frame(in: .global).maxX
                                        self.stepDisplaySize.minY = geometry.frame(in: .global).minY
                                        self.stepDisplaySize.maxY = geometry.frame(in: .global).maxY
                                    }
                                DraggableImage(
                                    indexSmallView: $indexSmallView,
                                    isR: true,
                                    location: $location,
                                    location_L: $location_L,
                                    location_R: $location_R,
                                    angle: $angle,
                                    angle_L: $angle_L,
                                    angle_R: $angle_R,
                                    mode: $mode,
                                    mode_L: $mode_L,
                                    mode_R: $mode_R,
                                    limit:
                                        limit(xMax: geometry.size.width-30,
                                              xMin: 20,
                                              yMax: geometry.size.height-40,
                                              yMin: 40),
                                    stepData: $stepData
                                )
                                DraggableImage(
                                    indexSmallView: $indexSmallView,
                                    isR: false,
                                    location: $location,
                                    location_L: $location_L,
                                    location_R: $location_R,
                                    angle: $angle,
                                    angle_L: $angle_L,
                                    angle_R: $angle_R,
                                    mode: $mode,
                                    mode_L: $mode_L,
                                    mode_R: $mode_R,
                                    limit:
                                        limit(xMax: geometry.size.width-30,
                                              xMin: 20,
                                              yMax: geometry.size.height-40,
                                              yMin: 40),
                                    stepData: $stepData
                                )
                            }
                        }
                        .frame(width: deviceWidth, height: CGFloat(height))
                        .listRowBackground(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
                        .listRowSeparatorTint(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
                        HStack {
                            SmallScrollVIew(
                                stepData: $stepData,
                                location_L: $location_L,
                                location_R: $location_R,
                                angle_L: $angle_L,
                                angle_R: $angle_R,
                                mode_L: $mode_L,
                                mode_R: $mode_R,
                                indexSmallView: $indexSmallView,
                                showingAlert: $showingAlert,
                                memoText:$memoText)
                                Button(action: {
                                    let result = addStepDetail(step_id: stepData.id,deviceWidth: Double(deviceWidth),height: height)
                                    stepData = result.step
                                    if result.order == -1{
//                                        print("50以下で")
                                        showingAlert_maxFrame = true
                                    }else{
                                        indexSmallView = result.order
                                    }
                                    
                                }, label: {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .foregroundColor(isDarkMode ? .white : .black)
                                        .frame(width:30,height:30)
                                })
                                .alert(isPresented: ($showingAlert_maxFrame)) {
                                    Alert(title: Text("登録可能なステップフレームは50枚までです。"))
                                }
                        }//Small Window reagin
                        .listRowBackground(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
                        .listRowSeparatorTint(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
                        HStack{
                            Spacer()
                            PickerView(isR: false,mode_L: $mode_L, mode_R: $mode_R,index:$indexSmallView,stepData: $stepData)
                            PickerView(isR: true,mode_L: $mode_L, mode_R: $mode_R,index:$indexSmallView,stepData: $stepData)
                            Spacer()
                        }
                        .listRowBackground(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
                        .listRowSeparatorTint(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
//                        HStack {
//                                TextField("一行メモ", text: $memoText)
//                                //TextField("一行メモ", text: $memoText,axis:.vertical)
//                                    .focused($isMemoInputActive)
//                                    .font(.caption)
//                                    .lineLimit(1)
//                                    .frame(minHeight:50)
//                                    .frame(width: deviceWidth - (deviceWidth/5),alignment: .leading)
//                                    .foregroundColor(isDarkMode ? .white : .black)
//                                    .cornerRadius(5)
//                                    .contentShape(RoundedRectangle(cornerRadius: 3))
//                                    .background(isDarkMode ? ComponentColor_StepView.memo_dark : ComponentColor_StepView.memo_light)
//                                    .onAppear(){
//                                        memoText = stepData.stepDetails[indexSmallView - 1].memo
//                                    }
//                            Spacer()
//                        }
//                        .listRowBackground(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
                        Button(action: {
                        }){
                            HStack {
                                Text("Group")
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .padding(.leading)
                                Spacer()
                                HStack {
                                    Text(groupName)
                                        .foregroundColor(.blue)
                                        .bold()
                                    Image(systemName: "chevron.forward")
                                        .padding(.trailing)
                                }
                                .foregroundColor(isDarkMode ? .white : .black)
                            }
                            .contentShape(RoundedRectangle(cornerRadius: 5))
                            .onTapGesture {
                                showGroupView = true
                            }
                            .sheet(isPresented: $showGroupView) {
                                SeleclGroupView(stepData: $stepData,selectedGroup: $groupName, isShow: $showGroupView)
                                    .presentationDetents([.medium])
                            }
                        }
                        .listRowBackground(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
                        .listRowSeparatorTint(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
                        .frame(width: deviceWidth - (deviceWidth/5),height:35,alignment:.center)
                        .background(isDarkMode ? ComponentColor_StepView.group_dark : ComponentColor_StepView.group_light)
                        .foregroundColor(.black)
                        .cornerRadius(CGFloat(5))
                        .padding(.horizontal)
                    // }
                AdMobBannerView()
                    .frame(width:DisplayData.deviceWidth, height: 50)
                    .listRowBackground(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
                    .listRowSeparatorTint(isDarkMode ? ComponentColor.background_dark : ComponentColor.background_light)
            }//List
            .listStyle(.plain)
                           .navigationBarTitleDisplayMode(.inline)
                    .onAppear(){
                        groupName = getGroupName(group_id: stepData.group_id)
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
                        ToolbarItemGroup(placement: .keyboard) {
                            Button(action: {
                                //キャンセル時
                                if isTitleInputActive{
                                    //タイトルにフォーカスがある時
                                    titleText = stepData.title
                                    self.isTitleInputActive = false
                                }
                                if isMemoInputActive {
                                    //メモにフォーカスがある時
                                    memoText = stepData.stepDetails[indexSmallView-1].memo
                                    self.isMemoInputActive = false
                                }
                            }){
                                BtnCancel(size: 15)
                            }
                            Button(action: {
                                //完了時の処理
                                if isTitleInputActive{
                                    //タイトルにフォーカスがある時
                                    stepData = upDateTitle(step_id: stepData.id, title: titleText)
                                    self.isTitleInputActive = false
                                }
                                if isMemoInputActive {
                                    //メモにフォーカスがある時
                                    if let updatedMemo = updateMemo(step_id: stepData.id, index: indexSmallView, memo: memoText) {
                                        stepData = updatedMemo
                                        print(stepData)
                                    }
                                    self.isMemoInputActive = false
                                }
                            }){
                                BtnComplete(size: 15)
                            }
                        }
                    }
                    .scrollDisabled(false)
                .scrollContentBackground(.hidden)
        }
    }//body
}//VIEW
