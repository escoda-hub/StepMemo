//
//  SmallScrollVIew.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/11.
//

import SwiftUI

struct SmallScrollVIew: View {
    
    @State  var GroupName:String
    @State  var StepTitle:String
    
    @Binding var index:Int
    @Binding var stepData:Step
    @Binding var location_L :CGPoint
    @Binding var location_R :CGPoint
    @Binding var angle_L :Angle
    @Binding var angle_R :Angle
    @Binding var mode_L :Int
    @Binding var mode_R :Int
    @Binding var indexSmallView:Int
    @Binding var showingAlert:Bool
    
    @State var proxy: ScrollViewProxy?
    
//    init(GroupName: String, StepTitle: String,index:Binding<Int>,stepData: Binding<Step>, location_L: Binding<CGPoint>, location_R: Binding<CGPoint>, angle_L: Binding<Angle>, angle_R: Binding<Angle>, mode_L: Binding<Int>, mode_R: Binding<Int>, indexSmallView: Binding<Int>, showingAlert: Binding<Bool>) {
//        self.GroupName = GroupName
//        self.StepTitle = StepTitle
//        self._index = index
//        self._stepData = stepData
//        self._location_L = location_L
//        self._location_R = location_R
//        self._angle_L = angle_L
//        self._angle_R = angle_R
//        self._mode_L = mode_L
//        self._mode_R = mode_R
//        self._indexSmallView = indexSmallView
//        self._showingAlert = showingAlert
//    }
    
    var body: some View {
        
        let deviceWidth = UIScreen.main.bounds.width
        
        ScrollView(.horizontal){
            ScrollViewReader { proxy in
                HStack {
//                    Text("\(indexSmallView)")
                    ForEach(stepData.stepDetails.indices, id: \.self) { row in
                        VStack{
                            ZStack {
                                    ZStack {
                                        Rectangle()
                                            .ignoresSafeArea(.all)
                                            .foregroundColor(Color(0xDCDCDD, alpha: 1.0))
                                        Image(getImageName(isR: true, mode_R: stepData.stepDetails[row].R_mode, mode_L: stepData.stepDetails[row].L_mode))
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(Color(0x69af86, alpha: 1.0))
                                            .rotationEffect(Angle(degrees: stepData.stepDetails[row].R_angle),anchor: .center)
                                            .position(CGPoint(x: stepData.stepDetails[row].R_x/5-(deviceWidth/10)+10,y: stepData.stepDetails[row].R_y/5-30+5))
                                            .frame(width: 15,height: 15)
                                        Image(getImageName(isR: false, mode_R: stepData.stepDetails[row].R_mode, mode_L: stepData.stepDetails[row].L_mode))
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(Color(0xE5BD47, alpha: 1.0))
                                            .rotationEffect(Angle(degrees: stepData.stepDetails[row].L_angle),anchor: .center)
                                            .position(CGPoint(x: stepData.stepDetails[row].L_x/5-(deviceWidth/10)+10,y: stepData.stepDetails[row].L_y/5-30+5))
                                            .frame(width: 15,height: 15)
                                    }
                                    .frame(width:deviceWidth/5,height:60)
                                    .border(stepData.stepDetails[row].Order == indexSmallView ? Color.blue : Color.white, width: stepData.stepDetails[row].Order == indexSmallView  ? 2.0 : 0.0)
                                    .cornerRadius(2)
                                    .onTapGesture {
                                        index = row
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
                                    }
                                    .onLongPressGesture {
                                        indexSmallView = stepData.stepDetails[row].Order
                                        showingAlert = true
                                    }
//                                Text("\((stepData.stepDetails[row].Order+1)/2)")
                                Text("\(stepData.stepDetails[row].Order)")
//                                    .opacity(row%2 == 1 ? 0 : 1)
                            }
                            .id(row)
                        Image(systemName: row%2 == 1 ? "circle.fill":"circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width:10)
                        }
                    }
                    .onChange(of: indexSmallView) { newValue in
                        let addIndex = newValue - 1
                        withAnimation{
                            proxy.scrollTo(addIndex, anchor: .trailing) // プロキシを使用してスクロールする
                        }
                        index = addIndex
                        indexSmallView = stepData.stepDetails[addIndex].Order
                        print(index)
                        print(indexSmallView)
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
                                                        deleteStepDetail(groupName: GroupName, stepName: StepTitle, index: indexSmallView)
//                                                        index = indexSmallView
//                                                        indexSmallView = stepData.stepDetails[indexSmallView].Order
//                                                        location_L = CGPoint(
//                                                            x: stepData.stepDetails[indexSmallView].L_x,
//                                                            y: stepData.stepDetails[indexSmallView].L_y)
                                                        
                                                    }
                                                   ),
                            secondaryButton: .default(Text("キャンセル"))
                        )
                    }
                }
            }
        }
    }
}
