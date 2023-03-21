//
//  BtnCancel.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/21.
//

import SwiftUI

struct BtnCancel: View {
    @State var isDarkMode = true
    @State var size = 30
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.circle")
                .foregroundColor(isDarkMode ? .black : .white)
                .font(.system(size: CGFloat(size)))
        }
        .frame(width: CGFloat(size) * 2, height: CGFloat(size) * 2)
        .background(ComponentColor.cancelBtn)
        .cornerRadius(CGFloat(size))
    }
}

struct BtnCancel_Previews: PreviewProvider {
    @State static var isDarkMode = true
    @State static var size = 20
    
    static var previews: some View {
        BtnCancel(isDarkMode: isDarkMode,size: size)
    }
}


