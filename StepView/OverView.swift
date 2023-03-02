//
//  OverView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/02.
//

import SwiftUI

struct OverView: View {
    
    @State var location_L: CGPoint
    @State var location_R: CGPoint
    @State var angle_L: Angle
    @State var angle_R: Angle
    @State var mode_L: Int
    @State var mode_R: Int
    
    var body: some View {
        
        let deviceWidth = UIScreen.main.bounds.width
        
        ZStack {
            Rectangle()
                .ignoresSafeArea(.all)
                .foregroundColor(Color(0xDCDCDD, alpha: 1.0))
            Image(getImageName(isR: true, mode_R: mode_R, mode_L: mode_L))
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(0x69af86, alpha: 1.0))
                .rotationEffect(angle_R,anchor: .center)
                .position(location_R)
                .frame(width: 10,height: 10)
            Image(getImageName(isR: false, mode_R: mode_R, mode_L: mode_L))
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(0xE5BD47, alpha: 1.0))
                .rotationEffect(angle_L,anchor: .center)
                .position(location_L)
                .frame(width: 10,height: 10)
        }
        .frame(width:deviceWidth/5,height:60)
    }
}

//struct OverView_Previews: PreviewProvider {
//    static var previews: some View {
//        OverView()
//    }
//}
