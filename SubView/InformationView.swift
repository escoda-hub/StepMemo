//
//  InformationView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/18.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("要素1")
                Text("要素2")
            } .navigationTitle("タイトル")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            print("設定ボタンです")
                        }) {
                            Image(systemName: "gearshape.fill")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            print("マイページです")
                        }){
                            HStack {
                                Image(systemName: "person.fill")
                            }
                        }
                    }
                }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
