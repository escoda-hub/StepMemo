import SwiftUI
import RealmSwift

struct stepProperty {
    var R_x: Double
    var R_y: Double
    var R_angle: Double
    var R_mode: Int
    var L_x: Double
    var L_y: Double
    var L_angle: Double
    var L_mode: Int
    var memo: String
}

struct imageSize {
    var minX: Double
    var maxX: Double
    var minY: Double
    var maxY: Double
}

struct StepView: View{
    
    @Binding var groupName:String
    @State var stepTitle = ""

    @State var stepData:Step
    @State var ImageSize = imageSize(minX: 0, maxX: 0, minY: 0, maxY: 0)
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
    @State var showMemoView = false

    var body: some View {
        
        let deviceWidth = UIScreen.main.bounds.width
        
        VStack {
            Text("\(stepData.id)")
            HStack {
                Text("\(stepData.title)")
                        .font(.title)
                        .frame(width: deviceWidth - (deviceWidth/5),alignment: .leading)
                        .background(Color(0xDCDCDD, alpha: 1.0))
                        .opacity(0.8)
                        .cornerRadius(5)
                        .contentShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)
                        .onTapGesture {
                            showTitleView = true
                        }
                        .sheet(isPresented: $showTitleView) {
                            titleInputView(stepData: $stepData, showTitleView: $showTitleView, GroupName: groupName)
                                .presentationDetents([.medium])
                        }
                Button(action: {
                    print("help")
                }, label: {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .foregroundColor(.blue.opacity(0.8))
                        .frame(width:25,height:25)
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
                        .foregroundColor(Color(0xDCDCDD, alpha: 1.0))
                        .onAppear(){
                            // ScrollViewが表示された後にScrollViewProxyを初期化する
//                            DispatchQueue.main.async {
                                self.ImageSize.minX = geometry.frame(in: .global).minX
                                self.ImageSize.maxX = geometry.frame(in: .global).maxX
                                self.ImageSize.minY = geometry.frame(in: .global).minY
                                self.ImageSize.maxY = geometry.frame(in: .global).maxY
//                            }
                        }
                    DraggableImage(
                        GroupName: $groupName,
                        StepTitle: stepTitle,
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
                        GroupName: $groupName,
                        StepTitle: stepTitle,
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
            .frame(width: deviceWidth, height: 300)
            HStack {
                SmallScrollVIew(
                                GroupName: groupName,
                                StepTitle: stepTitle,
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
                        print("add")
                        let result = addStepDetail(groupName: groupName, stepName: stepData.title)
                        stepData = result.step
                        indexSmallView = result.order
                    }, label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .foregroundColor(.blue.opacity(0.8))
                            .frame(width:30,height:30)
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
                PickerView(GroupName: groupName,StepTitle: stepTitle,isR: false,mode_L: $mode_L, mode_R: $mode_R,index:$indexSmallView,stepData: $stepData)
                Spacer()
                PickerView(GroupName: groupName,StepTitle: stepTitle,isR: true,mode_L: $mode_L, mode_R: $mode_R,index:$indexSmallView,stepData: $stepData)
                Spacer()
            }
            Text("\(stepData.stepDetails[indexSmallView-1].memo)")
                .padding(.horizontal)
                .lineLimit(3...5)
                .frame(width: deviceWidth - (deviceWidth/5),alignment: .leading)
                .background(Color(0xDCDCDD, alpha: 1.0))
                .opacity(0.8)
                .cornerRadius(5)
                .contentShape(RoundedRectangle(cornerRadius: 20))
                .onTapGesture {
                    showMemoView = true
//                    print(stepData.stepDetails)
//                    print(indexSmallView)
                }
                .sheet(isPresented: $showMemoView) {
                    memoInputView(stepData: $stepData, showMemoView: $showMemoView, index: indexSmallView)
//                    InformationView(stepData: stepData)
                        .presentationDetents([.medium])
                }
            NavigationLink(destination: SeleclGroupView(selectedGroup: $groupName)) {
                HStack {
                    HStack {
                        Image(systemName: "rectangle.3.group")
                        Text("Group")
                    }
                    .padding()
                    Spacer()
                    HStack {
                        Text(groupName)
                                .foregroundColor(.blue)
                        Image(systemName: "chevron.forward")
                            .padding(.trailing)
                    }
                }
            }
            .frame(height:35,alignment:.center)
            .background(Color(0xDCDCDD, alpha: 1.0))
            .foregroundColor(.black)
            .cornerRadius(CGFloat(5))
            .padding(.horizontal)
            Spacer()
        }//VStack
        .navigationBarTitleDisplayMode(.inline)
    }//body
}//VIEW
