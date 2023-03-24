//
//  TermsOfServiceView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/20.
//　StepLogger/StepLogger/Doc/利用規約.md
//

import SwiftUI

struct TermsOfServiceView: View {

    @EnvironmentObject var appEnvironment: AppEnvironment
    @State private var isDarkMode = true
    
    var body: some View {
        
        let isDarkMode = appEnvironment.isDark
        let termsOfServiceData: [TermsOfService] = load("TermsOfService.json")
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDarkMode ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDarkMode ? 0 : 1)
            VStack {
                HStack {
                    Spacer()
                    Text("利用規約")
                        .foregroundColor(isDarkMode ? .white : .black)
                    Spacer()
                }
                List {
                    Text(termsOfServiceData[0].content)
                        .foregroundColor(isDarkMode ? .white : .black)
                        .font(.caption2)
                        .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                    ForEach(1 ..< termsOfServiceData.count) { index in
                        VStack {
                            HStack {
                                Text("第\(termsOfServiceData[index].order)条")
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.headline)
                                    .bold()
                                Text(termsOfServiceData[index].title)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.headline)
                                    .bold()
                                Spacer()
                            }

                            Text(termsOfServiceData[index].content)
                                .foregroundColor(isDarkMode ? .white : .black)
                                .font(.caption)
                        }
                        .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                    }
                    HStack {
                        Spacer()
                        Text("以上")
                            .foregroundColor(isDarkMode ? .white : .black)
                            .font(.subheadline)
                    }
                    .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                    HStack{
                        Spacer()
                        Text(system.copyright)
                            .foregroundColor(isDarkMode ? .white : .black)
                            .font(.caption2)
                        Spacer()
                    }
                    .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                }
                .listRowSeparatorTint(isDarkMode ? .white : .gray)
            }
        }
        .scrollDisabled(false)
        .scrollContentBackground(.hidden)
    }
}

struct TermsOfServiceView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceView()
    }
}
