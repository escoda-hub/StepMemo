//
//  memoInputView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/11.
//

import SwiftUI

struct memoInputView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @FocusState private var isFocused: Bool
    @Binding var stepData:Step
    @Binding var showMemoView : Bool
    @State var index:Int
    @State  private var isDarkMode = true
    
    var body: some View {
        
        let isDarkMode = appEnvironment.isDark
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDarkMode ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDarkMode ? 0 : 1)
            VStack {
                HStack{
                    Spacer()
                    Button(action: {
                        showMemoView = false
                    }){
                        BtnCancel(isDarkMode: isDarkMode,size: 20)
                            .padding()
                    }
                }
                Spacer()
                VStack {
                    Text("メモ入力欄")
                        .foregroundColor(isDarkMode ? .white : .black)
                    TextField("メモ", text: $stepData.stepDetails[index - 1].memo,axis: .vertical)
                        .border(isFocused ? Color.blue : Color.gray)
                        .foregroundColor(isDarkMode ? .white : .black)
                        .background(isDarkMode ? ComponentColor_StepView.memo_dark : ComponentColor_StepView.memo_light)
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
                        BtnComplete(isDarkMode: isDarkMode)
                    }
                }
                Spacer()
            }
        }
    }
}
