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
    
    init(stepData: Binding<Step>, showTitleView: Binding<Bool>) {
        self._stepData = stepData
        self._showTitleView = showTitleView
    }
    
     var body: some View {
         VStack {
             Text("タイトル編集")
             TextField("Enter text", text: $stepData.title)
                 .focused($isFocused)
                 .border(isFocused ? Color.blue : Color.gray)
             Button("完了") {
                 showTitleView = false
             }
         }
         
     }
}