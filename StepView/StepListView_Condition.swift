//
//  StepListView_Condition.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/18.
//

import SwiftUI

struct StepListView_Condition: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var steps=[Step]()
    @State var title:String
    @State var title_jp = ""
    
    let deviceWidth = UIScreen.main.bounds.width
    let height = 300.0
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(title_jp)
                VStack {
                    if steps.isEmpty {
                        VStack {
                            Spacer()
                            Text("No steps found ...")
                            Spacer()
                        }
                    } else {
                        List {
                            ForEach(steps, id: \.id) { step in
                                HStack {
                                    Button(action: {
                                        appEnvironment.path.append(Route.stepView(step))
                                    }){
                                        VStack {
                                            HStack{
                                                Text("\(step.title)")
                                                    .foregroundColor(.black)
                                                    .font(.title2)
                                                Spacer()
                                            }
                                            HStack{
                                                Spacer()
                                                Text("\(step.stepDetails.count)move")
                                                    .foregroundColor(.black)
                                                    .font(.subheadline)
                                            }
                                        }
                                        .padding()
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                }
                                .frame(height: 50)
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(){
            switch title {
            case "all":
                steps = getStepList(mode: .all, group_id: "")
                title_jp = "全て"
            case "rescent":
                steps = getStepList(mode: .rescent, group_id: "")
                title_jp = "最近"
            case "favorite":
                steps = getStepList(mode: .favorite, group_id: "")
                title_jp = "好き"
            default:
                steps = getStepList(mode: .all, group_id: "")
                title_jp = "全て"
            }
        }
    }
    
}
