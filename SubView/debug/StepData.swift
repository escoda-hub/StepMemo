//
//  StepData.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/18.
//

import SwiftUI

struct StepData: View {
    
    @State var stepData:Step
    
    var body: some View {
        Text("\(stepData)")
    }
}

//struct StepData_Previews: PreviewProvider {
//    static var previews: some View {
//        StepData()
//    }
//}
