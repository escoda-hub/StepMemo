//
//  InformationView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/18.
//

import SwiftUI

struct InformationView: View {
    @State private var isPresented = false
    
    @State var stepData:Step
    
    
    var body: some View {
        Text("\(stepData)")
        Button("Show Modal") {
            self.isPresented.toggle()
        }
        .sheet(isPresented: $isPresented) {
            ModalView()
                .background(Color.white.opacity(0.5))
        }
        .onAppear(){
//            stepData = getStepData(groupName: GroupName, stepName: title)
            
        }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            Text("This is a modal view.")
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
    }
}
