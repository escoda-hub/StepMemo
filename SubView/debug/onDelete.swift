//
//  onDelete.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/18.
//

import SwiftUI

struct onDelete: View {
    let languages: [String] = [
        "プライバシーポリシー",
        "利用規約",
        "バージョン",
        "お問い合せ",
        "使用方法",
    ];
    
    var body: some View {
        List {
            ForEach(languages, id: \.self) { lang in
                Text(lang)
            }
        }
        .listStyle(.plain)
    }
}

struct onDelete_Previews: PreviewProvider {
    static var previews: some View {
        onDelete()
    }
}
