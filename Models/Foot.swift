import SwiftUI

enum Foots: String, Identifiable, CaseIterable {

    case leftEye
    case rightEye
//    case nose
//    case mouth

    var id: String { rawValue }

    // ImageのsystemName
    var imageName: String {
        switch self {
        case .leftEye, .rightEye:
            return "eye"
//        case .nose:
//            return "nose"
//        case .mouth:
//            return "mouth"
        }
    }

    // Positionの初期値
    var defaultPosition: CGPoint {
        switch self {
        case .leftEye:
            return CGPoint(x: 120, y: 130)
        case .rightEye:
            return CGPoint(x: 260, y: 130)
//        case .nose:
//            return CGPoint(x: 190, y: 200)
//        case .mouth:
//            return CGPoint(x: 190, y: 330)
        }
    }
}
