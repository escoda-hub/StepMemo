//
//  ArrowVIew.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/23.
//

import SwiftUI

struct ArrowVIew: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var size:Int
    @State var isR:Bool
    
    var body: some View {
        
        let isDark = appEnvironment.isDark
        
        VStack {
            Image(systemName: isR ? "arrowtriangle.right" : "arrowtriangle.left")
                .foregroundColor(isDark ? .black : .white)
                .font(.system(size: CGFloat(size)))
        }
        .frame(width: CGFloat(size) * 2, height: CGFloat(size) * 2)
        .background(isDark ? .gray : .gray)
        .cornerRadius(CGFloat(size))
    }
}

struct ArrowVIew_Previews: PreviewProvider {
    
    @State static var size = 20
    @State static var isR = true
    
    static var previews: some View {
        ArrowVIew(size: size,isR: isR)
    }
}
