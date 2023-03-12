import SwiftUI

struct limit {
    var xMax:CGFloat
    var xMin:CGFloat
    var yMax:CGFloat
    var yMin:CGFloat
}

struct DraggableImage: View {
    
    @State private var GroupName:String
    @State private var StepTitle:String
    @Binding private var Index:Int
    @State private var isR:Bool
    @State private var stepDetail:StepDetail
    @Binding var location_L: CGPoint
    @Binding var location_R: CGPoint
    @Binding var location  : CGPoint
    @Binding var angle_L: Angle
    @Binding var angle_R: Angle
    @Binding var angle: Angle
    @Binding var mode: Int
    @Binding var mode_L: Int
    @Binding var mode_R: Int
    @State private var limit: limit
    @State private var isDragging = false
    @Binding var stepData:Step
    
    init(GroupName: String, StepTitle: String, Index: Binding<Int>, isR: Bool, stepDetail: StepDetail = StepDetail(), location:Binding<CGPoint>,location_L: Binding<CGPoint>, location_R: Binding<CGPoint>, angle: Binding<Angle>,angle_L: Binding<Angle>, angle_R: Binding<Angle>,mode: Binding<Int>,mode_L: Binding<Int>, mode_R: Binding<Int>, limit: limit,stepData:Binding<Step>) {
        self.GroupName = GroupName
        self.StepTitle = StepTitle
        self._Index = Index
        self.isR = isR
        self.stepDetail = stepDetail
        self._location_L = location_L
        self._location_R = location_R
        self._location = isR ? location_R : location_L
        self._angle_L = angle_L
        self._angle_R = angle_R
        self._angle = isR ? angle_R : angle_L
        self._mode_L = mode_L
        self._mode_R = mode_R
        self._mode = isR ? mode_R : mode_L
        self.limit = limit
        self._stepData = stepData
    }
    
    // Drag Gesture
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if (value.location.x < limit.xMax
                    && value.location.x > limit.xMin
                    && value.location.y < limit.yMax
                    && value.location.y > limit.yMin)
                {
                    location = value.location
                }
                isDragging = true
            }
            .onEnded { _ in
                isDragging = false
                stepData = updateStepDetail(groupName: GroupName, stepName: stepData.title, index: Index+1, isR: isR, location: location, angle:angle)
            }
    }

    var rotation: some Gesture {
        RotationGesture()
            .onChanged { value in
                angle = value
                isDragging = true
            }
            .onEnded { _ in
                isDragging = false
                stepData = updateStepDetail(groupName: GroupName, stepName: stepData.title, index: Index+1, isR: isR, location: location, angle:angle)
            }
    }

    var body: some View {
        VStack{
            Image(getImageName(isR: isR, mode_R: mode_R, mode_L: mode_L))
                .resizable()
                .scaledToFit()
                .foregroundColor(isDragging ? Color(0x2E94B9, alpha: 1.0) : (isR ? Color(0x69af86, alpha: 1.0): Color(0xE5BD47, alpha: 1.0)))
                .rotationEffect(isR ? angle_R : angle_L,anchor: .center)
                .frame(width: 50)
                .position(isR ? location_R:location_L)
                .gesture(dragGesture)
                .gesture(rotation)
        }
        .onAppear(){
            stepDetail = getStepDetailData(groupName: GroupName, stepName: StepTitle, index: Index)
            location = isR ? CGPoint(x: stepDetail.R_x, y: stepDetail.R_y) : CGPoint(x: stepDetail.L_x, y: stepDetail.L_y)
            angle = isR ? Angle(degrees: stepDetail.R_angle) : Angle(degrees: stepDetail.L_angle)
            mode_R = stepDetail.R_mode
            mode_L = stepDetail.L_mode
        }
    }
}

func getImageName(isR: Bool,mode_R: Int,mode_L: Int) -> String {
    var imageName = ""
    
    if isR {
        switch mode_R {
            case 0:
                break
            case 1:
                imageName = "R_toes"
            case 2:
                imageName = "R_normal"
            case 3:
                imageName = "R_heals"
            default:
                break
        }
    }else{
        switch mode_L {
            case 0:
                break
            case 1:
                imageName = "L_toes"
            case 2:
                imageName = "L_normal"
            case 3:
                imageName = "L_heals"
            default:
                break
        }
    }

    return imageName
}
