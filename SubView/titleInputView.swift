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
    @State  var GroupName:String
    
     var body: some View {
         VStack {
             Text("タイトル編集")
             Text("\(GroupName)")
             Text("\(stepData.title)")
             TextField("Enter text", text: $stepData.title)
                 .focused($isFocused)
                 .border(isFocused ? Color.blue : Color.gray)
             Button("完了") {
                 stepData = upDateTitle(step_id: stepData.id, title: stepData.title)
                 showTitleView = false
             }
         }
     }
}
