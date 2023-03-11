//
//  InformationView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/18.
//

import SwiftUI

//struct InformationView: View {
//
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("要素1")
//                Text("要素2")
//            }
//            .onAppear(){
//                print("hi")
// 
//            }
//            .navigationTitle("タイトル")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button(action: {
//                            print("設定ボタンです")
//                        }) {
//                            Image(systemName: "gearshape.fill")
//                        }
//                    }
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            print("マイページです")
//                        }){
//                            HStack {
//                                Image(systemName: "person.fill")
//                            }
//                        }
//                    }
//                }
//        }
//    }
//}



struct InformationView: View {
    @State private var isPresented = false
    
    var body: some View {
        Button("Show Modal") {
            self.isPresented.toggle()
        }
        .sheet(isPresented: $isPresented) {
            ModalView()
                .background(Color.white.opacity(0.5))
        }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            Text("This is a modal view.")
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
    }
}
