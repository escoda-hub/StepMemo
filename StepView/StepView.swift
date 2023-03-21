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
    @State var showTitleView = false
    @State var showGroupView = false
    @State var showMemoView = false
    @State var groupName = ""
    @State private var isDarkMode = true

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
                HStack {
                    Text("\(stepData.title)")
                            .font(.title)
                            .foregroundColor(isDarkMode ? .white : .black)
                            .frame(width: deviceWidth - (deviceWidth/5))
                            .frame(minHeight:40)
                            .background(isDarkMode ? ComponentColor_StepView.title_dark : ComponentColor_StepView.title_light)
                            .lineLimit(1) // 1行に制限する
                            .truncationMode(.tail)
                            .opacity(0.8)
                            .cornerRadius(5)
                            .contentShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal)
                            .onTapGesture {
                                showTitleView = true
                            }
                            .sheet(isPresented: $showTitleView) {
                                titleInputView(stepData: $stepData, showTitleView: $showTitleView)
                                    .presentationDetents([.medium])
                            }
                    Button(action: {
                        stepData = upDateFavorite(step_id: stepData.id)
                    }, label: {
                        if stepData.favorite {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .foregroundColor(.pink.opacity(0.8))
                                .frame(width:25,height:25)
                        } else {
                            Image(systemName: "heart")
                                .resizable()
                                .foregroundColor(.pink.opacity(0.8))
                                .frame(width:25,height:25)
                        }
                    })
                    .frame(width: 30,height: 30)
                    .foregroundColor(.black)
                    .padding(.trailing)
                    Spacer()
                }
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
                                    showingAlert: $showingAlert)
                    VStack{
                        Button(action: {
                            let result = addStepDetail(step_id: stepData.id,deviceWidth: Double(deviceWidth),height: height)
                            stepData = result.step
                            indexSmallView = result.order
                        }, label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .foregroundColor(isDarkMode ? .white : .black)
                                .frame(width:30,height:30)
                                .padding(.trailing)
                        })
                        .padding(.trailing,5)
                        Image(systemName: "circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width:10)
                            .opacity(0)
                        }
                }//Small Window reagin
                HStack{
                    Spacer()
                    PickerView(isR: false,mode_L: $mode_L, mode_R: $mode_R,index:$indexSmallView,stepData: $stepData)
                    PickerView(isR: true,mode_L: $mode_L, mode_R: $mode_R,index:$indexSmallView,stepData: $stepData)
                    Spacer()
                }
                Text("\(stepData.stepDetails[indexSmallView-1].memo)")
                    .padding(.horizontal)
                    .lineLimit(3...5)
                    .frame(width: deviceWidth - (deviceWidth/5),alignment: .leading)
                    .frame(minHeight:80)
                    .foregroundColor(isDarkMode ? .white : .black)
                    .background(isDarkMode ? ComponentColor_StepView.memo_dark : ComponentColor_StepView.memo_light)
                    .opacity(0.8)
                    .cornerRadius(5)
                    .contentShape(RoundedRectangle(cornerRadius: 20))
                    .onTapGesture {
                        showMemoView = true
                    }
                    .sheet(isPresented: $showMemoView) {
                        memoInputView(stepData: $stepData, showMemoView: $showMemoView, index: indexSmallView)
                            .presentationDetents([.medium])
                    }
                Button(action: {
                }){
                    HStack {
                        Text("Group")
                            .foregroundColor(isDarkMode ? .white : .black)
                            .padding()
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
                .frame(width: deviceWidth - (deviceWidth/5),height:35,alignment:.center)
                .background(isDarkMode ? ComponentColor_StepView.group_dark : ComponentColor_StepView.group_light)
                .foregroundColor(.black)
                .cornerRadius(CGFloat(5))
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(){
                groupName = getGroupName(group_id: stepData.group_id)
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
    }//body
}//VIEW
