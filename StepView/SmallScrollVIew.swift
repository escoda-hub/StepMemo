//
//  SmallScrollVIew.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/11.
//

import SwiftUI

struct SmallScrollVIew: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State  private var isDarkMode = true
    
    @Binding var stepData:Step
    @Binding var location_L :CGPoint
    @Binding var location_R :CGPoint
    @Binding var angle_L :Angle
    @Binding var angle_R :Angle
    @Binding var mode_L :Int
    @Binding var mode_R :Int
    @Binding var indexSmallView:Int
    @Binding var showingAlert:Bool
    @Binding var memoText:String
    
    @State var proxy: ScrollViewProxy?
    
    var body: some View {

        let deviceWidth = DisplayData.deviceWidth
        let isDarkMode = appEnvironment.isDark
        
        ScrollView(.horizontal){
            ScrollViewReader { proxy in
                HStack {
                    ForEach(stepData.stepDetails.indices, id: \.self) { row in
                        VStack(spacing: 0){
                            ZStack {
                                    ZStack {
                                        Rectangle()
                                            .ignoresSafeArea(.all)
                                            .foregroundColor(isDarkMode ? ComponentColor_StepView.SmallScroll_dark : ComponentColor_StepView.SmallScroll_light)
                                        Image(getImageName(isR: true, mode_R: stepData.stepDetails[row].R_mode, mode_L: stepData.stepDetails[row].L_mode))
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(FootColor.right)
                                            .rotationEffect(Angle(degrees: stepData.stepDetails[row].R_angle),anchor: .center)
                                            .position(CGPoint(x: stepData.stepDetails[row].R_x/5-(deviceWidth/10)+10,y: stepData.stepDetails[row].R_y/5-30+5))
                                            .frame(width: 15,height: 15)
                                        Image(getImageName(isR: false, mode_R: stepData.stepDetails[row].R_mode, mode_L: stepData.stepDetails[row].L_mode))
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(FootColor.left)
                                            .rotationEffect(Angle(degrees: stepData.stepDetails[row].L_angle),anchor: .center)
                                            .position(CGPoint(x: stepData.stepDetails[row].L_x/5-(deviceWidth/10)+10,y: stepData.stepDetails[row].L_y/5-30+5))
                                            .frame(width: 15,height: 15)
                                    }
                                    .frame(width:deviceWidth/5,height:60)
//                                    .border(stepData.stepDetails[row].Order == indexSmallView ? Color.blue : Color.white, width: stepData.stepDetails[row].Order == indexSmallView  ? 2.0 : 0.0)
                                    .cornerRadius(2)
                                    .onTapGesture {
                                        indexSmallView = stepData.stepDetails[row].Order
                                        location_L = CGPoint(
                                            x: stepData.stepDetails[row].L_x,
                                            y: stepData.stepDetails[row].L_y)
                                        location_R = CGPoint(
                                            x: stepData.stepDetails[row].R_x,
                                            y: stepData.stepDetails[row].R_y)
                                        angle_L = Angle(degrees: stepData.stepDetails[row].L_angle)
                                        angle_R = Angle(degrees: stepData.stepDetails[row].R_angle)
                                        mode_L = stepData.stepDetails[row].L_mode
                                        mode_R = stepData.stepDetails[row].R_mode
                                        memoText = stepData.stepDetails[indexSmallView - 1].memo
                                    }
                                    .onLongPressGesture {
                                        indexSmallView = stepData.stepDetails[row].Order
                                        showingAlert = true
                                    }
//                                Text("\((stepData.stepDetails[row].Order+1)/2)")
                                Text("\(stepData.stepDetails[row].Order)")
                                    .foregroundColor(isDarkMode ? .white : .black)
//                                    .opacity(row%2 == 1 ? 0 : 1)
                            }
                            .id(row)
                        Rectangle()
                            .foregroundColor(isDarkMode ? ComponentColor_StepView.selectedLine_dark : ComponentColor_StepView.selectedLine_light)
                            .frame(height: 3)
                            .opacity(stepData.stepDetails[row].Order == indexSmallView  ? 1 : 0)
                            .padding(.bottom,3)
                        Image(systemName: row%2 == 1 ? "circle.fill":"circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width:10)
                            .foregroundColor(isDarkMode ? .white : .black)
                        }
                    }
                    .onChange(of: indexSmallView) { newValue in
                        let addIndex = newValue - 1
                        withAnimation{
                            proxy.scrollTo(addIndex, anchor: .center) // プロキシを使用してスクロールする
                        }
                        indexSmallView = stepData.stepDetails[addIndex].Order
                        location_L = CGPoint(
                            x: stepData.stepDetails[addIndex].L_x,
                            y: stepData.stepDetails[addIndex].L_y)
                        location_R = CGPoint(
                            x: stepData.stepDetails[addIndex].R_x,
                            y: stepData.stepDetails[addIndex].R_y)
                        angle_L = Angle(degrees: stepData.stepDetails[addIndex].L_angle)
                        angle_R = Angle(degrees: stepData.stepDetails[addIndex].R_angle)
                        mode_L = stepData.stepDetails[addIndex].L_mode
                        mode_R = stepData.stepDetails[addIndex].R_mode
                    }
                    .alert(isPresented: $showingAlert) { () -> Alert in
                        Alert(
                            title: Text("確認"),
                            message: Text("\(indexSmallView)番目のデータを削除してもよろしいですか？"),
                            primaryButton: .default(Text("Ok"),
                                action: {
                                    deleteStepDetail(step_id:stepData.id, index: indexSmallView)
                                    let updatedIndex = stepData.stepDetails.count == indexSmallView - 1 ?  stepData.stepDetails.count - 1 : indexSmallView - 1 //最後のstepDetailが削除されたときは、カウント-1のindexを設定する(our of range 回避)
                                    indexSmallView = stepData.stepDetails[updatedIndex].Order
                                    location_L = CGPoint(
                                        x: stepData.stepDetails[updatedIndex].L_x,
                                        y: stepData.stepDetails[updatedIndex].L_y)
                                    location_R = CGPoint(
                                        x: stepData.stepDetails[updatedIndex].R_x,
                                        y: stepData.stepDetails[updatedIndex].R_y)
                                    angle_L = Angle(degrees: stepData.stepDetails[updatedIndex].L_angle)
                                    angle_R = Angle(degrees: stepData.stepDetails[updatedIndex].R_angle)
                                    mode_L = stepData.stepDetails[updatedIndex].L_mode
                                    mode_R = stepData.stepDetails[updatedIndex].R_mode
                                    
                                }
                               ),
                            secondaryButton: .default(Text("キャンセル"))
                        )
                    }
                }
//                .padding(.horizontal)
            }
        }
    }
}
