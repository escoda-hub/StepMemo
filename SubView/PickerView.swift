//
//  PickerView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/09.
//

import SwiftUI

struct PickerView: View {
    
    @State var mode:String
    @State var isR:Bool
    @State var mode_L:Int
    @State var mode_R:Int
    
    var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 30)
                    .foregroundColor(isR ? Color(0xE5BD47, alpha: 1.0):Color(0x69af86, alpha: 1.0))
                VStack{
                    Picker("", selection: $mode) {
                        Label("toes", systemImage: "1.lane").tag("toes")
                        Label("normal", systemImage: "2.lane").tag("normal")
                        Label("heals", systemImage: "3.lane").tag("heals")
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 100)
                    .onChange(of: mode) { newValue in
                        switch newValue{
                        case "toes":
                            mode_L = 1
                        case "normal":
                            mode_L = 2
                        case "heals":
                            mode_L = 3
                        default:
                            break
                        }
                    }
                }
            }
    }
}

//struct PickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerView()
//    }
//}
