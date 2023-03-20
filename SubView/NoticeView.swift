//
//  NoticeView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/20.
//

import SwiftUI

struct NoticeView: View {
    
    @State var terms : [Notice]
    
    init(terms: [Notice] = [Notice]()) {
        self.terms = initializeNotice()
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Text("お知らせ")
                Spacer()
            }
            List {
                ForEach(0 ..< terms.count) { index in
                    VStack{
                        HStack{
                            Text(terms[index].title)
                                .font(.subheadline)
                                .bold()
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Text(terms[index].content)
                                .font(.footnote)
                            Spacer()
                        }
                        .frame(alignment: .leading)
                        Spacer()
                        HStack{
                            Spacer()
                            Text(terms[index].date)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(height: 80)
                }
            }
            HStack{
                Spacer()
                Text(system.copyright)
                    .font(.caption2)
                Spacer()
            }
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
