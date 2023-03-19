//
//  memoInputView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/11.
//

import SwiftUI

struct memoInputView: View {
    
    @FocusState private var isFocused: Bool
    @Binding var stepData:Step
    @Binding var showMemoView : Bool
    @State var index:Int
    
    var body: some View {
        VStack {
            Text("\(index)")
            TextField("メモ", text: $stepData.stepDetails[index - 1].memo,axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .lineLimit(3...5)
                .keyboardType(.asciiCapable)
                .focused(self.$isFocused)
                .border(isFocused ? Color.blue : Color.gray)
                .onAppear(){
                    self.isFocused = true
                }
            Button("完了") {
                showMemoView = false
                stepData = updateMemo(step_id: stepData.id, index: index, memo: stepData.stepDetails[index - 1].memo)!
            }
        }
    }
}
