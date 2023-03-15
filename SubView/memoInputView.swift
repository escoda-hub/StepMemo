//
//  memoInputView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/11.
//

import SwiftUI

struct memoInputView: View {
    
    @Binding var stepData:Step
    @Binding var showMemoView : Bool
    @State var index:Int
    
    var body: some View {
        VStack {
            Text("\(index)")
            TextField("メモ", text: $stepData.stepDetails[index - 1].memo,axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .lineLimit(3...5)
            Button("完了") {
                showMemoView = false
                stepData = updateMemo(step_id: stepData.id, index: index, memo: stepData.stepDetails[index - 1].memo)!
            }
        }
    }
}

//struct memoInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        memoInputView()
//    }
//}
