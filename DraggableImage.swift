import SwiftUI

struct limit {
    var xMax:CGFloat
    var xMin:CGFloat
    var yMax:CGFloat
    var yMin:CGFloat
}

struct DraggableImage: View {

    @Binding private var location : CGPoint
    @Binding var location_L: CGPoint
    @Binding var location_R: CGPoint
    @Binding private var angle : Angle
    @Binding var angle_L: Angle
    @Binding var angle_R: Angle
    
    @State private var limit: limit
    @State private var isDragging :Bool
    @State private var flag :Bool
    @State private var isR :Bool

    private let systemName: String
    
    init(location: Binding<CGPoint>, location_L: Binding<CGPoint>, location_R: Binding<CGPoint>, angle: Binding<Angle>, angle_L: Binding<Angle>, angle_R: Binding<Angle>, isDragging: Bool = false, systemName: String, limit: limit, flag: Bool = true, isR: Bool) {
        self._location_L = location_L
        self._location_R = location_R
        self._angle_L = angle_L
        self._angle_R = angle_R
        self.isDragging = isDragging
        self.systemName = systemName
        self.limit = limit
        self.flag = flag
        self.isR = isR
        self._angle = isR ? angle_R : angle_L
        self._location = isR ? location_R : location_L
    }
    
    /// Drag Gesture
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
                //保存処理
            }
    }

    var body: some View {
        VStack{
            Image(systemName)
                .resizable()
                .scaledToFit()
                .foregroundColor(isDragging ? Color(0x2E94B9, alpha: 1.0) : (isR ? Color(0x69af86, alpha: 1.0): Color(0xE5BD47, alpha: 1.0)))
                .rotationEffect(angle,anchor: .center)
                .frame(width: 50)
                .position(location)
                .gesture(dragGesture)
                .gesture(rotation)
        }
    }
}

