//
//  OverView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/02.
//

import SwiftUI

struct OverView: View {
    
    @State var index:Int
    @Binding var stepData:Step
  
    init(index: Int, stepData: Binding<Step>) {
        self.index = index
        self._stepData = stepData
    }
    
    var body: some View {
        
        let deviceWidth = UIScreen.main.bounds.width
        
        ZStack {
            Rectangle()
                .ignoresSafeArea(.all)
                .foregroundColor(Color(0xDCDCDD, alpha: 1.0))
            Image(getImageName(isR: true, mode_R: stepData.stepDetails[index].R_mode, mode_L: stepData.stepDetails[index].L_mode))
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(0x69af86, alpha: 1.0))
                .rotationEffect(Angle(degrees: stepData.stepDetails[index].R_angle),anchor: .center)
                .position(CGPoint(x: stepData.stepDetails[index].R_x/5-(deviceWidth/10),y: stepData.stepDetails[index].R_y/5-30))
                .frame(width: 15,height: 15)
            Image(getImageName(isR: false, mode_R: stepData.stepDetails[index].R_mode, mode_L: stepData.stepDetails[index].L_mode))
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(0xE5BD47, alpha: 1.0))
                .rotationEffect(Angle(degrees: stepData.stepDetails[index].L_angle),anchor: .center)
                .position(CGPoint(x: stepData.stepDetails[index].L_x/5-(deviceWidth/10),y: stepData.stepDetails[index].L_y/5-30))
                .frame(width: 15,height: 15)
        }
        .frame(width:deviceWidth/5,height:60)
    }
}

//struct OverView_Previews: PreviewProvider {
//    static var previews: some View {
//        OverView()
//    }
//}


//location_R: CGPoint(x: stepData.stepDetails[row].R_x/5-(deviceWidth/10),
//                    y: stepData.stepDetails[row].R_y/5-30),
