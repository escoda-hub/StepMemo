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
            Text("メモ入力欄")
            TextField("メモ", text: $stepData.stepDetails[index - 1].memo,axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .border(isFocused ? Color.blue : Color.gray)
                .padding(.horizontal)
                .lineLimit(3...5)
                .keyboardType(.asciiCapable)
                .focused(self.$isFocused)
                .onAppear(){
                    self.isFocused = true
                }

            Button(action: {
                if let updatedMemo = updateMemo(step_id: stepData.id, index: index, memo: stepData.stepDetails[index - 1].memo) {
                    stepData = updatedMemo
                }
                showMemoView = false
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
