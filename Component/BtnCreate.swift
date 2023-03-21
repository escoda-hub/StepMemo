//
//  BtnCreate.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/21.
//

import SwiftUI

struct BtnCreate: View {
    @State var isDarkMode:Bool
    @State var size:Int
    
    var body: some View {
        VStack {
            Image(systemName: "pencil.tip")
                .foregroundColor(isDarkMode ? .black : .white)
                .font(.system(size: CGFloat(size)))
        }
        .frame(width: CGFloat(size) * 2, height: CGFloat(size) * 2)
        .background(isDarkMode ? ComponentColor.createStepBtn_dark :  ComponentColor.createStepBtn_light)
        .cornerRadius(CGFloat(size))
    }
}

struct BtnCreate_Previews: PreviewProvider {
    @State static var isDarkMode = false
    @State static var size = 20
    
    static var previews: some View {
        BtnCreate(isDarkMode: isDarkMode,size: size)
    }
}
