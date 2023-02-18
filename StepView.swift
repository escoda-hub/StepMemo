import SwiftUI

struct stepProperty {
    var R_x: Double
    var R_y: Double
    var R_angle: Double
    var L_x: Double
    var L_y: Double
    var L_angle: Double
}

struct imageSize {
    var minX: Double
    var maxX: Double
    var minY: Double
    var maxY: Double
}

struct StepView: View {
    @State var step: StepList
    @State private var ImageSize = imageSize(minX: 0, maxX: 0, minY: 0, maxY: 0)

    let footMode : [String]
    
    @State private var rightMode : String
    @State private var leftMode : String
    @State private var leftImage : String
    @State private var rightImage : String
    @State private var id :Int
    @State private var location : CGPoint
    @State private var location_L : CGPoint
    @State private var location_R : CGPoint
    @State private var angle : Angle
    @State private var angle_L : Angle
    @State private var angle_R : Angle
    @State private var memo : String
    
    @State var uiImage: UIImage? = nil
    var TestImage = UIImage(named: "flower.png")
    
    init(step: StepList, footMode: [String] = ["toes", "normal", "heals"], rightMode: String = "normal", leftMode: String = "normal", leftImage: String = "L_normal", rightImage: String = "R_normal", id: Int = 1, location: CGPoint = CGPoint(x: 0, y: 0), location_L: CGPoint = CGPoint(x: 0, y: 0), location_R: CGPoint = CGPoint(x: 0, y: 0), angle: Angle = Angle(degrees: 0.0), angle_L: Angle = Angle(degrees: 0.0), angle_R: Angle = Angle(degrees: 0.0), memo: String = "") {
        self.step = step
        self.footMode = footMode
        self.rightMode = rightMode
        self.leftMode = leftMode
        self.leftImage = leftImage
        self.rightImage = rightImage
        self.id = id
        self.location = location
        self.location_L = CGPoint(x: getStepData(step:step,id:1).L_x, y: getStepData(step:step,id:1).L_y)
        self.location_R = CGPoint(x: getStepData(step:step,id:1).R_x, y: getStepData(step:step,id:1).R_y)
        self.angle = angle
        self.angle_L = Angle(degrees: getStepData(step:step,id:1).L_angle)
        self.angle_R = Angle(degrees: getStepData(step:step,id:1).R_angle)
        self.memo = memo
    }
    
    @State var minX = 30
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text(step.title)
                    .font(.title)
            }
            .frame(height: 50)
            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(Color(0xDCDCDD, alpha: 1.0))
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
                        systemName:
                            rightImage ,
                        limit:
                            limit(xMax: geometry.size.width-20,
                                   xMin: 20,
                                   yMax: geometry.size.height-20,
                                   yMin: 20),
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
                        systemName:
                            leftImage ,
                        limit:
                            limit(xMax: geometry.size.width-20,
                                   xMin: 20,
                                   yMax: geometry.size.height-20,
                                   yMin: 20),
                        isR: false
                    )
                }
                .onAppear{
                    ImageSize.minX = geometry.frame(in: .global).minX
                    ImageSize.maxX = geometry.frame(in: .global).maxX
                    ImageSize.minY = geometry.frame(in: .global).minY
                    ImageSize.maxY = geometry.frame(in: .global).maxY
                }
            }
            .frame(height: 300)
            HStack{
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .frame(height: 30)
                        .foregroundColor(Color(0xE5BD47, alpha: 1.0))
                    VStack {
                        Picker("Please choose a color", selection: $leftMode) {
                            ForEach(footMode, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 80)
                        .onChange(of: leftMode) { newValue in
                            switch newValue{
                            case "toes":
                                leftImage = "L_toes"
                            case "normal":
                                leftImage = "L_normal"
                            case "heals":
                                leftImage = "L_heals"
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
                        Picker("Please choose a color", selection: $rightMode) {
                            ForEach(footMode, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 80)
                        .onChange(of: rightMode) { newValue in
                            switch newValue{
                            case "toes":
                                rightImage = "R_toes"
                            case "normal":
                                rightImage = "R_normal"
                            case "heals":
                                rightImage = "R_heals"
                            default:
                                break
                            }
                        }
                    }
                }
                Spacer()
            }
            ScrollView(.horizontal){
                HStack(alignment: .top, spacing: 0) {
                    ForEach(step.stepData, id: \.self) { stepDetail in
                        Text("\(stepDetail.imagename)")
                            .padding(10)
                            .border(Color.gray, width: 1.0)
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
                                memo = stepDetail.memo
                            }
                    }
                }
            }
            Text(memo)
                .border(Color.gray,width: 1.0)
            Button {
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                let window = windowScene?.windows.first
                
                self.uiImage = window?
                                .rootViewController?
                                .view!
                                .getImage(
                                    rect:CGRect(
                                        x: ImageSize.minX,
                                        y: ImageSize.minY,
                                        width: ImageSize.maxX,
                                        height: ImageSize.maxY-ImageSize.minY)
                                )
                if uiImage != nil {
                    UIImageWriteToSavedPhotosAlbum(uiImage!, self, nil, nil)
                }
             } label: {
                 HStack {
                     Image(systemName: "photo.on.rectangle.angled")
                     Text("Add to Photos")
                 }
                 .font(.title)
                 .foregroundColor(.purple)
             }
            if uiImage != nil {
                let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                VStack {
//                    Image(uiImage: self.uiImage!)
                    Text("\(documents)")
                }
            }
            Spacer()//上詰め
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepView(step:stepListData[0])
    }
}

extension Color {
    static let paleOrange = Color(red: 245 / 255,
                                  green: 218 / 255,
                                  blue: 195 / 255,
                                  opacity: 1)
}

func getStepData(step: StepList,id:Int) -> stepProperty {
    var stepProperty = stepProperty(R_x: 0, R_y: 0, R_angle: 0, L_x: 0, L_y: 0, L_angle: 0)
    step.stepData.forEach{step in
        if step.id == id{
            stepProperty.L_x = step.L_x
            stepProperty.L_y = step.L_y
            stepProperty.L_angle = step.L_angle
            stepProperty.R_x = step.R_x
            stepProperty.R_y = step.R_y
            stepProperty.R_angle = step.R_angle
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

