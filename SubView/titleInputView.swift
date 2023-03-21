//
//  titleInputView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/11.
//

import SwiftUI

struct titleInputView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @FocusState private var isFocused: Bool
    @Binding var stepData:Step
    @Binding var showTitleView : Bool
    @State  private var isDarkMode = true
    @State  private var title = ""
    
    var body: some View {
        
        let isDarkMode = appEnvironment.isDark

            ZStack {
                ComponentColor.background_dark.ignoresSafeArea()
                    .opacity(isDarkMode ? 1 : 0)
                ComponentColor.background_light.ignoresSafeArea()
                    .opacity(isDarkMode ? 0 : 1)
                VStack {
                    HStack{
                        Button(action: {
                            showTitleView = false
                        }){
                            BtnCancel(isDarkMode: isDarkMode,size: 15)
                                .padding()
                        }
                        Spacer()
                        Button(action: {
                            stepData = upDateTitle(step_id: stepData.id, title: title)
                            showTitleView = false
                        }){
                            BtnComplete(isDarkMode: isDarkMode, size: 15)
                                .padding()
                        }
                    }
                    Spacer()
                    VStack {
                         Text("タイトル編集")
                            .foregroundColor(isDarkMode ? .white : .black)
                         TextField("Enter text", text: $title)
                            .border(isFocused ? Color.blue : Color.gray)
                            .foregroundColor(isDarkMode ? .white : .black)
                            .background(isDarkMode ? ComponentColor_StepView.title_dark : ComponentColor_StepView.title_light)
                            .padding(.horizontal)
                            .keyboardType(.asciiCapable)
                            .focused(self.$isFocused)
                            .onAppear(){
                                 self.isFocused = true
                                title = stepData.title
                             }
                    }
                    Spacer()
                }
            }
        
     }
}
