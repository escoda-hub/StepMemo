//
//  StepDisplay.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/20.
//

import Foundation
import SwiftUI

struct limit {
    var xMax:CGFloat
    var xMin:CGFloat
    var yMax:CGFloat
    var yMin:CGFloat
}

struct StepDisplaySize {
    var minX: Double
    var maxX: Double
    var minY: Double
    var maxY: Double
}

struct FootColor{
    static let right = Color(0x69af86, alpha: 1.0)
    static let left = Color(0xE5BD47, alpha: 1.0)
    static let dragging = Color(0x2E94B9, alpha: 1.0)
}

struct BackgroundColor_StepView{
    static let title = Color(0xDCDCDD, alpha: 1.0)
    static let StepDisplay = Color(0xDCDCDD, alpha: 1.0)
    static let SmallScroll = Color(0xDCDCDD, alpha: 1.0)
    static let memo = Color(0xDCDCDD, alpha: 1.0)
    static let group = Color(0xDCDCDD, alpha: 1.0)
}
