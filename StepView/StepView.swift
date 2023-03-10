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
    
    @State var groupName:String
    @State var stepTitle:String
    @State var index:Int
    @State var stepData:Step
    @State var ImageSize :imageSize
    @State var location   :CGPoint
    @State var location_L :CGPoint
    @State var location_R :CGPoint
    @State var angle   :Angle
    @State var angle_L :Angle
    @State var angle_R :Angle
    @State var mode   :Int
    @State var mode_L :Int
    @State var mode_R :Int
    @State var indexSmallView:Int
    @State var showingAlert:Bool
    
    init(groupName: String, stepTitle: String, index: Int = 0, stepData: Step = Step(), ImageSize: imageSize=imageSize(minX: 0, maxX: 0, minY: 0, maxY: 0),location_L:CGPoint=CGPoint(x: 0, y: 0),location_R:CGPoint=CGPoint(x: 0, y: 0),indexSmallView:Int=0,showingAlert:Bool=false) {
        self.groupName = groupName
        self.stepTitle = stepTitle
        self.index = 0
        self.stepData = getStepData(groupName: groupName, stepName: stepTitle)
        self.ImageSize = ImageSize
        self.location_L = CGPoint(x: 0, y: 0)
        self.location_R = CGPoint(x: 0, y: 0)
        self.location = CGPoint(x: 0, y: 0)
        self.angle_L = Angle(degrees: 0)
        self.angle_R = Angle(degrees: 0)
        self.angle = Angle(degrees: 0)
        self.mode_L = 0
        self.mode_R = 0
        self.mode = 0
        self.indexSmallView = 1
        self.showingAlert = false
    }

    var body: some View {
        
        let deviceWidth = UIScreen.main.bounds.width
        
        VStack {
            HStack {
                TextField("タイトル", text: $stepData.title)
                    .font(.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                Button(action: {
                    print("saved")
                }, label: {
                    Image(systemName: "tray.and.arrow.down")
                        .frame(width: 40,height: 40)
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
                        .task{
                            self.ImageSize.minX = geometry.frame(in: .global).minX
                            self.ImageSize.maxX = geometry.frame(in: .global).maxX
                            self.ImageSize.minY = geometry.frame(in: .global).minY
                            self.ImageSize.maxY = geometry.frame(in: .global).maxY
                        }
                    DraggableImage(
                        GroupName: $groupName,
                        StepTitle: $stepTitle,
                        Index: $index,
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
//                    DraggableImage(
//                        GroupName: $groupName,
//                        StepTitle: $stepTitle,
//                        Index: $index,
//                        isR: false,
//                        location: $location,
//                        location_L: $location_L,
//                        location_R: $location_R,
//                        angle: $angle,
//                        angle_L: $angle_L,
//                        angle_R: $angle_R,
//                        mode: $mode,
//                        mode_L: $mode_L,
//                        mode_R: $mode_R,
//                        limit:
//                            limit(xMax: geometry.size.width-30,
//                                  xMin: 20,
//                                  yMax: geometry.size.height-40,
//                                  yMin: 40),
//                        stepData: $stepData
//                    )
                }
            }
            .frame(width: deviceWidth, height: 300)

//            //Small Window reagin
//            HStack {
//                ScrollView(.horizontal){
//                    HStack {
//                        ForEach(0..<stepData.stepDetails.count) {(row: Int) in
//                                ZStack {
//                                    OverView(index: row, stepData: $stepData)
//                                    .border(stepData.stepDetails[row].Order == indexSmallView ? Color.gray : Color.white, width: stepData.stepDetails[row].Order == indexSmallView  ? 2.0 : 1.0)
//                                    .onTapGesture {
//                                        index = row
//                                        indexSmallView = stepData.stepDetails[row].Order
//                                        location_L = CGPoint(
//                                            x: stepData.stepDetails[row].L_x,
//                                            y: stepData.stepDetails[row].L_y)
//                                        location_R = CGPoint(
//                                            x: stepData.stepDetails[row].R_x,
//                                            y: stepData.stepDetails[row].R_y)
//                                        angle_L = Angle(degrees: stepData.stepDetails[row].L_angle)
//                                        angle_R = Angle(degrees: stepData.stepDetails[row].R_angle)
//                                        mode_L = stepData.stepDetails[row].L_mode
//                                        mode_R = stepData.stepDetails[row].R_mode
//                                    }
//                                    .onLongPressGesture {
//                                        indexSmallView = stepData.stepDetails[row].Order
//                                        showingAlert = true
//                                    }
//                                    Text("\(stepData.stepDetails[row].Order)")
//                                }
//                            }
//                    }
//                }
//                .padding(.horizontal)
//                .alert(isPresented: $showingAlert) { () -> Alert in
//                    Alert(
//                        title: Text("確認"),
//                        message: Text("\(indexSmallView)番目のデータを削除してもよろしいですか？"),
//                        primaryButton: .default(Text("Ok"),
//                                                action: {
//                                                    actionAfterAlert()
//                                                }
//                                               ),
//                        secondaryButton: .default(Text("キャンセル")                      )
//                    )
//                }
//                Button(action: {
//                    print("add")
//                    addStepDetail(groupName: groupName, stepName: stepTitle)
//                    stepData = getStepData(groupName: groupName, stepName: stepTitle)
//                }, label: {
//                    Image(systemName: "plus.circle")
//                        .resizable()
//                        .foregroundColor(.black)
//                        .frame(width:30,height:30)
//                })
//                .padding(.trailing)
//            }//Small Window reagin
//            HStack{
//                Spacer()
//                PickerView(mode: "normal", isR: true, mode_L: 2, mode_R: 2)
//                Spacer()
//                PickerView(mode: "normal", isR: false, mode_L: 2, mode_R: 2)
//                Spacer()
//            }
//            TextField("メモ", text: $stepData.stepDetails[index].memo,axis: .vertical)
//                .textFieldStyle(.roundedBorder)
//                .padding(.horizontal)
//                .lineLimit(3...5)
            Spacer()
        }//VStack
    }//body
}//VIEW

    //                NavigationLink(destination: SeleclGroupView(selectedGroup: $selectedGroup)) {
    //                    HStack {
    //                        HStack {
    //                            Image(systemName: "rectangle.3.group")
    //                            Text("Group")
    //                        }
    //                        .padding()
    //                        Spacer()
    //                        HStack {
    //                            Text(selectedGroup)
    //                            .foregroundColor(.blue)
    //                            Image(systemName: "chevron.forward")
    //                                .padding(.trailing)
    //                        }
    //                    }
    //                }
    //                .frame(height:35,alignment:.center)
    //                .background(Color(0xcccccc, alpha: 1.0))
    //                .foregroundColor(.black)
    //                .cornerRadius(CGFloat(5))
    //                .padding(.horizontal)
    //                Button {
    //                    self.uiImage =
    //                        UIApplication
    //                        .shared
    //                        .connectedScenes
    //                        .filter({$0.activationState == .foregroundActive})
    //                        .map({$0 as? UIWindowScene})
    //                        .compactMap({$0})
    //                        .first?.windows
    //                        .filter({$0.isKeyWindow}).first?
    //                        .rootViewController?
    //                        .view!
    //                        .getImage(rect: CGRect(
    //                            x: ImageSize.minX,//padding
    //                            y: ImageSize.minY,
    //                            width: ImageSize.maxX-ImageSize.minX,
    //                            height: ImageSize.maxY-ImageSize.minY))
    ////                    if uiImage != nil {
    ////                        saveImage(image: uiImage!, path: ImageInDocumentsDirectory(filename: "hihi.png"))
    ////                    }
    //                } label: {
    //                    HStack {
    //                        Text("Add to Photos")
    //                    }
    //                    .foregroundColor(.purple)
    //                }
    //                Spacer()
    //            }
    //        }
    //}
    
//    struct StepView_Previews: PreviewProvider {
//        
//        static var previews: some View {
//            StepView(stepData: getStep(groupName: "group_1")[0])
//        }
//    }
    //
    //func ImageInDocumentsDirectory(filename: String) -> String {
    //
    //    let fileManager = FileManager.default
    //    let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    //    let directory = documentDirectoryFileURL.appendingPathComponent("TestDirectory", isDirectory: true)
    //    do {
    //        try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
    //
    //    } catch {
    //        print("createDirectoryに失敗しました")
    //    }
    //
    //    let fileURL = directory.appendingPathComponent(filename)
    //    print(fileURL)
    //
    //    return fileURL.path
    //}
    //
    //func getDocumentsURL() -> NSURL {
    //    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
    //    return documentsURL
    //}
    //
    //func saveImage (image: UIImage, path: String ) -> Bool {
    //    let pngImageData = image.pngData()
    //    do {
    //        try pngImageData!.write(to: URL(fileURLWithPath: path), options: .atomic)
    //    } catch {
    //        print("saveImage Error")
    //        return false
    //    }
    //    return true
    //}
    //
    //func getStepData(step: StepModel,id:Int) -> stepProperty {
    //    var stepProperty = stepProperty(R_x: 0, R_y: 0, R_angle: 0,R_mode: 0, L_x: 0, L_y: 0, L_angle: 0,L_mode: 0, memo: "")
    //    step.stepData.forEach{step in
    //        if step.id == id{
    //            stepProperty.L_x = step.L_x
    //            stepProperty.L_y = step.L_y
    //            stepProperty.L_angle = step.L_angle
    //            stepProperty.L_mode = step.L_mode
    //            stepProperty.R_x = step.R_x
    //            stepProperty.R_y = step.R_y
    //            stepProperty.R_angle = step.R_angle
    //            stepProperty.R_mode = step.R_mode
    //            stepProperty.memo = step.memo
    //        }
    //    }
    //    return stepProperty
    //}
    //
    //
//    extension UIView {
//        func getImage(rect: CGRect) -> UIImage {
//            let renderer = UIGraphicsImageRenderer(bounds: rect)
//            return renderer.image { rendererContext in
//                layer.render(in: rendererContext.cgContext)
//            }
//        }
//    }
    //
    func getPickerSelector(mode: Int) -> String {
        var picker = ""
        switch mode {
        case 0:
            break
        case 1:
            picker = "toes"
        case 2:
            picker = "normal"
        case 3:
            picker = "heals"
        default:
            break
        }
        return picker
    }
    //
    //
    func actionAfterAlert() {
        print("Action after press Ok")
    }
    //

