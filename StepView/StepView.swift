import SwiftUI

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

struct StepView: View {
    @State var step: StepList
    @State var ImageSize :imageSize
    let screenSizeWidth = UIScreen.main.bounds.width
    let footMode : [String]
    @State private var rightMode : String
    @State private var leftMode : String

    @State private var id :Int
    @State private var location : CGPoint
    @State private var location_L : CGPoint
    @State private var location_R : CGPoint
    @State private var angle : Angle
    @State private var angle_L : Angle
    @State private var angle_R : Angle
    @State private var mode : Int
    @State private var mode_L : Int
    @State private var mode_R : Int
    @State private var memo : String
    @State private var title : String
    @State private var category : String
    
    @State var uiImage: UIImage? = nil
    var TestImage = UIImage(named: "flower.png")
    
    @State private var selectedGroup = ""
    
    @State var showingAlert: Bool = false
  
    init(step: StepList, ImageSize: imageSize=imageSize(minX: 0, maxX: 0, minY: 0, maxY: 0), footMode: [String] = [], rightMode: String = "", leftMode: String = "", id: Int=1, location: CGPoint = CGPoint(x: 0, y: 0), location_L: CGPoint = CGPoint(x: 0, y: 0), location_R: CGPoint = CGPoint(x: 0, y: 0), angle: Angle = Angle(degrees: 0.0), angle_L: Angle = Angle(degrees: 0.0), angle_R: Angle = Angle(degrees: 0.0), mode: Int = 0, mode_L: Int = 0, mode_R: Int = 0, memo: String = "",title:String = "",category:String = "",uiImage: UIImage? = nil) {
        self.step = step
        self.ImageSize = imageSize(minX: 0, maxX: 0, minY: 0, maxY: 0)
        self.footMode = ["toes", "normal", "heals"]
        self.id = 1
        self.location = location
        self.location_L = CGPoint(x: getStepData(step:step,id:id).L_x,
                                  y: getStepData(step:step,id:id).L_y)
        self.location_R = CGPoint(x: getStepData(step:step,id:id).R_x,
                                  y: getStepData(step:step,id:id).R_y)
        self.angle = angle
        self.angle_L = Angle(degrees: getStepData(step:step,id:id).L_angle)
        self.angle_R = Angle(degrees: getStepData(step:step,id:id).R_angle)
        self.mode = mode
        self.mode_L = getStepData(step:step,id:id).L_mode
        self.mode_R = getStepData(step:step,id:id).R_mode
        self.rightMode = getPickerSelector(mode:getStepData(step:step,id:id).R_mode)
        self.leftMode = getPickerSelector(mode: getStepData(step:step,id:id).L_mode)
        self.memo = getStepData(step:step,id:id).memo
        self.uiImage = uiImage
        self.title = step.title
        self.category = step.category
    }
    
    var body: some View {

            VStack{
                HStack {
                    TextField("タイトル", text: $title)
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
                            location:
                                $location,
                            location_L:
                                $location_L,
                            location_R:
                                $location_R,
                            angle:
                                $angle,
                            angle_L:
                                $angle_L,
                            angle_R:
                                $angle_R,
                            mode:
                                $mode,
                            mode_L:
                                $mode_L,
                            mode_R:
                                $mode_R,
                            limit:
                                limit(xMax: geometry.size.width-30,//-30
                                      xMin: 20,//20
                                      yMax: geometry.size.height-40,//-40
                                      yMin: 40),//40
                            isR: true
                        )
                        DraggableImage(
                            location:
                                $location,
                            location_L:
                                $location_L,
                            location_R:
                                $location_R,
                            angle:
                                $angle,
                            angle_L:
                                $angle_L,
                            angle_R:
                                $angle_R,
                            mode:
                                $mode,
                            mode_L:
                                $mode_L,
                            mode_R:
                                $mode_R,
                            limit:
                                limit(xMax: geometry.size.width-30,
                                      xMin: 20,
                                      yMax: geometry.size.height-40,
                                      yMin: 40),
                            isR: false
                        )
                    }
                }
                .padding(.horizontal, 10)
                .frame(height: 300)
                
                //Small Window reagin
                HStack {
                    ScrollView(.horizontal){
                        HStack {
                            HStack(alignment: .top, spacing: 0) {
                                ForEach(step.stepData, id: \.self) { stepDetail in
                                    ZStack {
                                        Image("debugdata")
                                            .resizable()
                                            .frame(width:50,height: 50)
                                            .padding(3)
                                            .border(stepDetail.id == id ? Color.gray : Color.white, width: stepDetail.id == id ? 2.0 : 0)
                                            .onTapGesture {
                                                id = stepDetail.id
                                                location = CGPoint(x: 0, y: 0)
                                                location_L = CGPoint(
                                                    x: getStepData(step:step,id:id).L_x,
                                                    y: getStepData(step:step,id:id).L_y)
                                                location_R = CGPoint(
                                                    x: getStepData(step:step,id:id).R_x,
                                                    y: getStepData(step:step,id:id).R_y)
                                                angle = Angle(degrees: 0)
                                                angle_L = Angle(degrees: getStepData(step:step,id:id).L_angle)
                                                angle_R = Angle(degrees: getStepData(step:step,id:id).R_angle)
                                                mode = 0
                                                mode_L = getStepData(step:step,id:id).L_mode
                                                mode_R = getStepData(step:step,id:id).R_mode
                                                memo = getStepData(step:step,id:id).memo
                                                rightMode = getPickerSelector(mode: mode_R)
                                                leftMode = getPickerSelector(mode: mode_L)
                                        }
                                        .onLongPressGesture {
                                            id = stepDetail.id
                                            showingAlert = true
                                        }
                                        Text("\(stepDetail.id)")
                                            .foregroundColor(.black)
                                    }
                                }
                            }//H_stack:small image view
                        }//H_staqck
                    }
                    .padding(.horizontal)
                    .alert(isPresented: $showingAlert) { () -> Alert in
                                    Alert(
                                        title: Text("確認"),
                                        message: Text("\(id)番目のデータを削除してもよろしいですか？"),
                                        primaryButton: .default(Text("Ok"),
                                                        action: {
                                                            actionAfterAlert()
                                                            }
                                                        ),
                                        secondaryButton: .default(Text("キャンセル")                      )
                                    )
                    }
                    Button(action: {
                        print("add")
                    }, label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width:30,height:30)
                    })
                    .padding(.trailing)
                }
                
                //Picker Region
                HStack{
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .frame(height: 30)
                            .foregroundColor(Color(0xE5BD47, alpha: 1.0))
                        VStack{
                            Picker("", selection: $leftMode) {
                                Label("toes", systemImage: "1.lane").tag("toes")
                                Label("normal", systemImage: "2.lane").tag("normal")
                                Label("heals", systemImage: "3.lane").tag("heals")
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 100)
                            .onChange(of: leftMode) { newValue in
                                switch newValue{
                                case "toes":
                                    mode_L = 1
                                case "normal":
                                    mode_L = 2
                                case "heals":
                                    mode_L = 3
                                default:
                                    break
                                }
                            }
                        }
                    }
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .frame(height: 30)
                            .foregroundColor(Color(0x69af86, alpha: 1.0))
                        VStack {
                            Picker("", selection: $rightMode) {
                                Label("toes", systemImage: "1.lane").tag("toes")
                                Label("normal", systemImage: "2.lane").tag("normal")
                                Label("heals", systemImage: "3.lane").tag("heals")
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 100)
                            .onChange(of: rightMode) { newValue in
                                switch newValue{
                                case "toes":
                                    mode_R = 1
                                case "normal":
                                    mode_R = 2
                                case "heals":
                                    mode_R = 3
                                default:
                                    break
                                }
                            }
                        }
                    }
                    Spacer()
                }
                TextField("メモ", text: $memo,axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .lineLimit(3...5)
                NavigationLink(destination: SeleclGroupView(selectedGroup: $selectedGroup)) {
                    HStack {
                        HStack {
                            Image(systemName: "rectangle.3.group")
                            Text("Group")
                        }
                        .padding()
                        Spacer()
                        HStack {
                            Text(selectedGroup)
                            .foregroundColor(.blue)
                            Image(systemName: "chevron.forward")
                                .padding(.trailing)
                        }
                    }
                }
                .frame(height:35,alignment:.center)
                .background(Color(0xcccccc, alpha: 1.0))
                .foregroundColor(.black)
                .cornerRadius(CGFloat(5))
                .padding(.horizontal)
                Button {
                    self.uiImage =
                        UIApplication
                        .shared
                        .connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first?
                        .rootViewController?
                        .view!
                        .getImage(rect: CGRect(
                            x: ImageSize.minX,//padding
                            y: ImageSize.minY,
                            width: ImageSize.maxX-ImageSize.minX,
                            height: ImageSize.maxY-ImageSize.minY))
                    if uiImage != nil {
                        saveImage(image: uiImage!, path: ImageInDocumentsDirectory(filename: "hihi.png"))
                    }
                } label: {
                    HStack {
                        Text("Add to Photos")
                    }
                    .foregroundColor(.purple)
                }
                Spacer()
            }
        }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepView(step:stepListData[2])
    }
}

func ImageInDocumentsDirectory(filename: String) -> String {
    
    let fileManager = FileManager.default
    let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let directory = documentDirectoryFileURL.appendingPathComponent("TestDirectory", isDirectory: true)
    do {
        try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        
    } catch {
        print("createDirectoryに失敗しました")
    }
    
    let fileURL = directory.appendingPathComponent(filename)
    print(fileURL)
    
    return fileURL.path
}

func getDocumentsURL() -> NSURL {
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
    return documentsURL
}

func saveImage (image: UIImage, path: String ) -> Bool {
    let pngImageData = image.pngData()
    do {
        try pngImageData!.write(to: URL(fileURLWithPath: path), options: .atomic)
    } catch {
        print("saveImage Error")
        return false
    }
    return true
}

func getStepData(step: StepList,id:Int) -> stepProperty {
    var stepProperty = stepProperty(R_x: 0, R_y: 0, R_angle: 0,R_mode: 0, L_x: 0, L_y: 0, L_angle: 0,L_mode: 0, memo: "")
    step.stepData.forEach{step in
        if step.id == id{
            stepProperty.L_x = step.L_x
            stepProperty.L_y = step.L_y
            stepProperty.L_angle = step.L_angle
            stepProperty.L_mode = step.L_mode
            stepProperty.R_x = step.R_x
            stepProperty.R_y = step.R_y
            stepProperty.R_angle = step.R_angle
            stepProperty.R_mode = step.R_mode
            stepProperty.memo = step.memo
        }
    }
    return stepProperty
}

extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}

extension UIView {
    func getImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

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


func actionAfterAlert() {
    print("Action after press Ok")
}
