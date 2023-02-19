//
//  SeleclGroupView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/19.
//

import SwiftUI

struct SeleclGroupView: View {
    @State private var selectedIndex = 0

    private let genre = ["hiphop", "house", "ballet"]
    
    var body: some View {
        
        List {
            Section {
                ForEach(genre, id: \.self) { genre in
                    ZStack {
                        NavigationLink(destination: StepListView(ViewTitle:genre)) {
                            Text(genre)
                        }
                        .opacity(0)
                        HStack {
                            Text("\(genre)")
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            } header: {
                Text("Group")
                    .font(.title)
            }
        }
        
    }
}

struct SeleclGroupView_Previews: PreviewProvider {
    static var previews: some View {
        SeleclGroupView()
    }
}
