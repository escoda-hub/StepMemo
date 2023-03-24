//
//  NoticeView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/20.
//

import SwiftUI

struct NoticeView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State private var isDarkMode = true
    
    var body: some View {
        
        let isDarkMode = appEnvironment.isDark
        let noticeData: [Notice] = load("Notice.json")
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDarkMode ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDarkMode ? 0 : 1)
            VStack {
                HStack {
                    Spacer()
                    Text("お知らせ")
                        .foregroundColor(isDarkMode ? .white : .black)
                    Spacer()
                }
                List {
                    ForEach(0 ..< noticeData.count) { index in
                        VStack{
                            HStack{
                                Text(noticeData[index].title)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                            }
                            Spacer()
                            HStack {
                                Text(noticeData[index].content)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.footnote)
                                Spacer()
                            }
                            .frame(alignment: .leading)
                            Spacer()
                            HStack{
                                Spacer()
                                Text(noticeData[index].date)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                        .frame(height: 80)
                    }
 
                }
                .listRowSeparatorTint(isDarkMode ? .white : .gray)
                HStack{
                    Spacer()
                    Text(system.copyright)
                        .foregroundColor(isDarkMode ? .white : .black)
                        .font(.caption2)
                    Spacer()
                }
            }
            .scrollDisabled(false)
            .scrollContentBackground(.hidden)
        }
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView()
    }
}
