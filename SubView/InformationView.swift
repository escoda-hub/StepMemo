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

                                    HStack{
                                        Button(action: {
                                            switch InfoItem {
                                                case "チュートリアル":
                                                    appEnvironment.path.append(Route.walkthroughView)
                                                case "プライバシーポリシー":
                                                    appEnvironment.path.append(Route.walkthroughView)
                                                case "利用規約":
                                                    appEnvironment.path.append(Route.termsOfServiceView)
                                                case "お問い合せ":
                                                    if let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSeCHz6iSnSUZqpcm1JlRxibyYTU5cnBvvFr8Q2WzusuJg40Hw/viewform?usp=sf_link") {
                                                        UIApplication.shared.open(url, options: [.universalLinksOnly: false], completionHandler: {completed in
                                                            print(completed)
                                                        })
                                                    }
                                                case "お知らせ":
                                                    appEnvironment.path.append(Route.walkthroughView)
                                                case "評価する":
                                                    appEnvironment.path.append(Route.walkthroughView)
                                                default:
                                                    appEnvironment.path.append(Route.walkthroughView)
                                            }
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
                                }
                            }
                }
                .listStyle(.insetGrouped)
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
