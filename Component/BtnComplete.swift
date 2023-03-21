//
//  BtnComplete.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/21.
//

import SwiftUI

struct BtnComplete: View {
    @State var isDarkMode:Bool
    @State var size:Int
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle")
                .foregroundColor(isDarkMode ? .black : .white)
                .font(.system(size: CGFloat(size)))
        }
        .frame(width: CGFloat(size) * 2, height: CGFloat(size) * 2)
        .background(isDarkMode ? ComponentColor.completeBtn_dark : ComponentColor.completeBtn_light)
        .cornerRadius(CGFloat(size))
//        .disabled(isDisable)
    }
}

struct BtnComplete_Previews: PreviewProvider {
    @State static var isDarkMode = true
    @State static var size = 20
    
    static var previews: some View {
        BtnComplete(isDarkMode: isDarkMode,size: size)
    }
}
