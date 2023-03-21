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
    @State var terms : [Notice]
    
    
    init(terms: [Notice] = [Notice]()) {
        self.terms = initializeNotice()
    }
    
    var body: some View {
        
        let isDarkMode = appEnvironment.isDark
        
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
                    ForEach(0 ..< terms.count) { index in
                        VStack{
                            HStack{
                                Text(terms[index].title)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                            }
                            Spacer()
                            HStack {
                                Text(terms[index].content)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.footnote)
                                Spacer()
                            }
                            .frame(alignment: .leading)
                            Spacer()
                            HStack{
                                Spacer()
                                Text(terms[index].date)
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

func initializeNotice()->[Notice]{
    let terms : [Notice] = [
        Notice(title :"リリースに関するお知らせ", content : "StepDraft 1.0.0をリリースしました。",date:"2023/3/29")
    ]
    return terms
}
