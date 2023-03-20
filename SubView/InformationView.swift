//
//  InformationView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/18.
//

import SwiftUI

struct InformationView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    let InfoItems = InformationContent.Items
    
    var body: some View {
        
        VStack {
            Text("information")
                .foregroundColor(.gray)
            VStack {
                    List {
                            ForEach(InfoItems, id: \.self) { InfoItem in

                                    HStack{
                                        Button(action: {
                                            switch InfoItem {
                                                case "チュートリアル":
                                                    appEnvironment.path.append(Route.walkthroughView)
                                                case "プライバシーポリシー":
                                                    appEnvironment.path.append(Route.privacyPolicyView)
                                                case "利用規約":
                                                    appEnvironment.path.append(Route.termsOfServiceView)
                                                case "お問い合せ":
                                                    if let url = URL(string: InformationContent.inquiryURL) {
                                                        UIApplication.shared.open(url, options: [.universalLinksOnly: false], completionHandler: {completed in
//                                                            print(completed)
                                                        })
                                                    }
                                                case "お知らせ":
                                                    appEnvironment.path.append(Route.noticeView)
                                                case "評価する":
                                                    if let url = URL(string: system.reviewURL) {
                                                        UIApplication.shared.open(url, options: [.universalLinksOnly: false], completionHandler: {completed in
//                                                            print(completed)
                                                        })
                                                    }
                                                default:
                                                    appEnvironment.path.append(Route.walkthroughView)
                                            }
                                        }){
                                            VStack {
                                                Text("\(InfoItem)")
                                                    .foregroundColor(.gray)
                                                    .listRowBackground(Color.orange)
                                            }
                                        }
                                        .navigationDestination(for: Route.self) { route in
                                            coordinator(route)
                                        }
                                        .frame(height: 30)
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            HStack{
                                Text("StepDraft バージョン " + system.version)
                                    .font(.caption2)
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
