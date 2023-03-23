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
    @State private var isDark = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        let steps = [
            WalkthroughStep(title: "\(system.appName)にようこそ", description: "\(system.appName)は\nステップを直感的に記録できるツールです。",image:isDark ? "walkthrough_dark":"walkthrough_light"),
            WalkthroughStep(title: "管理", description: "グループごとにステップを管理",image:isDark ? "StepList_dark":"StepList_light"),
            WalkthroughStep(title: "記録", description: "ドラッグでステップを直感的に記録",image:isDark ? "Step_dark":"Step_light")
        ]
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDark ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDark ? 0 : 1)
            VStack {
                WalkthroughStepView(step: steps[currentStep])
                    .padding()
                
                HStack {
                    
                    Button(action: {
                        if currentStep > 0 {
                            currentStep -= 1
                        }
                    }, label: {
                        ArrowVIew(size: 15,isR: false)
                    })
                    .disabled(currentStep == 0)
                    
                    Spacer()
                    
                    Button(action: {
                        if currentStep < steps.count - 1 {
                            currentStep += 1
                        }
                    }, label: {
                        ArrowVIew(size: 15,isR: true)
                    })
                    .disabled(currentStep == steps.count - 1)

                }
                .padding()
                
                Button(action: {
                    dismiss()
                }, label: {
                    BtnComplete(size: 20)
                })
                .opacity(currentStep != steps.count - 1 ? 0:1)
            }
        }
        .onAppear(){
            isDark = appEnvironment.isDark
        }
    }
}

struct WalkthroughStep {
    let title: String
    let description: String
    let image: String
}

struct WalkthroughStepView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    let step: WalkthroughStep
    
    var body: some View {

            VStack {
                VStack {
                    Text(step.title)
                        .foregroundColor( appEnvironment.isDark ? .white : .black)
                        .font(.headline)
                        .bold()
                        .padding(.bottom)
                    Text(step.description)
                        .font(.subheadline)
                        .foregroundColor( appEnvironment.isDark ? .white : .black)
                        .multilineTextAlignment(.center)
                }

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
