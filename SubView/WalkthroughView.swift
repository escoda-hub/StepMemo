//
//  WalkthroughView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/18.
//

import SwiftUI

struct WalkthroughView: View {
    @State private var currentStep = 0
    @Environment(\.dismiss) var dismiss
    
    let steps = [
        WalkthroughStep(title: "Step 1", description: "This is step 1"),
        WalkthroughStep(title: "Step 2", description: "This is step 2"),
        WalkthroughStep(title: "Step 3", description: "This is step 3")
    ]
    
    var body: some View {
        VStack {
            WalkthroughStepView(step: steps[currentStep])
                .padding()
            
            HStack {
                Button("Back") {
                    if currentStep > 0 {
                        currentStep -= 1
                    }
                }
                .disabled(currentStep == 0)
                
                Spacer()
                
                Button("Next") {
                    if currentStep < steps.count - 1 {
                        currentStep += 1
                    }
                }
                .disabled(currentStep == steps.count - 1)
            }
            .padding()
            
            Button(action: {
                dismiss()
            }, label: {
                Text("完了")
            })
//            .disabled(currentStep != steps.count - 1)
            .opacity(currentStep != steps.count - 1 ? 0:1)
        }
//        .navigationBarBackButtonHidden(true)
    }
    
}

struct WalkthroughStep {
    let title: String
    let description: String
}

struct WalkthroughStepView: View {
    let step: WalkthroughStep
    
    var body: some View {
        VStack {
            Text(step.title)
                .font(.title)
                .padding()
            
            Text(step.description)
                .padding()
        }
    }
}
