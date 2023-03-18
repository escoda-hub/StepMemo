//
//  StepData.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/18.
//

import SwiftUI

struct StepData: View {
    
    @Binding var stepData:Step
    
    var body: some View {
        VStack {
            Text("step ID: \(stepData.id)")
            Text("Group ID: \(stepData.group_id)")
            Text("Title: \(stepData.title)")
            Text("Created At: \(stepData.created_at)")
            Text("Updated At: \(stepData.updated_at)")
            Text("Favorite: \(stepData.favorite.description)")
        }
    }
    
}
