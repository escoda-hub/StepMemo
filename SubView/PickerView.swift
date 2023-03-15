//
//  PickerView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/09.
//

import SwiftUI

struct PickerView: View {
    
    @State  var GroupName:String
    @State var isR:Bool
    @Binding var mode_L: Int
    @Binding var mode_R: Int
    @Binding var index:Int
    @Binding var stepData:Step
    
    var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 30)
                    .foregroundColor(isR ? Color(0x69af86, alpha: 1.0):Color(0xE5BD47, alpha: 1.0))
                VStack {
                    Picker("",selection: isR ? $mode_R : $mode_L) {
                        Text("toes").tag(1)
                        Text("normal").tag(2)
                        Text("heals").tag(3)
                        Text("float").tag(4)
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 100)
                }
                .onChange(of: isR ? mode_R : mode_L) { mode in
//                    stepData = updateMode(groupName: GroupName, stepName: stepData.title, index: index, isR: isR, mode: mode)
//                    stepData = updateMode(groupName: GroupName, stepName: stepData.title, index: index, isR: isR, mode: mode)
                }
            }
    }
}
