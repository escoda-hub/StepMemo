//
//  titleInputView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/11.
//

import SwiftUI

struct titleInputView: View {
    
    @FocusState private var isFocused: Bool
    @Binding var stepData:Step
    @Binding var showTitleView : Bool
    
     var body: some View {
         VStack {
             Text("タイトル編集")
             Text("\(stepData.title)")
             TextField("Enter text", text: $stepData.title)
                 .keyboardType(.asciiCapable)
                 .focused(self.$isFocused)
                 .border(isFocused ? Color.blue : Color.gray)
                 .onAppear(){
                     self.isFocused = true
                 }

             Button(action: {
                 stepData = upDateTitle(step_id: stepData.id, title: stepData.title)
                 showTitleView = false
             }){
                 HStack {
 //                    Spacer()
                     Image(systemName: "checkmark.circle")
 //                    Spacer()
                     Text("完了")
 //                    Spacer()
                 }
                 .fontWeight(.semibold)
                 .frame(width: 160, height: 48)
                 .foregroundColor(Color(.black))
                 .background(Color(.white))
                 .cornerRadius(24)
                 .overlay(
                     RoundedRectangle(cornerRadius: 24)
                         .stroke(Color(.black), lineWidth: 1.0)
                 )
             }
         }
     }
}
