//
//  StepListView_Condition.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/18.
//

import SwiftUI
import RealmSwift

struct StepListView_Condition: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var steps: Results<Step> = try! Realm().objects(Step.self)
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
                            ForEach(steps.freeze(), id: \.id) { step in
                                HStack {
                                    Button(action: {
                                        appEnvironment.path.append(Route.stepView(step))
                                    }){
                                        HStack {
                                                Text("\(step.title)")
                                                    .foregroundColor(isDarkMode ? .white : .black)
                                                    .font(.title2)
                                                Spacer()
                                                Text("\(step.stepDetails.count)")
                                                    .foregroundColor(.gray)
                                                    .font(.subheadline)
                                                Image(systemName: "chevron.forward")
                                                    .foregroundColor(isDarkMode ? .white : .black)
                                        }
                                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                            Button(role: .destructive) {
                                                deleteStep(step_id: step.id)
                                            } label: {
                                                Image(systemName: "trash.fill")
                                            }
                                        }
                                    }
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
                steps = getStepLists(mode: .all, groupID: "")
                title_jp = "全て"
            case "rescent":
                steps = getStepLists(mode: .rescent, groupID: "")
                title_jp = "最近"
            case "favorite":
                steps = getStepLists(mode: .favorite, groupID: "")
                title_jp = "好き"
            default:
                steps = getStepLists(mode: .all, groupID: "")
                title_jp = "全て"
            }
        }
    }
    
}
