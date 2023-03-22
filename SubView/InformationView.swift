//
//  InformationView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/18.
//

import SwiftUI

struct InformationView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State private var isDarkMode = true
    
    var body: some View {
        
        let InfoItems = InformationContent.Items
        let isDarkMode = appEnvironment.isDark
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDarkMode ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDarkMode ? 0 : 1)
            VStack {
                Text("information")
                    .foregroundColor(isDarkMode ? .white : .black)
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
                                                    case "debug":
                                                        appEnvironment.path.append(Route.debugView)
                                                    default:
                                                        appEnvironment.path.append(Route.walkthroughView)
                                                }
                                            }){
                                                VStack {
                                                    Text("\(InfoItem)")
                                                        .foregroundColor(isDarkMode ? .white : .black)
                                                }
                                            }
                                            .navigationDestination(for: Route.self) { route in
                                                coordinator(route)
                                            }
                                            .frame(height: 30)
                                            Spacer()
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(isDarkMode ? .white : .black)
                                        }
                                        .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                                    }
                                    .listRowSeparatorTint(isDarkMode ? .white : .gray)
                                    Spacer(minLength: 10)
                                        .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                                    }
                                    .scrollDisabled(false)
                                    .scrollContentBackground(.hidden)
                                    .padding(.horizontal)
                                    .padding(.bottom)
                                HStack{
                                    Text("StepDraft バージョン " + system.version)
                                        .font(.caption2)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                    }
                    .listStyle(.insetGrouped)
            }
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
