//
//  BtnComplete.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/21.
//

import SwiftUI

struct BtnComplete: View {
    @State var isDarkMode:Bool
    
    var body: some View {
        
        HStack {
            Image(systemName: "checkmark.circle")
            Text("完了")
        }
        .fontWeight(.semibold)
        .frame(width: 100, height: 48)
        .foregroundColor(isDarkMode ? .black : .white)
        .background(isDarkMode ? ComponentColor.completeBtn_dark : ComponentColor.completeBtn_light)
        .cornerRadius(24)
    }
}

struct BtnComplete_Previews: PreviewProvider {
    @State static var isDarkMode = true
    
    static var previews: some View {
        BtnComplete(isDarkMode: isDarkMode)
    }
}
