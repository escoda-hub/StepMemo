//
//  InformationView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/18.
//

import SwiftUI

struct InformationView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    let InfoItems: [String] = [
        "チュートリアル",
        "設定",
        "プライバシーポリシー",
        "利用規約",
        "お問い合せ",
        "お知らせ",
        "評価する",
    ];
    
    var body: some View {
        
        VStack {
            Text("information")
            VStack {
                    List {
                        HStack{
                            Text("version")
                            Spacer()
                            Text("1.0.0")
                        }
                            ForEach(InfoItems, id: \.self) { InfoItem in
                                switch InfoItem {
                                case "チュートリアル":
                                    HStack{
                                        Button(action: {
                                            appEnvironment.path.append(Route.walkthroughView)
                                        }){
                                            VStack {
                                                Text("\(InfoItem)")
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        .navigationDestination(for: Route.self) { route in
                                            coordinator(route)
                                        }
                                        .frame(height: 30)
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                    }

                                default:
                                    NavigationLink(
                                        destination: Text("\(InfoItem)"),
                                        label: {
                                            VStack{
                                                Text("\(InfoItem)")
                                            }
                                            .padding()
                                        }
                                    )
                                        .frame(height: 30)
                                }
                            }
                          
                        

                        
                        
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        
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
