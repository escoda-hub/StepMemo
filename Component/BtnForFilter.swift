//
//  BtnForFilter.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/21.
//

import SwiftUI

struct BtnForFilter: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var imageSize:Int
    @State var mode: filterMode
    
    @State var systemImage = ""
    @State var text = ""
    @State var color = ComponentColor.rescentBtn
    
    var body: some View {
        
        let isDark = appEnvironment.isDark
        
        VStack {
            VStack {
                Image(systemName: systemImage)
                    .foregroundColor(.black)
                    .font(.system(size: CGFloat(imageSize)))
            }
            .frame(width: CGFloat(imageSize) * 2, height: CGFloat(imageSize) * 2)
            .background(color)
            .cornerRadius(CGFloat(imageSize))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            Text(text)
                .font(.callout)
                .foregroundColor(isDark ? .white : .black)
        }
        .onAppear(){
            let FilterData = getFilterData(mode: mode)
            systemImage = FilterData.systemImage
            text = FilterData.text
            color = FilterData.color
        }
    }
}

struct BtnForFilter_Previews: PreviewProvider {
    
    @State static var imageSize = 50
    @State static var mode = filterMode.favorite
    
    static var previews: some View {
        BtnForFilter(imageSize: imageSize,mode: mode)
    }
}

func getFilterData(mode:filterMode)->(systemImage:String, text:String,color:Color){
    switch mode {
    case .all:
        return ("list.bullet","全て",ComponentColor.allBtn)
    case .rescent:
        return ("calendar","最近",ComponentColor.rescentBtn)
    case .favorite:
        return ("heart","好き",ComponentColor.favoriteBtn)
    case .groupID:
        return ("list.bullet","全て",ComponentColor.allBtn)
    }
}
