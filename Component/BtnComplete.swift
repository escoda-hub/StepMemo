//
//  BtnComplete.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/21.
//

import SwiftUI

struct BtnComplete: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var size:Int
    
    var body: some View {
        
        let isDark = appEnvironment.isDark
        
        VStack {
            Image(systemName: "checkmark.circle")
                .foregroundColor(isDark ? .black : .white)
                .font(.system(size: CGFloat(size)))
        }
        .frame(width: CGFloat(size) * 2, height: CGFloat(size) * 2)
        .background(isDark ? ComponentColor.completeBtn_dark : ComponentColor.completeBtn_light)
        .cornerRadius(CGFloat(size))
    }
}

struct BtnComplete_Previews: PreviewProvider {
    @State static var size = 20
    
    static var previews: some View {
        BtnComplete(size: size)
    }
}
