//
//  BtnCreate.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/21.
//

import SwiftUI

struct BtnCreate: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var size:Int
    
    var body: some View {
        
        let isDark = appEnvironment.isDark
        
        VStack {
            Image(systemName: "pencil.tip")
                .foregroundColor(isDark ? .black : .white)
                .font(.system(size: CGFloat(size)))
        }
        .frame(width: CGFloat(size) * 2, height: CGFloat(size) * 2)
        .background(isDark ? ComponentColor.createStepBtn_dark :  ComponentColor.createStepBtn_light)
        .cornerRadius(CGFloat(size))
//        .shadow(color:isDark ? .black : .white, radius: 3, x: 3, y: 3)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0.0, trailing: 30.0))
    }
}

struct BtnCreate_Previews: PreviewProvider {
    @State static var size = 20
    
    static var previews: some View {
        BtnCreate(size: size)
    }
}
