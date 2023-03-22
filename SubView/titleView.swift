//
//  titleView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/22.
//

import SwiftUI

struct titleView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @Binding var stepData:Step
    @State private var titleText = ""
    @FocusState var isTitleInputActive: Bool
    
    var body: some View {
        
        let isDarkMode = appEnvironment.isDark
        let deviceWidth = DisplayData.deviceWidth
        
        TextField("タイトル", text: $titleText)
            .focused(self.$isTitleInputActive)
            .font(.title)
            .foregroundColor(isDarkMode ? .white : .black)
            .background(isDarkMode ? ComponentColor_StepView.title_dark : ComponentColor_StepView.title_light)
            .frame(width: deviceWidth - (deviceWidth/5))
            .frame(minHeight:40)
            .lineLimit(1)
            .truncationMode(.tail)
            .cornerRadius(5)
            .contentShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button(action: {
                        if isTitleInputActive{
                            titleText = stepData.title
                            self.isTitleInputActive = false
                        }
                    }){
                        BtnCancel(size: 15)
                    }
                    Button(action: {
                        if isTitleInputActive{
                            stepData = upDateTitle(step_id: stepData.id, title: titleText)
                            self.isTitleInputActive = false
                        }
                    }){
                        BtnComplete(size: 15)
                    }
                }
            }
            .onAppear(){
                titleText = stepData.title
            }
        
    }
}

//struct titleView_Previews: PreviewProvider {
//    static var previews: some View {
//        titleView()
//    }
//}
