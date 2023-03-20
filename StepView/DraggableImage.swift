import SwiftUI

struct DraggableImage: View {

    @Binding private var indexSmallView:Int
    @State private var isR:Bool
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
    
    init(indexSmallView: Binding<Int>, isR: Bool, location:Binding<CGPoint>,location_L: Binding<CGPoint>, location_R: Binding<CGPoint>, angle: Binding<Angle>,angle_L: Binding<Angle>, angle_R: Binding<Angle>,mode: Binding<Int>,mode_L: Binding<Int>, mode_R: Binding<Int>, limit: limit,stepData:Binding<Step>) {
        self._indexSmallView = indexSmallView
        self.isR = isR
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
                stepData = updateStepDetail(step_id: stepData.id, index: indexSmallView, isR: isR, location: location, angle:angle)
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
                stepData = updateStepDetail(step_id: stepData.id, index: indexSmallView, isR: isR, location: location, angle:angle)
            }
    }

    var body: some View {
        VStack{
            Image(getImageName(isR: isR, mode_R: mode_R, mode_L: mode_L))
                .resizable()
                .scaledToFit()
                .foregroundColor(isDragging ? FootColor.dragging : (isR ? FootColor.right: FootColor.left))
                .rotationEffect(isR ? angle_R : angle_L,anchor: .center)
                .frame(width: 50)
                .position(isR ? location_R:location_L)
                .gesture(dragGesture)
                .gesture(rotation)
        }
        .onAppear(){
            if let stepDetailData = Array(stepData.stepDetails).first {
                location = isR ? CGPoint(x: stepDetailData.R_x, y: stepDetailData.R_y) : CGPoint(x: stepDetailData.L_x, y: stepDetailData.L_y)
                angle = isR ? Angle(degrees: stepDetailData.R_angle) : Angle(degrees: stepDetailData.L_angle)
                mode_R = stepDetailData.R_mode
                mode_L = stepDetailData.L_mode
            }
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
