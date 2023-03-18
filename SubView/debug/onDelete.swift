//
//  onDelete.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/18.
//

import SwiftUI

struct onDelete: View {
    let languages: [String] = [
        "HTML",
        "CSS",
        "Javascript",
        "PHP",
        "Ruby",
        "Java",
        "C++",
        "C#",
        "Python",
        "Go",
        "Swift",
        "Kotlin",
        "Dart",
    ];
    
    var body: some View {
        List {
            ForEach(languages, id: \.self) { lang in
                Text(lang)
                    .swipeActions(edge: .leading) {
                        Button {
                            print("flag action.")
                            print(lang)
                        } label: {
                            Image(systemName: "flag.fill")
                        }.tint(.orange)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            print("delete action.")
                            print(lang)
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                    }
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
