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
    @State  private var isDarkMode = true
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        
        let deviceWidth = DisplayData.deviceWidth
        let height = DisplayData.height
        let isDarkMode = appEnvironment.isDark
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDarkMode ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDarkMode ? 0 : 1)
            VStack {
                HStack {
                    Spacer()
                    Text(title_jp)
                    Text("(\(steps.count))")
                    Spacer()
                }
                .foregroundColor(isDarkMode ? .white : .black)
                VStack {
                    if steps.isEmpty {
                        VStack {
                            Spacer()
                            Text("No steps found ...")
                                .foregroundColor(isDarkMode ? .white : .black)
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
                                                    .foregroundColor(isDarkMode ? .white : .black)
                                                    .font(.title2)
                                                Spacer()
                                            }
                                            HStack{
                                                Spacer()
                                                Text("\(step.stepDetails.count)move")
                                                    .foregroundColor(.gray)
                                                    .font(.subheadline)
                                            }
                                        }
                                        .padding()
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                                .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                                .frame(height: 40)
                            }
                            .listRowSeparatorTint(isDarkMode ? .white : .gray)
                            Spacer(minLength: 10)
                                .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                        }
                        .scrollDisabled(false)
                        .scrollContentBackground(.hidden)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    appEnvironment.path.append(Route.walkthroughView)
                }){
                    VStack {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(isDarkMode ? .white : .black)
                    }
                }
            }
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
