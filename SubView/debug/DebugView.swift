//
//  DebugView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/22.
//

import SwiftUI

struct DebugView: View {
    @State private var jumpTo = ""
    
    var body: some View {
        ScrollViewReader { scrollProxy in       // ①ScrollViewProxyインスタンスを取得
            VStack {
                ScrollView {
                    VStack {
                        ForEach(1..<100) {
                            Text("\($0) 行目").font(.title)
                                .id($0)         // ②スクロール先を指定する為の一意のIDを指定
                        }
                    }
                }
                
                TextField("飛び先の番号を指定", text: $jumpTo,
                          onCommit: {
                            withAnimation {
                                /// ③scrollToメソッドで飛び先を指定
                                scrollProxy.scrollTo(Int(jumpTo))
                            }
                          })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
