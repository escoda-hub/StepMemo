//
//  Route.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/20.
//

import Foundation
import SwiftUI

enum Route:Hashable{
    case filterView(String)
    case stepView(Step)
    case informationView
    case walkthroughView
    case stepListView(Group)
    case mainView
    case termsOfServiceView
    case privacyPolicyView
}
