//
//  PickerView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/09.
//

import SwiftUI

struct PickerView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State  private var isDarkMode = true
    @State var isR:Bool
    @Binding var mode_L: Int
    @Binding var mode_R: Int
    @Binding var index:Int
    @Binding var stepData:Step
    
    var body: some View {
        
        let deviceWidth = DisplayData.deviceWidth
        let isDarkMode = appEnvironment.isDark

            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 30)
                    .foregroundColor(isR ? FootColor.right:FootColor.left)
                VStack {
                    Picker("",selection: isR ? $mode_R : $mode_L) {
                        Text("toes").tag(1)
                            .foregroundColor(isDarkMode ? .white : .black)
                        Text("normal").tag(2)
                            .foregroundColor(isDarkMode ? .white : .black)
                        Text("heals").tag(3)
                            .foregroundColor(isDarkMode ? .white : .black)
                        Text("float").tag(4)
                            .foregroundColor(isDarkMode ? .white : .black)
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 100)
                }
                .onChange(of: isR ? mode_R : mode_L) { mode in
                    stepData = updateMode(step_id: stepData.id, index: index, isR: isR, mode: mode)
                }
            }
            .frame(width: (deviceWidth - (deviceWidth/5)) / 2 )
    }
}
