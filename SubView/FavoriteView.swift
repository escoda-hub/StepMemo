//
//  FavoriteView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/22.
//

import SwiftUI

struct FavoriteView: View {
    
    @Binding var stepData:Step
    
    var body: some View {
        
        Button(action: {
            stepData = upDateFavorite(step_id: stepData.id)
        }, label: {
            if stepData.favorite {
                Image(systemName: "heart.fill")
                    .resizable()
                    .foregroundColor(.pink.opacity(0.8))
                    .frame(width:25,height:25)
            } else {
                Image(systemName: "heart")
                    .resizable()
                    .foregroundColor(.pink.opacity(0.8))
                    .frame(width:25,height:25)
            }
        })
        .frame(width: 30,height: 30)
        .foregroundColor(.black)
        .padding(.trailing)
        
    }
}

