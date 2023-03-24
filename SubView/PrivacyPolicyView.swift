//
//  PrivacyPolicyView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/20.
//

import SwiftUI

struct PrivacyPolicyView: View {

    @EnvironmentObject var appEnvironment: AppEnvironment
    @State private var isDarkMode = true

    var body: some View {
        
        let isDarkMode = appEnvironment.isDark
        let privacyPolicyData: [PrivacyPolicy] = load("PrivacyPolicy.json") 
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDarkMode ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDarkMode ? 0 : 1)
            VStack {
                HStack {
                    Spacer()
                    Text("プライバシーポリシー")
                        .foregroundColor(isDarkMode ? .white : .black)
                    Spacer()
                }
                List {
                    Text(privacyPolicyData[0].content)
                        .font(.caption2)
                        .foregroundColor(isDarkMode ? .white : .black)
                        .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                    ForEach(1 ..< privacyPolicyData.count) { index in
                        VStack {
                            HStack {
                                Text("第\(privacyPolicyData[index ].order)条")
                                    .font(.headline)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .bold()
                                Text(privacyPolicyData[index].title)
                                    .font(.headline)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .bold()
                                Spacer()
                            }
                            Text(privacyPolicyData[index].content)
                                .font(.caption)
                                .foregroundColor(isDarkMode ? .white : .black)
                        }
                        .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                    }
                    HStack {
                        Spacer()
                        Text("以上")
                            .font(.subheadline)
                            .foregroundColor(isDarkMode ? .white : .black)
                    }
                    .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                    HStack{
                        Spacer()
                        Text(system.copyright)
                            .font(.caption2)
                            .foregroundColor(isDarkMode ? .white : .black)
                        Spacer()
                    }
                    .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                }
                .listRowSeparatorTint(isDarkMode ? .white : .gray)
            }
        }
        .scrollDisabled(false)
        .scrollContentBackground(.hidden)
        .onAppear(){
            print(privacyPolicyData.count)
        }
    }
}

//struct PrivacyPolicyView_Previews: PreviewProvider {
//    static var previews: some View {
//        PrivacyPolicyView()
//    }
//}
