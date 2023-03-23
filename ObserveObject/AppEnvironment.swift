//
//  AppEnvironment.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/19.
//

import Foundation
import SwiftUI

class AppEnvironment: ObservableObject {
//    @Published var otherPath: [Route] = [] //if you use other path,add here.
    @Published var path: [Route] = []
    @Published var isDark: Bool = false
    @Published var reload: Bool = false
}

