//
//  WalkthroughView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/18.
//

import SwiftUI

struct WalkthroughView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State private var currentStep = 0
    @Environment(\.dismiss) var dismiss
    
    let steps = [
        WalkthroughStep(title: "\(system.appName)にようこそ", description: "ふと思いついたステップ。\n見とれたステップ。\nそんなステップを記録できるツール。\nそれがStepDraft。",image:"logo"),
        WalkthroughStep(title: "管理", description: "グループごとにステップを管理",image:"main"),
        WalkthroughStep(title: "記録", description: "ドラッグでステップを直感的に記録",image:"stepView")
    ]
    
    var body: some View {
        
//        let isDark = appEnvironment.isDark
        let isDark = true
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDark ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDark ? 0 : 1)
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
                .opacity(currentStep != steps.count - 1 ? 0:1)
            }
        }
    }
    
}

struct WalkthroughStep {
    let title: String
    let description: String
    let image: String
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
                    .multilineTextAlignment(.center)
                Image(step.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)
            }
            .foregroundColor(.white)
        
    }
}

struct WalkthroughView_Previews: PreviewProvider {
    @State static var size = 20
    
    static var previews: some View {
        WalkthroughView()
    }
}
