//
//  PickerView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/09.
//

import SwiftUI

struct PickerView: View {
    
    @State var isR:Bool
    @Binding var mode: Int
    @Binding var mode_L: Int
    @Binding var mode_R: Int
    
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
                    .onChange(of: getPickerSelector(mode: isR ? mode_R : mode_L)) { newValue in
                        if isR{
                            switch newValue{
                            case "toes":
                                mode_R = 1
                            case "normal":
                                mode_R = 2
                            case "heals":
                                mode_R = 3
                            default:
                                break
                            }
                        }else{
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
}

func getPickerSelector(mode: Int) -> String {
    var picker = ""
    switch mode {
    case 0:
        break
    case 1:
        picker = "toes"
    case 2:
        picker = "normal"
    case 3:
        picker = "heals"
    default:
        break
    }
    return picker
}
