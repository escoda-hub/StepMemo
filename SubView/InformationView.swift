//
//  InformationView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/18.
//

import SwiftUI

struct InformationView: View {
    @State var groupName:String
    @State var stepTitle:String
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("要素1")
                Text("要素2")
            }
            .onAppear(){
                print("hi")
                print(groupName)
                print(stepTitle)
            }
            .navigationTitle("タイトル")
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

//struct InformationView_Previews: PreviewProvider {
//    @State var stepdata = S
//    static var previews: some View {
//        InformationView(stepData: <#T##Step#>)
//    }
//}
