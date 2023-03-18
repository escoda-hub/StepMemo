//
//  StepListView_Condition.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/18.
//

import SwiftUI

struct StepListView_Condition: View {
    
        @State var groupName = "All"
        @State var steps: [Step]
        @State var deviceWidth:Double
        @State var height:Double
        
        init(deviceWidth: Double, height: Double) {
            self.deviceWidth = deviceWidth
            self.height = height
            self.steps = getAllStepList()
        }
        
        var body: some View {
            ZStack {
                VStack {
                    Text("All")
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
                                    NavigationLink(
                                        destination: WalkthroughView(),
                                        label: {
                                            VStack{
                                                Text("\(step.title)")
                                            }
                                            .padding()
                                        }
                                    )
                                }
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
//                            addStep(name: groupName,deviceWidth: deviceWidth,height: height)
//                            steps.fetchSteps()
                        }, label: {
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                        })
                        .frame(width: 60, height: 60)
                        .background(Color.orange)
                        .cornerRadius(30.0)
                        .shadow(color: .gray, radius: 3, x: 3, y: 3)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
                    }
                }
            }
            .onAppear(){
                steps = getAllStepList()
            }
        }
    }


